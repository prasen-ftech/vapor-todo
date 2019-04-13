//
//  SuperHuman.swift
//  App
//
//  Created by Prasen Revankar on 13/04/19.
//

import Foundation
import FluentSQLite
import Vapor

final class SuperHuman: SQLiteModel{
    var id:Int?
    var name:String
    var universe:String
    
    init(name: String, universe:String){
        self.name = name
        self.universe = universe
    }
}

extension SuperHuman: Content{}
extension SuperHuman: Migration{}
extension SuperHuman: Parameter{}
