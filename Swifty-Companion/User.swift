//
//  User.swift
//  Swifty-Companion
//
//  Created by Greg Philips on 06/04/2019.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    var profile = [ModelDelegate]()

    init(json: JSON) {
        self.profile.append(Infos(json: json))
        self.profile.append(Skills(json: json["cursus_users"][0]["skills"]))
        self.profile.append(Projects(json: json["projects_users"]))
    }

}
