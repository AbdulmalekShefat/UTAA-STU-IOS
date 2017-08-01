//
//  LoginViewController.swift
//  UTAASTU
//
//  Created by Abdulmalek S. A. Shefat on 23/07/2017.
//  Copyright © 2017 MSL Dev. All rights reserved.
//

import UIKit
import Firebase
import KRProgressHUD

class LoginViewController: UIViewController, UITextFieldDelegate {
   
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    @IBOutlet weak var loginImage: UIImageView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var progressHUD: ProgressHUD!
    
    
    var passTextField: UITextField!
    var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        progressHUD = ProgressHUD(text: "connecting... please wait", color: UIColor.MaterialColors.SignIn.redA700)
        progressHUD.hide()
        self.view.addSubview(progressHUD)
        
        CustomizeView.dropShadow(layer: loginImage.layer)
        CustomizeView.dropShadow(layer: signUpButton.layer,radius: 1, height: 0, width: 0)
        CustomizeView.dropShadow(layer: signInButton.layer,radius: 1, height: 0, width: 0)
        
        setButtonTouchListener(button: signUpButton)
        setButtonTouchListener(button: signInButton)
        
    }
    
    // MARK: Views
    
    func setButtonTouchListener(button: UIButton){
        button.addTarget(self, action: #selector(holdRelease(sender:)), for: UIControlEvents.touchUpInside)
        button.addTarget(self, action: #selector(holdDown(sender:)), for: UIControlEvents.touchDown)
    }
    
    func holdDown(sender: UIButton){
        CustomizeView.dropShadow(layer: sender.layer,radius: 4, height: 0, width: 0)
    }
    
    func holdRelease(sender: UIButton){
        CustomizeView.dropShadow(layer: sender.layer,radius: 1, height: 0, width: 0)
    }
    
    // MARK: ScrollView & TextFields Fix
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
    
    func didTapView(gesture: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    func addObservers(){
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: nil){
            notification in
            self.keyboardWillShow(notification: notification)
        }
        NotificationCenter.default.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: nil){
            notification in
            self.keyboardWillHide(notification: notification)
        }
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification){
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        scrollView.contentInset = contentInset
    }
    
    func keyboardWillHide(notification: Notification){
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField{
            nextField.becomeFirstResponder()
        }else{
            textField.resignFirstResponder()
        }
        
        return false
    }
    
    // MARK: StatysBar Style Change
    
    override var preferredStatusBarStyle : UIStatusBarStyle{
        return .default
    }
    
    func didSignIn() {
        progressHUD.hide()
        KRProgressHUD.showSuccess(withMessage: "Welcome :)")
        let homeViewController = self.storyboard?.instantiateViewController(withIdentifier: "RootViewController")
        self.present(homeViewController!, animated: true, completion: nil)
    }
    
    // MARK: Buttons
    
    @IBAction func didClickSignUp(_ sender: Any) {
        if emailField.text == "" || passwordField.text == "" {
            KRProgressHUD.showError(withMessage: "all fields are required")
        }else {
            let confirmation = UIAlertController(title: "Confirm Password", message: "enter the same password to create the account", preferredStyle: .alert)
            
            confirmation.addTextField { (passTextField) in
                passTextField.placeholder = "password"
                passTextField.isSecureTextEntry = true
                self.passTextField = passTextField                
            }
            let cancelAction = UIAlertAction(title: "cancel", style: .cancel){(action) in
                
            }
            
            let okAction = UIAlertAction(title: "signup", style: .default){(action) in
            
                if self.passTextField.text != self.passwordField.text {
                    KRProgressHUD.showError(withMessage: "passwords don't match")
                }else{
                    self.progressHUD.text = "Creating the account..."
                    self.progressHUD.show()
                    Auth.auth().createUser(withEmail: self.emailField.text!, password: self.passwordField.text!){
                        (user, error) in
                        
                        if error != nil {
                            
                            self.progressHUD.hide()
                            
                            if let errorCode = AuthErrorCode(rawValue: (error?._code)!){
                                
                                let string: String = FirebaseHelper.error2String(error: errorCode)
                                KRProgressHUD.showError(withMessage: string)
                                
                            }
                        }else{
                            
                            self.didSignIn()
                        
                        }
                                    
                    }
                }
            
            }
            
            confirmation.addAction(cancelAction)
            confirmation.addAction(okAction)
            
            confirmation.view.tintColor = UIColor.MaterialColors.Accent.orangeA700
            self.present(confirmation, animated: true, completion: nil)
            confirmation.view.tintColor = UIColor.MaterialColors.Accent.orangeA700
            
        }
    
    }
    
    
    @IBAction func didClickSignIn(_ sender: Any) {
        if emailField.text == "" || passwordField.text == "" {
            KRProgressHUD.showError(withMessage: "all fields are required")
        }else{
            self.progressHUD.text = "Signing in..."
            self.progressHUD.show()
            Auth.auth().signIn(withEmail: self.emailField.text!, password: self.passwordField.text!){
                (user, error) in
                
                if (error != nil) {
                    
                    self.progressHUD.hide()
                    
                    if let errorCode = AuthErrorCode(rawValue: (error?._code)!){
                    
                    let string: String = FirebaseHelper.error2String(error: errorCode)
                    KRProgressHUD.showError(withMessage: string)
                    
                    }
                }else{
                    
                    self.didSignIn()
                    
                }
                
            }
        }
    
    }
    
    @IBAction func didForgetPassword(_ sender: Any) {
        
        let confirmation = UIAlertController(title: "Enter Email", message: "enter the email to reset password", preferredStyle: .alert)
        
        confirmation.addTextField { (emailTextField) in
            emailTextField.placeholder = "example@domain.com"
            self.emailTextField = emailTextField
        }
        
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel){(action) in
            
        }
        
        let okAction = UIAlertAction(title: "reset", style: .default){(action) in
            
            if self.emailTextField.text == "" {
                KRProgressHUD.showError(withMessage: "email can't be empty")
            }else{
                self.progressHUD.text = "sending reset email..."
                self.progressHUD.show()
                Auth.auth().sendPasswordReset(withEmail: self.emailTextField.text!){
                    error in
                    
                    if (error != nil) {
                        
                        self.progressHUD.hide()
                        
                        if let errorCode = AuthErrorCode(rawValue: (error?._code)!){
                            
                            let string: String = FirebaseHelper.error2String(error: errorCode)
                            KRProgressHUD.showError(withMessage: string)
                            
                        }
                    }else{
                        
                        KRProgressHUD.showSuccess(withMessage: "email sent, check your email.")
                        
                    }
                    
                }
                
                }
            }

        confirmation.addAction(cancelAction)
        confirmation.addAction(okAction)

        confirmation.view.tintColor = UIColor.MaterialColors.Accent.orange500
        self.present(confirmation, animated: true, completion: nil)
        confirmation.view.tintColor = UIColor.MaterialColors.Accent.orange500
        
    }
    

}
