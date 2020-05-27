//
//  UsersRealmViewController.swift
//  Projekti Faza 2 - AD
//
//  Created by Cacttus Education 06 on 5/27/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit
import RealmSwift

class UsersRealmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var realm = try Realm()
    
    @IBOutlet weak var realmTableView: UITableView!
    
      func setUpTableView(){
          booksTable.delegate = self
          booksTable.dataSource = self
          booksTable.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return realm.objects(UsersRealmObject.self).count
      }
      
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let realmCell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as! BookCell
          realmCell.delegate = self
          let user = realm.objects(UsersRealmObject.self)[indexPath.row]
          realmCell.fillDetailsFromRealm(user: user)
          
          return realmCell
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let users = realm.objects(UsersRealmObject.self)[indexPath.row]
          getRealmFromRealmByID(id: users.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()

        if(UserDefaults.standard.bool(forKey: "FistTime") == false){
               getAllUsers()
               UserDefaults.standard.setValue(true, forKey: "FistTime")
        }else{
           }
    }
    
      
      func addUser(){
          let user = UsersRealmObject()
          user.id = "1"
          user.name = "New User"
          user.username = "New UserName"
          user.email = "newuser123@test.com"
          user.age = "32"
          
          try! realm.write{
              realm.add(user)
          }
          realmTableView.reloadData()
      }
    
     func getRealmUsers(){
           UserService.getUsers { (success, users, error) in
               if(success){
                   if let usersArr = users{
                self.saveNewUsersInRealm(users: usersArr)
                   }
               }else{
               }
           }
           
       }
    
     func saveNewUserseInRealm(users: [User]){
            for usrs in users{
                let users = UsersRealmObject()
                users.id = usrs.id ?? ""
                users.name = usrs.name ?? ""
                users.username = usrs.username ?? ""
                users.email = usrs.email ?? ""
                users.age = bk.age ?? ""
                                
                try! realm.write{
                    realm.add(users)
                }
            }
            
            booksTable.reloadData()
        }
    
    func createAlertToUpdateBook(user: User){
        
        let alert = UIAlertController(title: "Update User", message: "Update a user by changing the following fields:", preferredStyle: .alert)
        
        alert.addTextField { (userNameTextField) in
            userNameTextField.text = user.userName
        }
        
        alert.addTextField { (emailTextField) in
            emailTextField.text = user.email
        }
        
        alert.addTextField { (ageTextField) in
            ageTextField.text = "\(user.age ?? "")"
        }
        
        alert.addAction(UIAlertAction(title: "Update", style: .default, handler: { (_) in
                   
                   let usr = User()
                   usr.id = user.id
                   usr.userName = alert.textFields?[0].text
                   usr.email = alert.textFields?[1].text
                   usr.age = alert.textFields?[2].text

            self.updateUser(user: usr)
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { (_) in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateBookInRealm(user: UsersRealmObject){
          let userUpdate = realm.objects(UsersRealmObject.self).filter("id = \(user.id)").first
          
          try! realm.write{
              userUpdate?.name = user.name
              userUpdate?.username = user.username
              userUpdate?.email = user.email
              userUpdate?.age = user.age
          }
          
          realmTableView.reloadData()
      }

}
