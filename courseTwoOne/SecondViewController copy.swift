//
//  SecondViewController.swift
//  courseTwoOne
//
//  Created by Andrey Vensko on 11.11.21.
//

import UIKit

class SecondViewController: UIViewController {

    let toOrangeWindow = "fromLoginToRassword"


    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!




    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keybordOpen(_ :)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }




    @objc func keybordOpen(_ notification: Notification) {




    }



    @IBAction func passLoginBatton(_ sender: Any) {


        let testString: NSString = "test test test"

        NotificationCenter.default.post(name: Notification.Name("pressLoginButton"), object: testString)


        guard let login = loginTextField.text,
              let passw = passwordTextField.text
        else {return}

        if login == "admin" && passw == "12345" {
            performSegue(withIdentifier: toOrangeWindow, sender: nil)
        } else {
            loginTextField.backgroundColor = UIColor.red
            passwordTextField.backgroundColor = UIColor.red
            return
        }
    }
}
