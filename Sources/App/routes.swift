import Vapor
import FluentSQLite

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It was very simple to run this app!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, my world!"
    }
    
    router.get("hello", "Prasen") { req in
        return "Hello, in my world Prasen!"
    }
    
    router.get("hello", Int.parameter) { req -> String    in
        let name = try req.parameters.next(Int.self)
        return "Hello, in my world \(name)"
    }
    
    router.get("api","superheroes") { req -> Future<[SuperHuman]> in
        return SuperHuman.query(on: req).all()
    }
    
    router.post("api","superheroes") { req -> Future<SuperHuman> in
        let hero = try req.content.syncDecode(SuperHuman.self)
        return hero.save(on: req)
    }
    
    router.get("api","superheroes", SuperHuman.parameter) { req -> Future<SuperHuman> in
        return try req.parameters.next(SuperHuman.self)
    }

    router.get("api", "superheroes", "search") { req -> Future<[SuperHuman]> in
        guard let searchName = req.query[String.self, at:"term"] else{
            throw Abort(.badRequest)
        }
        print(searchName)
        return SuperHuman.query(on: req).filter(\.name == searchName).all()
    }

    
    router.get("api", "projects", "search") { req -> Future<[Project]> in
        guard let searchName = req.query[String.self, at:"term"] else{
            throw Abort(.badRequest)
        }
        print(searchName)
        return Project.query(on: req).filter(\.name == searchName).all()
    }

    router.delete("api","superheroes", SuperHuman.parameter) { req -> Future <HTTPStatus> in
        return try req.parameters.next(SuperHuman.self).flatMap { todo in
            return todo.delete(on: req)
        }.transform(to: .ok)
    }
    


    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}
