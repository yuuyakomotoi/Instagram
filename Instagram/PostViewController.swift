//
//  PostViewController.swift
//  Instagram
//
//  Created by 小本裕也 on 2017/03/05.
//  Copyright © 2017年 小本裕也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD

class PostViewController: UIViewController {
    var image:UIImage!
   
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func handlePostButton(_ sender: Any) {
    
        let imageData = UIImageJPEGRepresentation(imageView.image,0.5)
        let imageString = imageData!.base64EncodedString(options: .lineLength64Characters)
    
    let time = NSDate.timeIntervalSinceReferenceDate
    let name = FIRAuth.auth()?.currentUser?.displayName
    
        
        let postRef = FIRDatabase.database().reference().child(Const.PostPath)
        let postData = ["caption": textField.text!, "image": imageString, "time": String(time), "name": name!]
        postRef.childByAutoId().setValue(postData)
        
        
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
    
    }
    
   
    @IBAction func handleCancelButto(_ sender: Any) {
    dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        
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
