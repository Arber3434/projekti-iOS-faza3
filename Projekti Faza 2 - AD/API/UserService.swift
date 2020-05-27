//
//  UserService.swift
//  Projekti Faza 2 - AD
//
//  Created by Cacttus Education 06 on 5/24/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserService: NSObject {

    class func getUser(completionHandler: @escaping(_ user: User?, _ success: Bool, _ error: Error?) -> Void){
        let urlString = "https://jsonfy.com/users"
        AF.request(urlString, method: .get, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let data):
            let jsonData = JSON(data)
            if let userCreate = User.userCreate(json: jsonData){
                completionHandler(userCreate, true, nil)
            }
            case .failure(let error):
                completionHandler(nil, false, error)
            }
        }
    }
    
    class func getUsers(completionHandler: @escaping( _ users: [User]?, _ success: Bool?, _ error: Error?) -> Void){
        let urlString = "https://jsonfy.com/users"
        AF.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            
            print("statusCode = \(response.response?.statusCode ?? 00)")
            
            switch response.result{
            case .success(let data):
                if let jsonArray = JSON(data).array{
                    if let users = User.userCreateArray(jsonArray: jsonArray){
                        completionHandler(users, true, nil)
                    }
                }
            case .failure(let error):
                print("error = \(error)")
                completionHandler(nil, false, error)
            }
        }
    }
    
    
    class func getUserByID(id: String, completionHandler: @escaping(_ success: Bool, _ user: User?, _ error: Error?) -> Void){
            let urlString = "https://jsonfy.com/users/\(id)"
                    
            AF.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                print("statusCode = \(response.response?.statusCode ?? 0)")

                switch response.result{
                case .success(let data):
                let jsonObj = JSON(data)
                
                if let user = User.userCreate(json: jsonObj){
                    completionHandler(true, user, nil)
                }
                    
                case .failure(let error):
                    print("error = \(error)")
                    completionHandler(false, nil, error)
                    
                }
            }
        }
    
    class func editUser(user: User, completionHandler: @escaping(_ success: Bool, _ user: User?, _ error: Error?) -> Void){
        let urlString = "https://jsonfy.com/users/\(user.id!)"
        print(urlString)
        
            
        AF.request(urlString, method: .put, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        print("statusCode = \(response.response?.statusCode ?? 0)")
                switch response.result{
                    case .success(let data):
                    let jsonObj = JSON(data)
                    print("edit user = \(jsonObj)")
                    if let book = User.userCreate(json: jsonObj){
                        completionHandler(true, book, nil)
                    }
                        
                    case .failure(let error):
                        print("error = \(error)")
                        completionHandler(false, nil, error)
                        
            }
        }
    }
}
