//
//  TabBarController.swift
//  Skateboarding
//
//  Created by 鈴木正義 on 2021/01/08.
//  Copyright © 2021 masayoshi.suzuki. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UITabBarControllerDelegateプロトコルのメソッドをこのクラスで処理する。
        self.delegate = self
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // currentUserがnilならログインしていない
        if Auth.auth().currentUser == nil {
            // ログインしていないときの処理
//            let createAccountViewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateAccountViewController")
//            present(createAccountViewController!, animated: true, completion: nil)
            
            let storyboard = UIStoryboard(name: "CreateAccountViewController",bundle: nil)
            guard let createAccountViewController =  storyboard.instantiateInitialViewController() as? CreateAccountViewController else { return }
            present(createAccountViewController, animated: true) //ココ
        }
    }

    // タブバーのアイコンがタップされた時に呼ばれるdelegateメソッドを処理する。
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ImageSelectViewController {
            // ImageSelectViewControllerは、タブ切り替えではなくモーダル画面遷移する
            let imageSelectViewController = storyboard!.instantiateViewController(withIdentifier: "ImageSelectViewController")
            present(imageSelectViewController, animated: true)
            return false
        } else {
            // その他のViewControllerは通常のタブ切り替えを実施
            return true
        }
    }





}
