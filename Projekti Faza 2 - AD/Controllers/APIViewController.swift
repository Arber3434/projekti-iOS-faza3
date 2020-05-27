//
//  APIViewController.swift
//  Projekti Faza 2 - AD
//
//  Created by Cacttus Education 06 on 5/24/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit
import CoreData

class APIViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UserProtocol {
    
    @IBOutlet weak var loaderView: UIView!
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var usersArr: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsersTable()
        getAllUsers()
        
        if(UserDefaults.standard.bool(forKey: "FistTime") == false){
            getAllUsers()
            UserDefaults.standard.setValue(true, forKey: "FistTime")
        }else{
            getCoreData()
        }
    }
    
    func setUsersTable(){
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
    }
    
    func getAllUsers(){
         UserService.getUsers { (users, success, error) in
            if(success ?? false){
                 if let usersArr = users{
                     self.usersArr = usersArr
                     self.usersTableView.reloadData()
                 }
             }else{
             }
         }
     }
    
     func saveUsersCoreData(){
           let appDelegate = UIApplication.shared.delegate as? AppDelegate
           let context = appDelegate?.persistentContainer.viewContext
           
           let entity = NSEntityDescription.entity(forEntityName: "Users", in: context!)
           
           for i in 0...usersArr.count-1{
               if(i < 15){
                   let user = NSManagedObject(entity: entity!, insertInto: context)
                   user.setValue(usersArr[i].id, forKey: "id")
                   user.setValue(usersArr[i].userName, forKey: "username")
                   user.setValue(usersArr[i].email, forKey: "email")
                   user.setValue(usersArr[i].age, forKey: "age")
               }
           }
           do{
               try context?.save()
               print("User saved successfully!")
               getCoreData()
           }catch{
               print("saving failed")
           }
    }
    
    func deleteUser(id: String){
          
          let appDelegate = UIApplication.shared.delegate as? AppDelegate
          let context = appDelegate?.persistentContainer.viewContext
          
          let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
          request.predicate = NSPredicate(format: "id = %@", "\(id)")
          
          let results = try! context?.fetch(request)
          for user in ((results as? [NSManagedObject])!){
              context?.delete(user)
              
              do{
                  try context?.save()
                  getCoreData()
                  
              }catch{
                  print("deleting user failed")
              }
          }
      }
    
    func getCoreData(){
        
        usersArr.removeAll()
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate?.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do{
        let results = try context?.fetch(request)
            for user in ((results as? [NSManagedObject])!){
            let userCoreData = User()
                   userCoreData.id = (user.value(forKey: "id") as! String)
                   userCoreData.userName = (user.value(forKey: "username") as! String)
                   userCoreData.email = (user.value(forKey: "email") as! String)
                   userCoreData.age = (user.value(forKey: "age") as! String)
                
            usersArr.append(userCoreData)
                
            }
            usersTableView.reloadData()
            
        }catch{
            print("retrieving data failed")
        }
    }
    
    func getUserByID(id: String){
           UserService.getUserByID(id: id) { (success, user, error) in
               if(success){
                   if user != nil{
                       print("ID = \(user?.id ?? "")")
                       print("username = \(user?.userName ?? "")")
                       print("name = \(user?.name ?? "")")
                       print("email = \(user?.name ?? "")")
                   }
               }
           }
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getUserByID(id: usersArr[indexPath.row].id!)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as! UsersTableViewCell
        cell.addDetails(user: usersArr[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func editUser(user: User) {
            createAlertToUpdateUser(user: user)
    }
    
    func deleteUserByID(id: String) {
            showDeleteAlert(id: id)
        }
    
    func showDeleteAlert(id: String){
          let alert = UIAlertController(title: "Delete User", message: "Are you sure you want to delete this user?", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "YES", style: .destructive, handler: { (_) in
          }))
          alert.addAction(UIAlertAction(title: "NO", style: .default, handler: { (_) in
              self.deleteUser(id: id)
          }))
          self.present(alert, animated: true, completion: nil)
      }
    
func createAlertToUpdateUser(user: User){
        
        let alert = UIAlertController(title: "Update User", message: "Change the following fields to update a user:", preferredStyle: .alert)
        
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

func updateUser(user: User){
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let context = appDelegate?.persistentContainer.viewContext
    
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
    request.predicate = NSPredicate(format: "id = %@", "\(user.id!)")
    
    do{
        let results = try context?.fetch(request)
        for usr in ((results as? [NSManagedObject])!){
            
            usr.setValue(user.userName, forKey: "username")
            usr.setValue(user.email, forKey: "email")
            usr.setValue(user.age, forKey: "age")
            
            do{
                try context!.save()
                getCoreData()
            }catch{
                print("user update failed")
            }

        }
    }catch{
        print("retrieving data failed")
        }
    }
}
