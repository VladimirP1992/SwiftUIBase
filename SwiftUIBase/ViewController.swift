//
//  ViewController.swift
//  SwiftUIBase
//
//  Created by Владимир Поливников on 25.01.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hideKeyboardGesture = UITapGestureRecognizer (target: self, action: #selector(hideKeyboard))
        
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }


    @IBAction func loginButtonPressed(_ sender: Any) {
        let login = loginInput.text!
        let password = passwordInput.text!
        
        if login == "admin" && password == "12345" {
            print("Logined!")
        } else {
            print ("Wrong login or password!")
        }
    }
    
    //Scroll View resize while working with keyboard
    @objc func keyboardWasShown(notification: Notification) {

        let info = notification.userInfo! as! NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInserts = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)

        self.scrollView?.contentInset = contentInserts
        scrollView?.scrollIndicatorInsets = contentInserts
    }
    
    @objc func keyboardWillBeHidden(notification: Notification) {
        
        let contentInserts = UIEdgeInsets.zero
        scrollView?.contentInset = contentInserts
    }
    
    @objc func hideKeyboard() {
        scrollView?.endEditing(true)
    }
    
}

