//
//  HomeViewController.swift
//  Skateboarding
//
//  Created by 鈴木正義 on 2021/01/08.
//  Copyright © 2021 masayoshi.suzuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    // 投稿データを格納する配列
    var postArray: [PostData] = []
    // Firestoreのリスナー
    var listener: ListenerRegistration!
    
    var postDataToSend: PostData?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "スポット一覧"
        tableView.delegate = self
        tableView.dataSource = self
        //         Do any additional setup after loading the view.
        //         カスタムセルを登録する
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
        
        //tabbarを復活
        tabBarController?.tabBar.isHidden = false
        
        if Auth.auth().currentUser != nil {
            // ログイン済み
            if listener == nil {
                // listener未登録なら、登録してスナップショットを受信する
                let postsRef = Firestore.firestore().collection(Const.PostPath).order(by: "date", descending: true)
                listener = postsRef.addSnapshotListener() { (querySnapshot, error) in
                    if let error = error {
                        print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                        return
                    }
                    // 取得したdocumentをもとにPostDataを作成し、postArrayの配列にする。
                    self.postArray = querySnapshot!.documents.map { document in
                        print("DEBUG_PRINT: document取得 \(document.documentID)")
                        let postData = PostData(document: document)
                        return postData
                    }
                    // TableViewの表示を更新する
                    self.tableView.reloadData()
                }
            }
        } else {
            // ログイン未(またはログアウト済み)
            if listener != nil {
                // listener登録済みなら削除してpostArrayをクリアする
                listener.remove()
                listener = nil
                postArray = []
                tableView.reloadData()
            }
        }
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得してデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PostTableViewCell
        cell.setPostData(postArray[indexPath.row])
        
        //セル内のimageViewにgesture設定
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.tapped(_:)))
        tapGesture.delegate = self
        cell.postImageView.addGestureRecognizer(tapGesture)
        cell.postImageView.isUserInteractionEnabled = true
        
        // セル内のlikeボタンのアクションをソースコードで設定する
        cell.likeButton.addTarget(self, action:#selector(handleButton(_:forEvent:)), for: .touchUpInside)
        // セル内のcommentボタンのアクションをソースコードで設定する
        cell.commentButton.addTarget(self, action:#selector(commentHandleButton(_:forEvent:)), for: .touchUpInside)
        
        
        return cell
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        // タップされたセルのインデックスを求める
        let tappedLocation = sender.location(in: tableView)
        let tappedIndexPath = tableView.indexPathForRow(at: tappedLocation)
        
        // 配列からタップされたインデックスのデータを取り出す
        let postData = postArray[tappedIndexPath!.row]
        postDataToSend = postData
        
//        遷移先のストーリーボードを取得して、インスタンス化して、navigationControllerで遷移
        let storyboard = UIStoryboard(name: "PostViewController", bundle: nil)
        guard let postViewController = storyboard.instantiateInitialViewController() as? PostViewController else { return }
        navigationController?.pushViewController(postViewController, animated: true)
        postViewController.postDataReceived = postDataToSend
        
    }
    
    @objc func handleButton(_ sender: UIButton, forEvent event: UIEvent) {
        print("DEBUG_PRINT: likeボタンがタップされました。")
        
        // タップされたセルのインデックスを求める
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        // 配列からタップされたインデックスのデータを取り出す
        let postData = postArray[indexPath!.row]
        
        // likesを更新する
        if let myid = Auth.auth().currentUser?.uid {
            // 更新データを作成する
            var updateValue: FieldValue
            if postData.isLiked {
                // すでにいいねをしている場合は、いいね解除のためmyidを取り除く更新データを作成
                updateValue = FieldValue.arrayRemove([myid])
            } else {
                // 今回新たにいいねを押した場合は、myidを追加する更新データを作成
                updateValue = FieldValue.arrayUnion([myid])
            }
            // likesに更新データを書き込む
            let postRef = Firestore.firestore().collection(Const.PostPath).document(postData.id)
            postRef.updateData(["likes": updateValue])
        }
    }
    
    @objc func commentHandleButton(_ sender: UIButton, forEvent event: UIEvent) {
        print("DEBUG_PRINT: commentボタンがタップされました。")
        
        // タップされたセルのインデックスを求める
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        // 配列からタップされたインデックスのデータを取り出す
        let postData = postArray[indexPath!.row]
        postDataToSend = postData
        
        //　遷移先のストーリーボードを取得して、インスタンス化して、navigationControllerで遷移
        let storyboard = UIStoryboard(name: "CommentViewController", bundle: nil)
        guard let commentViewController = storyboard.instantiateInitialViewController() as? CommentViewController
        else { return }
        navigationController?.pushViewController(commentViewController, animated: true)
        commentViewController.postDataReceived = postDataToSend
    }
    
}
