//
//  PersonalInfo.swift
//  Swifty-Companion
//
//  Created by Greg Philips on 06/04/2019.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Info {
    var login: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var phone: String?
    var level: Float?
    var levelPercent: Float?
    var grade: String?
    var campus: String?
    var location: String?
    var poolYear: String?
    var wallet: Int?
    var correctionPoint: Int?
    var image: UIImage?

    init(json: JSON) {
        self.login = json["login"].string
        self.firstName = json["first_name"].string
        self.lastName = json["last_name"].string
        self.email = json["email"].string
        self.phone = json["phone"].string
        self.level = json["cursus_users"][0]["level"].float
        self.levelPercent = json["cursus_users"][0]["level"].float?.truncatingRemainder(dividingBy: 1)
        self.grade = json["cursus_users"][0]["grade"].string
        self.campus = json["campus"][0]["name"].string
        self.location = json["location"].string
        self.poolYear = json["pool_year"].string
        self.wallet = json["wallet"].int
        self.correctionPoint = json["correction_point"].int
        self.image = setImage(image: json["image_url"].string!)
    }
    
    func setImage(image: String) -> UIImage {
        if !image.isEmpty {
            let url = URL(string: image)
            do {
                let data = try Data(contentsOf: url!)
                if let img = UIImage(data: data) {
                    return img
                }
            } catch {
                print("Error: Cannot load image")
            }
        } else {
            print("Error: Cannot find image")
        }
        return UIImage()
    }
}

class Infos: ModelDelegate {
    var infos = [Info]()
    
    var type: ModelType {
        return .info
    }
    
    var sectionTitle: String {
        return "Info"
    }
    
    var rowCount: Int {
        return infos.count
    }

    init(json: JSON) {
        self.infos.append(Info(json: json))
    }
}
