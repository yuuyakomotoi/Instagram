//
//  PostData.swift
//  Instagram
//
//  Created by 小本裕也 on 2017/03/10.
//  Copyright © 2017年 小本裕也. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class PostData:NSObject{
    var id:String
    var image:UIImage?
    var imageStrung:String?
    var name:String?
    var caption:String?
    var date:NSDate?
    var likes:[String] = []
    var isLiked:Bool = false
    var comment:[String] = []
    
    init(snapshot:FIRDataSnapshot,myId:String){
self.id = snapshot.key
    
        let valueDictionary = snapshot.value as! [String:AnyObject]
    
        imageStrung = valueDictionary["image"] as? String
        image = UIImage(data:NSData(base64Encoded:imageStrung!,options: .ignoreUnknownCharacters)! as Data)
    
        self.name = valueDictionary["name"] as? String
        
        self.caption = valueDictionary["caption"] as? String
        
        
        
        let time = valueDictionary["time"] as? String
        self.date = NSDate(timeIntervalSinceReferenceDate:TimeInterval(time!)!)
        
        if let likes = valueDictionary["likes"] as? [String] {
            self.likes = likes
        }
        
        if let comments = valueDictionary["comment"] as? [String]{
        self.comment = comments
        }
        
        for likeId in self.likes {
            if likeId == myId {
                self.isLiked = true
                break
            }
        }
    }
    }







