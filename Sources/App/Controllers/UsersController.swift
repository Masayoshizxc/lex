//
//  File.swift
//  
//
//  Created by Adilet on 7/6/23.
//

import Vapor
import Fluent

struct UsersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let usersGroup = routes.grouped("users")
        usersGroup.post(use: createHandler)
        usersGroup.get(use: getAllHandlers)
        usersGroup.get(":id", use: getHandler)
    }
    
    func createHandler(_ req: Request) async throws -> User.Public {
        let user = try req.content.decode(User.self)
        user.password = try Bcrypt.hash(user.password)
        try await user.save(on: req.db)
        return user.convertToPublic()
    }
    
    func getAllHandlers(_ req: Request) async throws -> [User.Public] {
        let users = try await User.query(on: req.db).all()
        let publics = users.map {user in
            user.convertToPublic()
        }
        return publics
    }
    
    func getHandler(_ req: Request) async throws -> User.Public {
        guard let user = try await User.find(req.parameters.get("id"), on: req.db)
        else{
            throw Abort(.notFound)
        }
        return user.convertToPublic()
    }
    
//    func delHandler(_ req: Request) async throws -> User.Public {
//        guard let user = try await User.delete(req.parameters.get("id"), on req.db)
//        else{
//            throw Abort(.custom(code: 111, reasonPhrase: "No users"))
//        }
//        return user.0
//    }
}
