//
//  File.swift
//  
//
//  Created by Adilet on 7/6/23.
//

import Vapor
import Fluent

final class User: Model, Content {
    static let schema: String = "users"
    
    @ID var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "login") var login: String
    @Field(key: "password") var password: String
//    @Field(key: "profilePic") var profilePic: String?
    
    final class Public: Content {
        var id: UUID?
        var name: String
        var login: String
//        var profilePic: String?
        
        init(id: UUID? = nil, name: String, login: String
//             profilePic: String? = nil
        ){
            self.id = id
            self.name = name
            self.login = login
//            self.profilePic = profilePic
        }
    }
    
}

extension User {
    
    func convertToPublic() -> User.Public{
        let pub = User.Public(id: self.id,
                              name: self.name,
                              login: self.login
//                              profilePic: self.profilePic
        )
        return pub
    }
}

extension User: ModelAuthenticatable {
    static let usernameKey = \User.$login
    static let passwordHashKey = \User.$password
    
    func verify(password: String) throws -> Bool {
        try Bcrypt.verify(password, created: self.password)
        
    }
    
}
