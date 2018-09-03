import Vapor

struct JSONExample: Content {
    let name: String
    let birthday: Date
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.get("json") { req -> JSONExample in
        JSONExample(name: "Sam", birthday: Date())
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.patch("todos", Todo.parameter, use: todoController.update)
    router.delete("todos", Todo.parameter, use: todoController.delete)
    router.delete("todos", use: todoController.clear)
    router.get("todos", Todo.parameter, use: todoController.view)
}
