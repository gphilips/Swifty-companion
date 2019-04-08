//
//  Skill.swift
//  Swifty-Companion
//
//  Created by Greg Philips on 06/04/2019.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Skill {
    var name: String?
    var level: Float?
    
    init(name: String?, level: Float?) {
        self.name = name
        self.level = level
    }
}

class Skills: ModelDelegate {
    var skills = [Skill]()
    var type: ModelType {
        return .skills
    }
    
    var sectionTitle: String {
        return "Skills"
    }
    
    var rowCount: Int {
        return skills.count
    }
    
    init(json: JSON) {
        for (_, subJson) in json {
            self.skills.append(
                Skill(
                    name: subJson["name"].string,
                    level: subJson["level"].float
                )
            )
        }
    }
}
