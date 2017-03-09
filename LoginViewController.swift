//
//  LoginViewController.swift
//  Instagram
//
//  Created by 小本裕也 on 2017/03/05.
//  Copyright © 2017年 小本裕也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var mailAddressTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBAction func handleLoginButton(_ sender: Any) {
        if let address = mailAddressTextField.text, let password = passwordTextField.text{
            if address.characters.isEmpty || password.characters.isEmpty{
                SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                return
            }
            
            SVProgressHUD.show()
            
            FIRAuth.auth()?.signIn(withEmail: address, password: password) { user, error in
                if let error = error {
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    SVProgressHUD.showError(withStatus: "サインインに失敗しました。")
                    return
                } else {
                    print("DEBUG_PRINT: ログインに成功しました。")
                    
                SVProgressHUD.dismiss()
                   
                    self.dismiss(animated: true, completion: nil)
        }
    }
        }
    }
    @IBAction func handleCreateAcountButton(_ sender: Any) {
        
                if let address = mailAddressTextField.text, let password = passwordTextField.text, let displayName = displayNameTextField.text {
            if address.characters.isEmpty || password.characters.isEmpty || displayName.characters.isEmpty {
                print("DEBUG_PRINT: 何かが空文字です。")
                SVProgressHUD.showError(withStatus: "必要項目を入力して下さい")
                return
            }
            
                    SVProgressHUD.show()
                    
            FIRAuth.auth()?.createUser(withEmail: address, password: password) { user, error in
                if let error = error {
                    SVProgressHUD.showError(withStatus: "ユーザー作成に失敗しました。")
                    print("DEBUG_PRINT: " + error.localizedDescription)
                    return
                }
                print("DEBUG_PRINT: ユーザー作成に成功しました。")
                
                
                let user = FIRAuth.auth()?.currentUser
                if let user = user{
                    let changRequest = user.profileChangeRequest()
                    changRequest.displayName = displayName
                    changRequest.commitChanges{ error in
                        if let error = error{
                        }
                        print("DEBUG_PRINT: [displayName = \(user.displayName)]の設定に成功しました")
                       SVProgressHUD.dismiss()
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    print("DEBUG_PRINT: displayNameの設定に失敗しました。")
                }
            }
        }

    }
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
