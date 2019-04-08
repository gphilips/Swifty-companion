//
//  APIController.swift
//  Swifty-Companion
//
//  Created by Greg PHILIPS on 4/5/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

enum TypeAlert {
    case noConnection
    case invalidLogin
    case emptyField
}

class APIController {
    weak var delegate: API42Delegate?

    let UID_TOKEN: String = "da5c4900e4abcd452b21838514334b39ccc03c23d5bd17e18f1f149de78c23e2"
    let SECRET_TOKEN: String = "388154521cdfd3916ca56a24f494390659478b01d8817bbc0092d1fbdff247c7"
    let API_URL = "https://api.intra.42.fr"
    var tokenExpired: Double?
    var accessToken: String?

    init(delegate: API42Delegate?) {
        self.delegate = delegate
    }
    
    func getAccessToken() {
        SVProgressHUD.show()
        Alamofire.request(
            API_URL + "/oauth/token",
            method: .post,
            parameters: ["grant_type": "client_credentials", "client_id": UID_TOKEN, "client_secret": SECRET_TOKEN],
            encoding: JSONEncoding.default
            ).validate().responseJSON {
                response in
                SVProgressHUD.dismiss()
                switch response.result {
                    case .success:
                        let json = JSON(response.value!)
                        self.accessToken = json["access_token"].string
                        self.tokenExpired = json["created_at"].double! + json["expires_in"].double!
                        print("accessToken:", self.accessToken!)
                    case .failure(let error):
                        print(error)
                        if let vc = self.delegate {
                             vc.displayAlert(title: "Error", message: "There is a problem with your internet connection or the intra may be temporary down", typeAlert: TypeAlert.noConnection)
                        }
                }
        }
    }
    
    func getUser(login: String) {
        SVProgressHUD.show()
        if let expiredTime = self.tokenExpired, NSDate().timeIntervalSince1970 > expiredTime {
            self.getAccessToken()
        }

        Alamofire.request(
            API_URL + "/v2/users/" + login,
            method: .get,
            headers: ["Authorization": "Bearer \(self.accessToken!)"]
            ).validate().responseJSON {
                response in
                SVProgressHUD.dismiss()
                switch response.result {
                    case .success:
                        let json = JSON(response.value!)
                        if let vc = self.delegate {
                            if json.isEmpty {
                                vc.displayAlert(title: "No user found", message: "The login is invalid", typeAlert: TypeAlert.invalidLogin)
                            }
                            else {
                                vc.receiveUser(userData: json)
                            }
                        }

                    case .failure(let error):
                        print(error)
                        if let vc = self.delegate {
                            vc.displayAlert(title: "Error", message: "Please enter a login", typeAlert: TypeAlert.emptyField)
                        }
                }
        }
    }
    
}

