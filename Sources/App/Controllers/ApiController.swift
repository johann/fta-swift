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
    let learnURL = "https://learn.co/api/"
    var drop: Droplet
    
    init(_ drop: Droplet) {
        self.drop = drop
        self.addRoutes()
    }
    
    
    func addRoutes() {
        let token = drop.config["learn", "token"]?.string ?? ""
        do {
            let response = try drop.client.get("\(learnURL)batches/473/users?pageSize=40", headers: ["Authorization":"Bearer \(token)", "Accept":"version=1"])
            if let userArray = response.data["users"]?.array {
                for user in userArray {
                    if let userDict = user.object {
                        userDict
                    }
                }
            }
            
//            for user in userArray! {
//                if let userDict = user.object {
//
//                }   
//                
//            }
            
        } catch {
            
        }
        
        
        
        
    }
    
    
}
