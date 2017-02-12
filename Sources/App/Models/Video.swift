//
//  Video.swift
//  fta
//
//  Created by Johann Kerr on 2/11/17.
//
//


import Vapor
import Foundation
import Fluent
import Foundation



final class Video: Model{
    var id: Node?
    var exists: Bool = false
    
    
    var title: String
    var url: String

    
    
    init(title:String, url:String) {
        self.title = title
        self.url = url
    }
    
    
    
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        title = try node.extract("title")
        url = try node.extract("url")
        
    }
    
    
    func makeNode(context: Context) throws -> Node {
        print("getting called")
        return try Node(node: [
            "id":id,
            "title":title,
            "url": url
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("videos"){ books in
            books.id()
            books.string("title")
            books.string("url")
        }
    }
    
    static func revert(_ database: Database) throws{
        try database.delete("videos")
    }
    
}






