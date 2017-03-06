//
//  ApiController.swift
//  fta
//
//  Created by Johann Kerr on 2/7/17.
//
//

import Foundation
import Vapor
import HTTP

final class ApiController {
    
   // https://flatiron-teacher-assistant.herokuapp.com/api/submitblog
    let learnURL = "https://learn.co/api/"
    var drop: Droplet
    
    init(_ drop: Droplet) {
        self.drop = drop
       // self.addRoutes()
    }
    
    
    func addDrop(_ drop: Droplet) {
        drop.get("students", handler:studentGroups)
        drop.post("api","submitblog", handler: submitBlog)
    }
    
    func submitBlog(request: Request) throws -> ResponseRepresentable {
        
//        token=gIkuvaNzQIHg97ATvDxqgjtO
//        team_id=T0001
//        team_domain=example
//        channel_id=C2147483705
//        channel_name=test
//        user_id=U2147483697
//        user_name=Steve
//        command=/weather
//        text=94070
//        response_url=https://hooks.slack.com/commands/1234/5678
        
        
        if let blogUrl = request.data["text"]?.string, let author = request.data["user_name"]?.string  {
            print(blogUrl)
            print(author)
            var blog = Article(url: blogUrl, author: author)
            try blog.save()
            
        } else {
            return "Bad Request"
        }
        
        
        return ""
    }
    
    func studentGroups(request: Request) throws -> ResponseRepresentable {
        var studentArray = [Student]()
        var groups = [[Student]]()
        let token = drop.config["learn", "token"]?.string ?? ""
        do {
            let response = try drop.client.get("\(learnURL)batches/473/users?pageSize=40", headers: ["Authorization":"Bearer \(token)", "Accept":"version=1"])
            if let userArray = response.data["users"]?.array {
                for user in userArray {
                    if let userDict = user.object {
                        let student = Student(userDict)
                        //print(student.fullName)
                        if !student.admin {
                            studentArray.append(student)
                        }
                       
                        
                        
                        
                        //print(userDict)
                    }
                }
                
                
                groups = formGroups(of: 2, from: studentArray)
                dump(groups)
                
                
                
            }
        
            
        } catch {
            
        }
        
        return groups as! ResponseRepresentable

    }
    
    
    func formGroups(of groupSize:Int, from studentGroup: [Student]) -> [[Student]] {
        var groups = [[Student]]()
        var students = studentGroup
        let numberOfGroups = studentGroup.count / groupSize
        for _ in 0...numberOfGroups {
            if students.isEmpty {
                
            } else {
                var group: [Student] = []
                for i in 1...groupSize {
                    let randomStudent = arc4random_uniform(UInt32(students.count))
                    print(randomStudent)
                    print(students.count)
                    group.append(students.remove(at: Int(randomStudent)))
                }
                groups.append(group)
            }
            
   
        }
        
        return groups
        
    }
    
    
    
}
