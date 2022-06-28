//
//  MapViewController.swift
//  Skateboarding
//
//  Created by 鈴木正義 on 2021/02/08.
//  Copyright © 2021 masayoshi.suzuki. All rights reserved.
//

import UIKit
import GoogleMaps
import Firebase
import FirebaseFirestore

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var mapManager: CLLocationManager = CLLocationManager()
    var latitude: CLLocationDegrees! = CLLocationDegrees()
    var longitude: CLLocationDegrees! = CLLocationDegrees()
    var gmaps: GMSMapView!
    var markers: [GMSMarker] = []
    var nameStringArray = [String] ()
    var indexNumber = Int()
    
    // 投稿データを格納する配列
    var postArray: [PostData]  = []
    // Firestoreのリスナー
    var listener: ListenerRegistration!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "マップ"
        self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController!.navigationBar.barTintColor = UIColor.init(red: 0/255, green: 69/255, blue: 130/255, alpha: 1)
 
        mapManager.delegate = self
        mapManager.requestWhenInUseAuthorization()
        mapManager.requestAlwaysAuthorization()
        mapManager.desiredAccuracy = kCLLocationAccuracyBest
        mapManager.distanceFilter = 1000
        mapManager.startUpdatingLocation()
        
        gmaps = GMSMapView(frame: CGRect(x:0, y:0, width:self.view.bounds.width, height:self.view.bounds.width))
        self.view.addSubview(gmaps)
        gmaps.isMyLocationEnabled = true
        gmaps.settings.compassButton = true
        
        self.view = gmaps
        gmaps.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: mapviewWillAppear")
        
        mapManager.startUpdatingLocation()
        
//        if Auth.auth().currentUser != nil {
//            // ログイン済み
//            if listener == nil {
//                // listener未登録なら、登録してスナップショットを受信する
//                let postsRef = Firestore.firestore().collection(Const.PostPath).order(by: "date", descending: true)
//                listener = postsRef.addSnapshotListener() { (querySnapshot, error) in
//                    if let error = error {
//                        print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
//                        return
//                    }
//                    // 取得したdocumentをもとにPostDataを作成し、postArrayの配列にする。
//                    self.postArray = querySnapshot!.documents.map { document in
//                        print("DEBUG_PRINT: document取得 \(document.documentID)")
//                        let postData = PostData(document: document)
//
//                        self.makeMarker(postData: postData)
//                        return postData
//                    }
//
//                }
//            }
//        } else {
//            // ログイン未(またはログアウト済み)
//            if listener != nil {
//                // listener登録済みなら削除してpostArrayをクリアする
//                listener.remove()
//                listener = nil
//                postArray = []
//
//            }
//        }
        
      
    }
    
    func makeMarker(postData: PostData) -> [GMSMarker] {
        
        let marker = GMSMarker()
        
        marker.position = CLLocationCoordinate2D(latitude: postData.latitude!, longitude: postData.longitude!)
        
        marker.title = "\(postData.caption!)"
        marker.snippet = "\(postData.id)"
        
        if nameStringArray.contains(postData.id) == false {
            nameStringArray.append(postData.id)
        }
        
        
        marker.tracksInfoWindowChanges = true //情報ウィンドウを自動的に更新するように設定する
        marker.appearAnimation = GMSMarkerAnimation.pop //マーカーの表示にアニメーションをつける
        gmaps.selectedMarker = marker //デフォルトで情報ウィンドウを表示
        marker.map = self.gmaps
        
        markers = [marker]
        
        print(nameStringArray)
        
        return markers
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker ) -> Bool {
        print("You tapped : \(marker.position.latitude),\(marker.position.longitude)")
        

        for post in postArray {
            if post.id == marker.snippet {
                postDataToSend = post
                break
            }
        }

        performSegue(withIdentifier: "moveToDetail", sender: self)
      
        return true // or false as needed.
    }
    
    //現在地の読み込み完了時に呼ばれるメソッド
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        let now :GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latitude,longitude:longitude,zoom:14)
        gmaps.camera = now
    }
    
    var postDataToSend: PostData?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToDetail" {
            let next = segue.destination as! DemoCommentViewController
            if let postData = postDataToSend {
                next.setPostData(postData)
                
            }
            
            
        }
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
