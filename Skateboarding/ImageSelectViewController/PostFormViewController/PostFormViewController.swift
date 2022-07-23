//
//  PostInformatinViewController.swift
//  Skateboarding
//
//  Created by 鈴木正義 on 2021/03/07.
//  Copyright © 2021 masayoshi.suzuki. All rights reserved.
//
import UIKit
import UIKit
import Firebase
import FirebaseFirestore
import SVProgressHUD
import MapKit

class PostFormViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var image: UIImage!
    var addressString = ""
    var category = ""
    var roadsurface = ""
    var kickout = ""
    var rainy = ""
    var detail = ""
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBOutlet weak var textSpotCategoryField: UITextField!
    var pickerView: UIPickerView = UIPickerView()
    var pickerWithButtonView: UIView!
    // ドラムロールボタンの選択肢を配列にして格納
    let list = ["", "フラット", "フラットとセクション", "パーク"]
    
    @IBOutlet weak var textRoadSurfaceField: UITextField!
    var pickerView2: UIPickerView = UIPickerView()
    var pickerWithButtonView2: UIView!
    // ドラムロールボタンの選択肢を配列にして格納
    let list2 = ["", "とても悪い", "悪い", "普通", "良い", "とても良い"]
    
    @IBOutlet weak var textKickoutLevelField: UITextField!
    var pickerView3: UIPickerView = UIPickerView()
    var pickerWithButtonView3: UIView!
    // ドラムロールボタンの選択肢を配列にして格納
    let list3 = ["", "ない", "あまりない", "来る", "すぐ来る"]
    
    @IBOutlet weak var textRainySpotField: UITextField!
    var pickerView4: UIPickerView = UIPickerView()
    var pickerWithButtonView4: UIView!
    // ドラムロールボタンの選択肢を配列にして格納
    let list4 = ["", "はい", "いいえ"]
    
    @IBOutlet weak var textDetailView: UITextView!
    
    @IBOutlet weak var handlePostButton: UIButton!
    @IBOutlet weak var handleCancelButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "スポット一覧"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0, green: 0.4745, blue: 0.6784, alpha: 1)
        
        // 背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        //handePostButton,handleCancelButtonの角をとる
        handlePostButton.layer.cornerRadius = 10.0
        handleCancelButton.layer.cornerRadius = 10.0
        
        //textViewに枠をつける
        // 枠のカラー
        textDetailView.layer.borderColor = UIColor.lightGray.cgColor
        // 枠の幅
        textDetailView.layer.borderWidth = 1.0
        // 枠を角丸にする
        textDetailView.layer.cornerRadius = 5.0
        textDetailView.layer.masksToBounds = true
        
        // MARK:pickerWithButtonView
        // Delegateを自身に設定する
        pickerView.delegate = self //（スポットの種類）
        // 選択肢を自身に設定する
        pickerView.dataSource = self //（スポットの種類）
        pickerView.tag = 1
        // MARK: PickerView, ToolBar 両方の高さを定義しておく
        let pickerViewHeight = CGFloat(300)
        let toolBarHeight = CGFloat(35)
        let pickerWithButtonViewHeight = pickerViewHeight + toolBarHeight
        //　MARK: PickerView とToolBarの両方を表示するビューを生成する（スポットの種類）
        pickerWithButtonView = UIView(frame: CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: pickerWithButtonViewHeight))
        // MARK: ツールバーの生成（スポットの種類）
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: pickerWithButtonView.frame.width, height: toolBarHeight))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        // done ボタンを押すと、done() が呼ばれる
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        // [doneItem, spaceItem] の順にすれば [Done] が左側に来る
        toolbar.setItems([spacelItem, doneItem], animated: true)
        // UIViewに追加する
        pickerWithButtonView.addSubview(toolbar) //（スポットの種類）
        // MARK: PickerView の生成（スポットの種類）
        // ToolBar の高さの分だけ、Y座標を上げる（表示を下げる）
        pickerView.frame = CGRect(x: 0, y: toolBarHeight, width: pickerWithButtonView.frame.width, height: pickerViewHeight)
        // UIViewに追加する
        pickerWithButtonView.addSubview(pickerView)
        // UITextField編集時に表示されるキーボードをpickerViewに置き換える
        textSpotCategoryField.inputView = pickerWithButtonView
        
        // MARK:pickerWithButtonView2
        // Delegateを自身に設定する
        pickerView2.delegate = self //（路面の調子）
        // 選択肢を自身に設定する
        pickerView2.dataSource = self //（路面の調子）
        pickerView2.tag = 2
        // MARK: PickerView, ToolBar 両方の高さを定義しておく （路面の調子）
        let pickerViewHeight2 = CGFloat(300)
        let toolBarHeight2 = CGFloat(35)
        let pickerWithButtonViewHeight2 = pickerViewHeight2 + toolBarHeight2
        //　MARK: PickerView と ToolBar の両方を表示するビューを生成する（路面の調子）
        pickerWithButtonView2 = UIView(frame: CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: pickerWithButtonViewHeight2))
        // MARK: ツールバーの生成（路面の調子）
        let toolbar2 = UIToolbar(frame: CGRect(x: 0, y: 0, width: pickerWithButtonView2.frame.width, height: toolBarHeight2))
        let spacelItem2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        // done ボタンを押すと、done() が呼ばれる
        let doneItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        // [doneItem, spaceItem] の順にすれば [Done] が左側に来る
        toolbar2.setItems([spacelItem2, doneItem2], animated: true)
        // UIViewに追加する
        pickerWithButtonView2.addSubview(toolbar2)//（路面の調子）
        // MARK: PickerView の生成（路面の調子）
        // ToolBar の高さの分だけ、Y座標を上げる（表示を下げる）
        pickerView2.frame = CGRect(x: 0, y: toolBarHeight2, width: pickerWithButtonView2.frame.width, height: pickerViewHeight2)
        // UIViewに追加する
        pickerWithButtonView2.addSubview(pickerView2)
        // UITextField編集時に表示されるキーボードをpickerView2に置き換える
        textRoadSurfaceField.inputView = pickerWithButtonView2
        
        // MARK:pickerWithButtonView3
        // Delegateを自身に設定する
        pickerView3.delegate = self //（キックアウトレベル）
        // 選択肢を自身に設定する
        pickerView3.dataSource = self //（キックアウトレベル）
        pickerView3.tag = 3
        // MARK: PickerView, ToolBar 両方の高さを定義しておく （キックアウトレベル）
        let pickerViewHeight3 = CGFloat(300)
        let toolBarHeight3 = CGFloat(35)
        let pickerWithButtonViewHeight3 = pickerViewHeight3 + toolBarHeight3
        //　MARK: PickerView と ToolBar の両方を表示するビューを生成する（キックアウトレベル）
        pickerWithButtonView3 = UIView(frame: CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: pickerWithButtonViewHeight3))
        // MARK: ツールバーの生成（キックアウトレベル）
        let toolbar3 = UIToolbar(frame: CGRect(x: 0, y: 0, width: pickerWithButtonView3.frame.width, height: toolBarHeight3))
        let spacelItem3 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        // done ボタンを押すと、done() が呼ばれる
        let doneItem3 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        // [doneItem, spaceItem] の順にすれば [Done] が左側に来る
        toolbar3.setItems([spacelItem3, doneItem3], animated: true)
        // UIViewに追加する
        pickerWithButtonView3.addSubview(toolbar3)//（キックアウトレベル）
        // MARK: PickerView の生成（キックアウトレベル）
        // ToolBar の高さの分だけ、Y座標を上げる（表示を下げる）
        pickerView3.frame = CGRect(x: 0, y: toolBarHeight3, width: pickerWithButtonView3.frame.width, height: pickerViewHeight3)
        // UIViewに追加する
        pickerWithButtonView3.addSubview(pickerView3)
        // UITextField編集時に表示されるキーボードをpickerView3に置き換える
        textKickoutLevelField.inputView = pickerWithButtonView3
        
        // MARK:pickerWithButtonView4
        // Delegateを自身に設定する
        pickerView4.delegate = self //（雨スポット）
        // 選択肢を自身に設定する
        pickerView4.dataSource = self //（雨スポット）
        pickerView4.tag = 4
        // MARK: PickerView, ToolBar 両方の高さを定義しておく （雨スポット）
        let pickerViewHeight4 = CGFloat(300)
        let toolBarHeight4 = CGFloat(35)
        let pickerWithButtonViewHeight4 = pickerViewHeight4 + toolBarHeight4
        //　MARK: PickerView と ToolBar の両方を表示するビューを生成する（雨スポット）
        pickerWithButtonView4 = UIView(frame: CGRect(x: 0, y: view.frame.height / 2, width: view.frame.width, height: pickerWithButtonViewHeight4))
        // MARK: ツールバーの生成（雨スポット）
        let toolbar4 = UIToolbar(frame: CGRect(x: 0, y: 0, width: pickerWithButtonView4.frame.width, height: toolBarHeight4))
        let spacelItem4 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        // done ボタンを押すと、done() が呼ばれる
        let doneItem4 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        // [doneItem, spaceItem] の順にすれば [Done] が左側に来る
        toolbar4.setItems([spacelItem4, doneItem4], animated: true)
        // UIViewに追加する
        pickerWithButtonView4.addSubview(toolbar4)//（雨スポット）
        // MARK: PickerView の生成（キックアウトレベル）
        // ToolBar の高さの分だけ、Y座標を上げる（表示を下げる）
        pickerView4.frame = CGRect(x: 0, y: toolBarHeight4, width: pickerWithButtonView4.frame.width, height: pickerViewHeight4)
        // UIViewに追加する
        pickerWithButtonView4.addSubview(pickerView4)
        // UITextField編集時に表示されるキーボードをpickerView4に置き換える
        textRainySpotField.inputView = pickerWithButtonView4
        
        // Do any additional setup after loading the view.
        // 受け取った画像をImageViewに設定する
        imageView.image = image
        textField.text = addressString
        textSpotCategoryField.text = category
        textRoadSurfaceField.text = roadsurface
        textKickoutLevelField.text = kickout
        textRainySpotField.text = rainy
        textDetailView.text = detail
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.text = addressString
        textSpotCategoryField.text = category
        textRoadSurfaceField.text = roadsurface
        textKickoutLevelField.text = kickout
        textRainySpotField.text = rainy
        textDetailView.text = detail
        
    }
    
    
    
    @IBAction func moveToPickLocationViewButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PickLocationViewController", bundle: nil)
        guard let pickLocationViewController = storyboard.instantiateInitialViewController() as? PickLocationViewController
        else { return }
        pickLocationViewController.image = image
        pickLocationViewController.addressString = addressString
        pickLocationViewController.category = textSpotCategoryField.text ?? ""
        pickLocationViewController.roadsurface = textRoadSurfaceField.text ?? ""
        pickLocationViewController.kickout = textKickoutLevelField.text ?? ""
        pickLocationViewController.rainy = textRainySpotField.text ?? ""
        pickLocationViewController.detail = textDetailView.text ?? ""
        present(pickLocationViewController, animated: true)
        
        
    }
    
    
    // 投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func handlePostButton(_ sender: Any) {
        if let caption = textField.text, let category = textSpotCategoryField.text , let roadSurface = textRoadSurfaceField.text, let kickout = textKickoutLevelField.text, let rainy = textRainySpotField.text, let detail = textDetailView.text {
            
            if caption.isEmpty || category.isEmpty || roadSurface.isEmpty || kickout.isEmpty || rainy.isEmpty || detail.isEmpty {
                return
            }
        }
        
        CLGeocoder().geocodeAddressString(addressString) { placemarks, error in
            DispatchQueue.main.async {
                
                guard let lat = placemarks?.first?.location?.coordinate.latitude else {return}
                guard let lng = placemarks?.first?.location?.coordinate.longitude else {return}
                
                // 画像をJPEG形式に変換する
                let imageData = self.image.jpegData(compressionQuality: 0.5)
                // 画像と投稿データの保存場所を定義する
                let postRef = Firestore.firestore().collection(Const.PostPath).document()
                let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postRef.documentID + ".jpg")
                // HUDで投稿処理中の表示を開始
                SVProgressHUD.show()
                // Storageに画像をアップロードする
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                imageRef.putData(imageData!, metadata: metadata) { (metadata, error) in
                    if error != nil {
                        // 画像のアップロード失敗
                        print(error!)
                        SVProgressHUD.showError(withStatus: "画像のアップロードが失敗しました")
                        // 投稿処理をキャンセルし、先頭画面に戻る
                        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
                        return
                    }
                }
                // FireStoreに投稿データを保存する
                let name = Auth.auth().currentUser?.displayName
                let postDic = [
                    "name": name!,
                    "caption": self.textField.text!,
                    "category": self.textSpotCategoryField.text!,
                    "roadsurface": self.textRoadSurfaceField.text!,
                    "kickout": self.textKickoutLevelField.text!,
                    "rainy": self.textRainySpotField.text!,
                    "detail": self.textDetailView.text!,
                    "date": FieldValue.serverTimestamp(),
                    "latitude": lat,
                    "longitude": lng,
                ] as [String : Any]
                postRef.setData(postDic)
                // HUDで投稿完了を表示する
                SVProgressHUD.showSuccess(withStatus: "投稿しました")
                // 投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
                
                
            }
            
        }
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func dismissKeyboard(){
        // キーボードを閉じる
        view.endEditing(true)
    }
    
    func pickerView (_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return list[row]
        } else if (pickerView.tag == 2) {
            return list2[row]
        } else if (pickerView.tag == 3){
            return list3[row]
        } else if (pickerView.tag == 4){
            return list4[row]
        } else {
            return "none"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return list.count
        } else if (pickerView.tag == 2) {
            return list2.count
        } else if (pickerView.tag == 3){
            return list3.count
        } else if (pickerView.tag == 4){
            return list4.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView.tag == 1){
            textSpotCategoryField.text = list[row]
        } else if (pickerView.tag == 2){
            textRoadSurfaceField.text = list2[row]
        } else if (pickerView.tag == 3){
            textKickoutLevelField.text = list3[row]
        } else if (pickerView.tag == 4) {
            textRainySpotField.text = list4[row]
        }
    }
    
    // [Done] を押した時の処理
    @objc func done() {
        pickerWithButtonView.removeFromSuperview()
        pickerWithButtonView2.removeFromSuperview()
        pickerWithButtonView3.removeFromSuperview()
        pickerWithButtonView4.removeFromSuperview()
    }
    
}
