//
//  Project.swift
//  App
//
//  Created by Prasen Revankar on 13/04/19.
//

import Foundation
import FluentSQLite
import Vapor

final class Project: Codable{
    var id:Int?
    var name: String
    var desc: String
    
    init(name: String, desc:String){
        self.name = name
        self.desc = desc
    }
}

extension Project: SQLiteModel{}
extension Project: Content {}
extension Project: Migration {}
extension Project: Parameter { }

