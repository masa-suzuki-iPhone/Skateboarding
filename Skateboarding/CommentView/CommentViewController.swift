//
//  PostCommentViewController.swift
//  Skateboarding
//
//  Created by 鈴木正義 on 2021/02/04.
//  Copyright © 2021 masayoshi.suzuki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SVProgressHUD

class CommentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var commentTableView: UITableView!
    var postDataReceived: PostData!
    
    let commentInputContainerView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let inputTextField:UITextField = {
        let textField = UITextField()
        textField.placeholder = "コメントを記入...."
        return textField
    }()
    
    var heightConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    let postCommentButton:UIButton = {
        let commentButton = UIButton()
        commentButton.setTitle("投稿", for: UIControl.State.normal)
        commentButton.setTitleColor(UIColor.systemBlue, for: .normal)
        commentButton.backgroundColor = UIColor.lightGray
        commentButton.addTarget(self, action: #selector(commentPostButton), for: .touchUpInside)
        return commentButton
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "コメント"
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        commentTableView.delegate = self
        commentTableView.dataSource = self
        
        //         カスタムセルを登録する
        let nib = UINib(nibName: "captionTableViewCell", bundle: nil)
        commentTableView.register(nib, forCellReuseIdentifier: "captionCell")
        let nib2 = UINib(nibName: "commentTableViewCell", bundle: nil)
        commentTableView.register(nib2, forCellReuseIdentifier: "commentCell")
        
        //空の線のセルの区切りを消す
        commentTableView.tableFooterView = UIView()
        // tabbarを隠す
        tabBarController?.tabBar.isHidden = true
        
        //commentInputContainerViewをviewに追加
        view.addSubview(commentInputContainerView)
        //commentInputContainerViewの位置決定
        commentInputContainerView.translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = NSLayoutConstraint(item: commentInputContainerView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        let leftConstraint = NSLayoutConstraint(item: commentInputContainerView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 0)
        let rightConstraint = NSLayoutConstraint(item: commentInputContainerView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        bottomConstraint = NSLayoutConstraint(item: commentInputContainerView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0)
        view.addConstraints([heightConstraint!,leftConstraint,rightConstraint,bottomConstraint!])
        
        setupInputComponents()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            heightConstraint?.constant = 50
            bottomConstraint?.constant = -keyboardSize.height
        }
    }
    
    @objc func commentPostButton(sender: UIButton){
        if let comment = inputTextField.text {
            if comment.isEmpty {
                return
            } else {
                // HUDで投稿処理中の表示を開始
                SVProgressHUD.show()
                let commentName = Auth.auth().currentUser?.displayName
                let comments = "\(commentName!) : \(self.inputTextField.text!)"
                //firestoreのデータを更新するための変数
                var updateValue: FieldValue
                //元々合った配列にデータを追加
                updateValue = FieldValue.arrayUnion([comments])
                //コメント先の投稿データを特定
                let postRef = Firestore.firestore().collection(Const.PostPath).document(postDataReceived.id)
                postRef.updateData(["comments": updateValue])
                // HUDで投稿完了を表示する
                SVProgressHUD.showSuccess(withStatus: "コメントを投稿しました")
                // TableViewの表示を更新する
                self.commentTableView.reloadData()
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
        heightConstraint?.constant = 100
        bottomConstraint?.constant = 0
        
    }
    
    
    private func setupInputComponents(){
        //inputtextFieldをcommentInputContainerViewに追加
        commentInputContainerView.addSubview(inputTextField)
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        //inputTextFieldの位置決定
        let heightConstraint = NSLayoutConstraint(item: inputTextField, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        let leftConstraint = NSLayoutConstraint(item: inputTextField, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: commentInputContainerView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1, constant: 10)
        let rightConstraint = NSLayoutConstraint(item: inputTextField, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: commentInputContainerView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: inputTextField, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: commentInputContainerView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        view.addConstraints([heightConstraint,leftConstraint,rightConstraint,topConstraint])
        
        //postCommentButtonをcommentInputContainerViewに追加
        view.addSubview(postCommentButton)
        postCommentButton.translatesAutoresizingMaskIntoConstraints = false
        //postCommentButtonの位置決定
        let heightButtonConstraint = NSLayoutConstraint(item: postCommentButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 50)
        let widthButtonConstraint = NSLayoutConstraint(item: postCommentButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 75)
        let rightButtonConstraint = NSLayoutConstraint(item: postCommentButton, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: commentInputContainerView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1, constant: -5)
        let topButtonConstraint = NSLayoutConstraint(item: postCommentButton, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: commentInputContainerView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0)
        view.addConstraints([heightButtonConstraint,widthButtonConstraint,rightButtonConstraint,topButtonConstraint])
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataReceived.comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = commentTableView.dequeueReusableCell(withIdentifier: "captionCell", for: indexPath)
            if let cell = cell as? captionTableViewCell{
                cell.setPostData(postDataReceived)
                return cell
            }
            return cell
        } else {
            
            let cell = commentTableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! commentTableViewCell
            cell.setPostData(postDataReceived)
            cell.someonesCommentLabel.text = postDataReceived.comments[indexPath.row - 1]
            
            return cell
        }
        
    }
    
    
    
}

