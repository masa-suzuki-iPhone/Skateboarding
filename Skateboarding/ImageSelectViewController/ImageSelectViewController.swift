//
//  ImageSelectViewController.swift
//  Skateboarding
//
//  Created by suzuki.masayoshi on 2022/07/23.
//  Copyright © 2022 masayoshi.suzuki. All rights reserved.
//

import UIKit
import CLImageEditor


class ImageSelectViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLImageEditorDelegate {
    
    @IBOutlet weak var libraryButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        libraryButton.layer.cornerRadius = 10.0
        cameraButton.layer.cornerRadius = 10.0
        cancelButton.layer.cornerRadius = 10.0
        
    }
    
    @IBAction func hundleLibraryButton(_ sender: Any) {
        // ライブラリ（カメラロール）を指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    @IBAction func hundleCameraButton(_ sender: Any) {
        // カメラを指定してピッカーを開く
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .camera
            self.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func hundleCancelButton(_ sender: Any) {
        // 画面を閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // 写真を撮影/選択したときに呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if info[.originalImage] != nil {
            // 撮影/選択された画像を取得する
            let image = info[.originalImage] as! UIImage
            
            // あとでCLImageEditorライブラリで加工する
            print("DEBUG_PRINT: image = \(image)")
            // CLImageEditorにimageを渡して、加工画面を起動する。
            let editor = CLImageEditor(image: image)!
            editor.delegate = self
            editor.modalPresentationStyle = .fullScreen
            picker.present(editor, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // ImageSelectViewController画面を閉じてタブ画面に戻る
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // CLImageEditorで加工が終わったときに呼ばれるメソッド
    func imageEditor(_ editor: CLImageEditor!, didFinishEditingWith image: UIImage!) {
        let storyboard = UIStoryboard(name: "PostFormViewController", bundle: nil)
        let postFormViewController = storyboard.instantiateViewController(withIdentifier: "PostFormViewController") as! PostFormViewController
        let nav = UINavigationController(rootViewController: postFormViewController)
        nav.modalPresentationStyle = .fullScreen
        postFormViewController.image = image!
        editor.present(nav,animated: true, completion: nil)
    }
    
    // CLImageEditorの編集がキャンセルされた時に呼ばれるメソッド
    func imageEditorDidCancel(_ editor: CLImageEditor!) {
        // ImageSelectViewController画面を閉じてタブ画面に戻る
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}

