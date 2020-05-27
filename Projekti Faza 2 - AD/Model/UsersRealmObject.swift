//
//  UsersRealmObject.swift
//  Projekti Faza 2 - AD
//
//  Created by Cacttus Education 06 on 5/27/20.
//  Copyright © 2020 CacttusEducation. All rights reserved.
//

import UIKit

class UsersRealmObject: Object {
    @objc dynamic var id = "0"
    @objc dynamic var name = ""
    @objc dynamic var username = ""
    @objc dynamic var email = ""
    @objc dynamic var age = ""
}
