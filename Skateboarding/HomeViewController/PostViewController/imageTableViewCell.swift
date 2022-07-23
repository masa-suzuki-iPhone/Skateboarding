//
//  imageTableViewCell.swift
//  Skateboarding
//
//  Created by 鈴木正義 on 2021/01/29.
//  Copyright © 2021 masayoshi.suzuki. All rights reserved.
//

import UIKit
import FirebaseUI

class imageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ImageViewDetail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setPostData(_ postData: PostData) {
     //画像の表示
    ImageViewDetail.sd_imageIndicator = SDWebImageActivityIndicator.gray
    let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
    ImageViewDetail.sd_setImage(with: imageRef)
    }

}
