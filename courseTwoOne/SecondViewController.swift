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
    @IBOutlet weak var scrolViewFirstWindow: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keybordOpen(_ :)), name: UIResponder.keyboardDidShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keybordClose(_ :)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func keybordOpen(_ notification: Notification) {

        let keyBoardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        guard let keyboardHeight = keyBoardSize?.height else {return}

        let indentOpen = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 100, right: 0)

        scrolViewFirstWindow.contentInset = indentOpen
        scrolViewFirstWindow.scrollIndicatorInsets = indentOpen
    }


    @objc func keybordClose(_ notification: Notification) {

        let indentClose = UIEdgeInsets.zero

        scrolViewFirstWindow.contentInset = indentClose
        scrolViewFirstWindow.scrollIndicatorInsets = indentClose
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }


    @IBAction func passLoginBatton(_ sender: Any) {

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
