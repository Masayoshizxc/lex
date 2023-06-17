//
//  LawyersController.swift
//  
//
//  Created by Adilet on 17/6/23.
//

import Fluent
import Vapor

struct LawyersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let lawyersGroup = routes.grouped("lawyers")
        lawyersGroup.post(use: createHandler)
        lawyersGroup.get(use: getAllHandler)
        lawyersGroup.get(":id", use: getHandler)
    }
    
    func createHandler(_ req: Request) async throws -> Lawyer.Public {
        let lawyer = try req.content.decode(Lawyer.self)
        lawyer.password = try Bcrypt.hash(lawyer.password)
        try await lawyer.save(on: req.db)
        return lawyer.convertToPublic()
    }
    
    func getAllHandler(_ req: Request) async throws -> [Lawyer.Public] {
        let lawyer = try await Lawyer.query(on: req.db).all()
        let publics = lawyer.map{ lawyer in
            lawyer.convertToPublic()
        }
        return publics
    }
    
    func getHandler(_ req: Request) async throws -> Lawyer.Public {
        guard let lawyer = try await Lawyer.find(req.parameters.get("id"), on: req.db)
        else {
            throw Abort(.notFound)
        }
        return lawyer.convertToPublic()
        
    }
    
    
    
}
