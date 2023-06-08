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
    
    final class Public: Content {
        var id: UUID?
        var name: String
        var login: String
        
        init(id: UUID? = nil, name: String, login: String){
            self.id = id
            self.name = name
            self.login = login
        }
    }
    
}

extension User {
    
    func convertToPublic() -> User.Public{
        let pub = User.Public(id: self.id,
                              name: self.name,
                              login: self.login)
        return pub
    }
}
