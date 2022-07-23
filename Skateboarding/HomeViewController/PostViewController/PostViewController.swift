//
//  PostViewController.swift
//  Skateboarding
//
//  Created by suzuki.masayoshi on 2022/07/20.
//  Copyright © 2022 masayoshi.suzuki. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var postTableView: UITableView!
    
    //前画面からデータを受け取るための変数
    var postDataReceived: PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //空の線のセルの区切りを消す
        postTableView.tableFooterView = UIView()
        // tabbarを隠す
        tabBarController?.tabBar.isHidden = true
 
        title = "詳細"
        if let navigation = self.navigationController {
        navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        }
        postTableView.delegate = self
        postTableView.dataSource = self
        
        //         カスタムセルを登録する
        let nib = UINib(nibName: "imageTableViewCell", bundle: nil)
        postTableView.register(nib, forCellReuseIdentifier: "imageCell")
        
        let nib2 = UINib(nibName: "captionTableViewCell", bundle: nil)
        postTableView.register(nib2, forCellReuseIdentifier: "captionCell")
        
        let nib3 = UINib(nibName: "roadsurfaceTableViewCell", bundle: nil)
        postTableView.register(nib3, forCellReuseIdentifier: "roadSurfaceCell")
        
        let nib4 = UINib(nibName: "kickoutTableViewCell", bundle: nil)
        postTableView.register(nib4, forCellReuseIdentifier: "kickoutCell")
        
        let nib5 = UINib(nibName: "rainyTableViewCell", bundle: nil)
        postTableView.register(nib5, forCellReuseIdentifier: "rainyCell")
        
        let nib6 = UINib(nibName: "categoryTableViewCell", bundle: nil)
        postTableView.register(nib6, forCellReuseIdentifier: "categoryCell")
        
        let nib7 = UINib(nibName: "descriptionTableViewCell", bundle: nil)
        postTableView.register(nib7, forCellReuseIdentifier: "descriptionCell")
        
        let nib8 = UINib(nibName: "CommentLabelTableViewCell", bundle: nil)
        postTableView.register(nib8, forCellReuseIdentifier: "CommentLabelCell")
        
        let nib9 = UINib(nibName: "commentTableViewCell", bundle: nil)
        postTableView.register(nib9, forCellReuseIdentifier: "commentCell")
        
        postTableView.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataReceived.comments.count + 8
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
            if let cell = cell as? imageTableViewCell{
                cell.setPostData(postDataReceived)
                return cell
            }
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "captionCell", for: indexPath)
            if let cell = cell as? captionTableViewCell{
                cell.setPostData(postDataReceived)
                return cell
            }
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "roadSurfaceCell", for: indexPath)
            if let cell = cell as? roadsurfaceTableViewCell{
                cell.setPostData(postDataReceived)
                return cell
            }
            return cell
            
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "kickoutCell", for: indexPath)
            if let cell = cell as? kickoutTableViewCell{
                cell.setPostData(postDataReceived)
                return cell
            }
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "rainyCell", for: indexPath)
            if let cell = cell as? rainyTableViewCell{
                cell.setPostData(postDataReceived)
                return cell
            }
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
            if let cell = cell as? categoryTableViewCell{
                cell.setPostData(postDataReceived)
                return cell
            }
            return cell
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell", for: indexPath)
            if let cell = cell as? descriptionTableViewCell{
                cell.setPostData(postDataReceived)
                return cell
            }
            return cell
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentLabelCell", for: indexPath)
            return cell
        default :
            let cell = postTableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! commentTableViewCell
            cell.setPostData(postDataReceived)
            cell.someonesCommentLabel.text = postDataReceived.comments[indexPath.row - 8]
          return cell
        }

       
    }
    
}
