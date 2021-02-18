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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        let checkResult = checkUserData()
            
        if !checkResult {
            showLoginError()
        }
        return checkResult
    }
    
    func checkUserData() -> Bool {
        guard let login = loginInput.text,
              let password = passwordInput.text else { return false }
        
        if login == "admin" && password == "123456" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        let alert = UIAlertController(title: "Login error", message: "Wrong login or password!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
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

