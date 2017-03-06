//
//  Article.swift
//  fta
//
//  Created by Johann Kerr on 2/23/17.
//
//

import Foundation
import Fluent
import Vapor

enum ArticleType {
    case student
    case instructor
}


final class Article: Model {
    var id: Node?
    var exists: Bool = false
    var url: String
    var author: String
    
    
    
    init(url: String, author: String) {
        self.url = url
        self.author = author
        
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        url = try node.extract("url")
        author = try node.extract("author")
    }
    
    func makeNode(context : Context) throws -> Node {
        return try Node(node: ["id": id,
                     "url": url,
                     "author": author
            ])
    }
    
}


extension Article {
    static func prepare(_ database: Database) throws {
        try database.create("articles") { articles in
            articles.id()
            articles.string("url")
            articles.string("author")
            
            
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("articles")
    }
}
