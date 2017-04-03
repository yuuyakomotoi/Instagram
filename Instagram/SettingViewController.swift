//
//  SettingViewController.swift
//  Instagram
//
//  Created by 小本裕也 on 2017/03/05.
//  Copyright © 2017年 小本裕也. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth
import SVProgressHUD


class SettingViewController: UIViewController {

    @IBOutlet weak var displayNameTextField: UITextField!
   
        @IBAction func handleChangeButton(_ sender: Any) {
            if let disolayName = displayNameTextField.text{
                if disolayName.characters.isEmpty{
                SVProgressHUD.showError(withStatus:"表示名を入力して下さい" )
            return
                }
                let user = FIRAuth.auth()?.currentUser
                if let user = user {
                    let changeRequest = user.profileChangeRequest()
                    changeRequest.displayName = disolayName
                    changeRequest.commitChanges { error in
                        if let error = error {
                            print("DEBUG_PRINT: " + error.localizedDescription)
                        }
                        print("DEBUG_PRINT: [displayName = \(user.displayName)]の設定に成功しました。")
           SVProgressHUD.showSuccess(withStatus: "表示名を変更しました")
                    }
                } else {
                    print("DEBUG_PRINT: displayNameの設定に失敗しました。")
                }
            }
            
        self.view.endEditing(true)
    }
        @IBAction func handleLogoutButton(_ sender: Any) {
    try! FIRAuth.auth()?.signOut()
    let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil)
            let tabBarController = parent as! ESTabBarController
            tabBarController.setSelectedIndex(0, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let user = FIRAuth.auth()?.currentUser
        if let user = user{
            displayNameTextField.text = user.displayName
        }
        
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
