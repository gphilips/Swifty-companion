//
//  Protocol.swift
//  Swifty-Companion
//
//  Created by Greg Philips on 06/04/2019.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol API42Delegate: class {
    func receiveUser(userData: JSON)
    func displayAlert(title: String, message: String, typeAlert: TypeAlert)
}

enum ModelType {
    case info
    case skills
    case projects
}

enum ModelContentType {
    case Info
    case Skills
    case Projects
}

protocol ModelDelegate {
    var type: ModelType { get }
    var sectionTitle: String { get }
    var rowCount: Int { get }
}
