//
//  HomeViewController.swift
//  Instagram
//
//  Created by 小本裕也 on 2017/03/05.
//  Copyright © 2017年 小本裕也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var postArray:[PostData] = []
    
    var observing = false
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        
        let nib = UINib(nibName:"PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        
        if FIRAuth.auth()?.currentUser != nil {
            if self.observing == false {
                
                let postsRef = FIRDatabase.database().reference().child(Const.PostPath)
                postsRef.observe(.childAdded, with: { snapshot in
                    print("DEBUG_PRINT: .childAddedイベントが発生しました。")
                    
                    
                    if let uid = FIRAuth.auth()?.currentUser?.uid {
                        let postData = PostData(snapshot: snapshot, myId: uid)
                        self.postArray.insert(postData, at: 0)
                        
                        
                        self.tableView.reloadData()
                    }
                })
                
                postsRef.observe(.childChanged, with: { snapshot in
                    print("DEBUG_PRINT: .childChangedイベントが発生しました。")
                    
                    if let uid = FIRAuth.auth()?.currentUser?.uid {
                        
                        let postData = PostData(snapshot: snapshot, myId: uid)
                        
                        
                        var index: Int = 0
                        for post in self.postArray {
                            if post.id == postData.id {
                                index = self.postArray.index(of: post)!
                                break
                            }
                        }
                        
                        
                        self.postArray.remove(at: index)
                        
                        
                        self.postArray.insert(postData, at: index)
                        
                        
                        self.tableView.reloadData()
                    }
                })
                
                
                observing = true
            }
        } else {
            if observing == true {
                
                postArray = []
                tableView.reloadData()
                
                FIRDatabase.database().reference().removeAllObservers()
                
                
                observing = false
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as!PostTableViewCell
        cell.setPostData(postData: postArray[indexPath.row])
        
        cell.likeButton.addTarget(self, action:#selector(handleButton(sender:event:)), for: UIControlEvents.touchUpInside)
        //イベントtouchUpInside
        cell.comenntoButton.addTarget(self, action:#selector(handlecomenntoButton(sender:event:)), for: UIControlEvents.touchUpInside)
        //////　宣言している
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    
    func handleButton(sender:UIButton, event:UIEvent){
        print("DEBUG_PRINT: likeボタンがタップされました。")
        
        let touch = event.allTouches?.first//first一番上のView
        let point = touch!.location(in:self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        let postData = postArray[indexPath!.row]
        
        if let uid = FIRAuth.auth()?.currentUser?.uid{
            if postData.isLiked{
                var index = -1
                for likeId in postData.likes{
                    if likeId == uid{
                        index = postData.likes.index(of: likeId)!
                        break
                    }
                }
                postData.likes.remove(at: index)
            }
            else{
                postData.likes.append(uid)
            }
            let postRef = FIRDatabase.database().reference().child(Const.PostPath).child(postData.id)
            let likes = ["likes":postData.likes]
            postRef.updateChildValues(likes)
        }
    }
    //ここ
    
    func handlecomenntoButton (sender:UIButton, event:UIEvent){
        let touch = event.allTouches?.first
        let point = touch!.location(in:self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        let postData = postArray[indexPath!.row]
        
        if let dispName = FIRAuth.auth()?.currentUser?.displayName{
            
            let next = storyboard!.instantiateViewController(withIdentifier: "commentView") as! comenntoViewController
            next.postData = postData
            next.displayName = dispName
            self.present(next,animated: true, completion: nil)
            print("DEBUG_PRINT: handlecomenntoButton")
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
