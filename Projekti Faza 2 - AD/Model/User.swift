//
//  User.swift
//  Projekti Faza 2 - AD
//
//  Created by Cacttus Education 06 on 5/24/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject {

    var id: String?
    var name: String?
    var userName: String?
    var email: String?
    var age: String?
    
    static func userCreate(json: JSON) -> User?{
        let user = User()
        
        if let id = json["id"].string{
            user.id = id
            if let name = json["name"].string{
                   user.name = name
            }
            
            if let userName = json["username"].string{
                   user.userName = userName
            }
        
             if let email = json["email"].string {
                    user.email = email
            }
        
            if let age = json["age"].string {
                   user.age = age
            }
         
        }
        return user
    }
    
    static func userCreateArray(jsonArray: [JSON]) -> [User]?{
        var arrayOfUsers: [User] = []
        
        for jsonObj in jsonArray{
            if let user = User.userCreate(json: jsonObj){
                arrayOfUsers.append(user)
            }
        }
        return arrayOfUsers
    }
}
