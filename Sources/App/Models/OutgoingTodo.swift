//
//  OutgoingTodo.swift
//  App
//
//  Created by Samuel Francis on 9/3/18.
//

import Vapor

extension Todo {
    struct Outgoing: Content {
        var id: Int?
        var title: String?
        var completed: Bool?
        var order: Int?
        var url: String
    }
}

extension Todo {
    func makeOutgoing(with req: Request) throws -> Outgoing {
        let idString = id?.description ?? ""
        let url = req.baseURL + idString
        return Outgoing(id: id,
                        title: title,
                        completed: completed,
                        order: order,
                        url: url
        )
    }
}

extension Future where T == Todo {
    func makeOutgoing(with req: Request) -> Future<Todo.Outgoing> {
        return map { try $0.makeOutgoing(with: req) }
    }
}

extension Future where T == [Todo] {
    func makeOutgoing(with req: Request) throws -> Future<[Todo.Outgoing]> {
        return map {
            try $0.map {
                try $0.makeOutgoing(with: req)
            }
        }
    }
}


