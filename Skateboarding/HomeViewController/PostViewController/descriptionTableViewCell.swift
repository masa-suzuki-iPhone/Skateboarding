//
//  descriptionTableViewCell.swift
//  Skateboarding
//
//  Created by 鈴木正義 on 2021/02/03.
//  Copyright © 2021 masayoshi.suzuki. All rights reserved.
//

import UIKit

class descriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        descriptionLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func setPostData(_ postData: PostData) {
       descriptionLabel.text = "\(postData.detail!)"
    }
    
}
