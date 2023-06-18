//
//  Lawyer.swift
//  
//
//  Created by Adilet on 17/6/23.
//

import Vapor
import Fluent

final class Lawyer: Model, Content {
    
    static let schema: String = "lawyers"
    
    @ID var id: UUID?
    @Field(key: "name") var name: String
    @Field(key: "login") var login: String
    @Field(key: "password") var password: String
    @Field(key: "direction") var direction: String
    @Field(key: "experience") var experience: String
//    @Field(key: "profilePic") var profilePic: String?
    
    final class Public: Content {
        var id: UUID?
        var name: String
        var login: String
        var direction: String
        var experience: String
//        var profilePic: String?
        
        init(id: UUID? = nil, name: String, login: String, direction: String, experience: String
//             profilePic: String? = nil
        ){
            self.id = id
            self.name = name
            self.login = login
            self.direction = direction
            self.experience = experience
//            self.profilePic = profilePic
        }
        
    }
    
}

extension Lawyer {
    
    func convertToPublic() -> Lawyer.Public{
        let pub = Lawyer.Public(id: self.id,
                                name: self.name,
                                login: self.login,
                                direction: self.direction,
                                experience: self.experience
//                                profilePic: self.profilePic
        )
        return pub
    }
}


enum Directions: String {
    case arbitration = "Арбитражные дела"
    case civil = "Гражданское прав"
    case criminal = "Уголовные дела"
    case land = "Земельные вопросы"
    case tax = "Споры с налоговой"
    case labor = "Трудовой кодекс"
    case inheritance = "Наследственные дела"
    
}
