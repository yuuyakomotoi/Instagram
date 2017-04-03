//
//  comenntoViewController.swift
//  Instagram
//
//  Created by 小本裕也 on 2017/03/20.
//  Copyright © 2017年 小本裕也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class comenntoViewController: UIViewController {

    @IBOutlet weak var comennto: UITextField!
    
    var postData:PostData!
    var displayName:String!
    
    @IBAction func comenntoButton(_ sender: Any) {
        let comment = comennto.text!
        
        if ( comment != "" ) {
            if ( displayName != "" ) {
                
                var commentArray:[String] = []
                
                if ( postData.comment.count > 0 ) {
                    commentArray = postData.comment
                }
                
                commentArray.append("\(displayName!) : \(comment)")
                
                let postRef = FIRDatabase.database().reference().child(Const.PostPath).child(postData.id)
                let new_comment = ["comment":commentArray]
                postRef.updateChildValues(new_comment)
                //更新するpostRefのcommentに
                
            }
        }
        dismiss(animated: true, completion: nil)
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
