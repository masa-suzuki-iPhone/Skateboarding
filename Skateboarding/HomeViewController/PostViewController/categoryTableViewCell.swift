//
//  categoryTableViewCell.swift
//  Skateboarding
//
//  Created by 鈴木正義 on 2021/02/03.
//  Copyright © 2021 masayoshi.suzuki. All rights reserved.
//

import UIKit

class categoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(_ postData: PostData) {
       categoryLabel.text = "\(postData.category!)"
    }
    
}
