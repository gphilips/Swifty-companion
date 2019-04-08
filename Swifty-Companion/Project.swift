//
//  Project.swift
//  Swifty-Companion
//
//  Created by Greg Philips on 06/04/2019.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import Foundation
import SwiftyJSON

class Project {
    var name: String?
    var finalMark: Int?
    var validate: Bool

    init(name: String?, finalMark: Int?, validate: Bool) {
        self.name = name
        self.finalMark = finalMark
        self.validate = validate
    }
}

class Projects: ModelDelegate {
    var projects = [Project]()

    var type: ModelType {
        return .projects
    }
    
    var sectionTitle: String {
        return "Projects"
    }
    
    var rowCount: Int {
        return projects.count
    }

    init(json: JSON) {
        for (_, subJson) in json {
            if subJson["project"]["parent_id"].int ?? 0 == 0 {
                self.projects.append(
                    Project(
                        name: subJson["project"]["name"].string,
                        finalMark: subJson["final_mark"].int,
                        validate: subJson["validated?"].bool ?? false
                    )
                )

            }
        }
    }
}
