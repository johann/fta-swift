//
//  Student.swift
//  fta
//
//  Created by Johann Kerr on 2/7/17.
//
//

import Foundation
import Vapor


final class Student: NodeRepresentable {
    
    var admin: Bool
    var email: String

    var fullName: String
    var github: String
    var activeTrackId: String
    var completedLessonCount: String
    
//    
//    "id": 47727,
//    "admin": false,
//    "email": "rrozenv@yahoo.com",
//    "first_name": "Robert",
//    "last_name": "Rozenvasser",
//    "github_username": "rrozenv",
//    "last_sign_in_at": "2017-02-14T08:38:24.659-05:00",
//    "active_track_id": 23034,
//    "completed_lesson_count_for_active_track": 15
    
    init(_ dict: [String: Polymorphic]) {
        let admin = dict["admin"]?.bool ?? false
        //print(admin)
        let email = dict["email"]?.string ?? ""
        let firstName = dict["first_name"]?.string ?? ""
        let lastName = dict["last_name"]?.string ?? ""
        let fullName = firstName + " " + lastName
        let github = dict["github_username"]?.string ?? ""
        let activeTrackId = dict["active_track_id"]?.string ?? ""
        let completedLessonCount = dict["completed_lesson_count_for_active_track"]?.string ?? ""
        
        self.admin = admin
        self.email = email
        self.fullName = fullName
        self.github = github
        self.activeTrackId = activeTrackId
        self.completedLessonCount = completedLessonCount
    }
    
    

    func makeNode(context: Context) throws -> Node {
        return try Node(node:["admin":admin,
                              "full_name":fullName])
    }
    
    
    
    
    
    
    
//    "id": 47727,
//    "admin": false,
//    "email": "rrozenv@yahoo.com",
//    "first_name": "Robert",
//    "last_name": "Rozenvasser",
//    "github_username": "rrozenv",
//    "last_sign_in_at": "2017-02-06T10:17:00.264-05:00",
//    "active_track_id": 23034,
//    "completed_lesson_count_for_active_track": 0
}
