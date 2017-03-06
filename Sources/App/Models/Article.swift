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
    var cohort: String
    
    
    
    
    init(url: String, author: String, cohort:String) {
        self.url = url
        self.author = author
        self.cohort = cohort
        
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        url = try node.extract("url")
        author = try node.extract("author")
        cohort = try node.extract("cohort")
        
    }
    
    func makeNode(context : Context) throws -> Node {
        return try Node(node: ["id": id,
                     "url": url,
                     "author": author,
                     "cohort": cohort
            ])
    }
    
}


extension Article {
    static func prepare(_ database: Database) throws {
        try database.create("articles") { articles in
            articles.id()
            articles.string("url")
            articles.string("author")
            articles.string("cohort")
            
            
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("articles")
    }
}
