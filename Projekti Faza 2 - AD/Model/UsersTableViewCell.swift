//
//  UsersTableViewCell.swift
//  Projekti Faza 2 - AD
//
//  Created by Cacttus Education 06 on 5/24/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//


protocol UserProtocol {
    func editUser(user: User)
    func deleteUser(id: String)
}

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var usr: User?
    var delegate: UserProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func addDetails(user: User){
        usr = user
        userIdLabel.text = "\(user.id!)"
        nameLabel.text = user.name
        emailLabel.text = user.email
        userNameLabel.text = user.userName
        ageLabel.text = user.age
    }

    @IBAction func deleteTouched(_ sender: Any) {
         delegate?.deleteUser(id: usr!.id!)
    }
    @IBAction func updateTouched(_ sender: Any) {
         delegate?.editUser(user: usr!)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
