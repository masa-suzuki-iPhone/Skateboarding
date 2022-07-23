//
//  rainyTableViewCell.swift
//  Skateboarding
//
//  Created by 鈴木正義 on 2021/02/02.
//  Copyright © 2021 masayoshi.suzuki. All rights reserved.
//

import UIKit

class rainyTableViewCell: UITableViewCell {
    @IBOutlet weak var rainyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPostData(_ postData: PostData) {
       rainyLabel.text = "\(postData.rainy!)"
    }
}
