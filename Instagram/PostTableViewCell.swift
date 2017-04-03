//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 小本裕也 on 2017/03/10.
//  Copyright © 2017年 小本裕也. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var likeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet var commentLabel: UILabel!
    
    @IBOutlet weak var comenntoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    ////////////コメントを出す
    func setPostData(postData:PostData){
        self.postImageView.image = postData.image
        
        
        
        for i in 0..<postData.comment.count {
        let allcomment = postData.comment.joined(separator: "\n")
            self.commentLabel.text = "\(allcomment)"
       self.commentLabel.numberOfLines = i + 1
        }
        
        
        /*self.commentLabel.text = "\(postData.comment)"
        //ナンバーオブラインズ改行　複数行表示
        
        for i in 0..<postData.comment.count {
            print(postData.comment[i])
        }
        
        //iに代入iプラス1 にして1〜４　self.commentLabel.numberOfLines ＝i+1
        */
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"
        
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "ja_JP") as Locale!
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        let dateString:String = formatter.string(from: postData.date! as Date)
        self.dateLabel.text = dateString
        
        if postData.isLiked{
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage,for:UIControlState.normal)
        }
        else{
            let buttonImage = UIImage(named: "like_none" )
            self.likeButton.setImage(buttonImage,for:UIControlState.normal)
        }
    }

}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
