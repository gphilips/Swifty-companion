//
//  ViewController.swift
//  Swifty-Companion
//
//  Created by Greg PHILIPS on 4/5/19.
//  Copyright © 2019 Greg PHILIPS. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, API42Delegate, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buttonView: UIButton!
    
    var API: APIController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.textField.delegate = self
        self.API = APIController(delegate: self)
        self.API?.getAccessToken()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sendLogin(_ sender: UIButton) {
       self.fetchUser()
    }
    
    @IBAction func textFieldAction(_ sender: UITextField) {
        self.fetchUser()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedChars = CharacterSet.letters
        let charSet = CharacterSet(charactersIn: string)
        return allowedChars.isSuperset(of: charSet)
    }

    func fetchUser() {
        self.textField.endEditing(true)
        if let login = self.textField.text, !login.isEmpty {
            buttonView.isEnabled = false
            self.API?.getUser(login: login)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func receiveUser(userData: JSON) {
        buttonView.isEnabled = true
        let user = User(json: userData)
        performSegue(withIdentifier: "goToProfile", sender: user)
    }

    func displayAlert(title: String, message: String, typeAlert: TypeAlert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        switch typeAlert {
            case .noConnection:
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (action) in
                    self.API?.getAccessToken()
                    alert.dismiss(animated: true, completion: nil)
                }))
            case .emptyField:
                alert.addAction(UIAlertAction(title: "OK", style: .default))
            case .invalidLogin:
                alert.addAction(UIAlertAction(title: "Dismiss", style: .default))
            }
        buttonView.isEnabled = true
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToProfile" {
            if let profileVC = segue.destination as? ProfileViewController, let user = sender as? User {
                profileVC.sections = user.profile
            }
        }
    }
}

