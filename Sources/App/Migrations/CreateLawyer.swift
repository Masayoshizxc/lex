//
//  File.swift
//  
//
//  Created by Adilet on 17/6/23.
//

import Fluent
import Vapor

struct CreateLawyer: AsyncMigration {
    func prepare(on database: FluentKit.Database) async throws {
        let schema = database.schema("lawyers")
            .id()
            .field("name", .string, .required)
            .field("login", .string, .required)
            .field("password", .string, .required)
            .field("direction", .string, .required)
            .field("experience", .string, .required)
//            .field("profilePic", .string)
        try await schema.create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("lawyers").delete()
    }
    
    
}
