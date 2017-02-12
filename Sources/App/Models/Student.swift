//
//  Student.swift
//  fta
//
//  Created by Johann Kerr on 2/7/17.
//
//

import Foundation
import Vapor


final class Student {
    
    var admin: Bool
    var email: String

    var fullName: String
    var github: String
    var activeTrackId: String
    var completedLessonCount: String
    
    
    init(_ dict: [String: Polymorphic]) {
        let admin = dict["admin"]?.bool ?? false
        let email = dict["email"]?.string ?? ""
        let fullName = dict["fullName"]?.string ?? ""
        let github = dict["github"]?.string ?? ""
        let activeTrackId = dict["activeTrackId"]?.string ?? ""
        let completedLessonCount = dict["completedLessonCount"]?.string ?? ""
        
        self.admin = admin
        self.email = email
        self.fullName = fullName
        self.github = github
        self.activeTrackId = activeTrackId
        self.completedLessonCount = completedLessonCount
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
