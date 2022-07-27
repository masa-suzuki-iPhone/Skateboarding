//
//  PickLocationViewController.swift
//  Skateboarding
//
//  Created by 鈴木正義 on 2021/02/10.
//  Copyright © 2021 masayoshi.suzuki. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class PickLocationViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate {
    
    var addressString = ""
    var lat: CLLocationDegrees = 0.0
    var log: CLLocationDegrees = 0.0
    var pin: MKPointAnnotation = MKPointAnnotation()
    var locationManager: CLLocationManager!
    
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    
    @IBOutlet weak var settingButton: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    var lockManager:CLLocationManager!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        
        addressLabel.layer.cornerRadius = 10.0
        addressLabel.layer.borderWidth = 1.0
        addressLabel.text = addressString
        
        if addressLabel.text == "" {
            settingButton.isEnabled = false
            settingButton.setTitleColor(UIColor.lightGray, for: .normal )
        } else {
            settingButton.isEnabled = true
            settingButton.setTitleColor(UIColor.systemBlue, for: .normal )
        }
    }
    
    
    
    
    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        
        if sender.state == .began {
            //タップを開始した時
            mapView.removeAnnotation(pin)
            settingButton.isEnabled = true
            settingButton.setTitleColor(UIColor.systemBlue, for: .normal )
            
        } else if sender.state == .ended {
            //タップを終了した時
            //タップした位置を指定して、MKMapView上の緯度、経度を取得する
            //緯度経度から住所に変換する
            let tapPoint = sender.location(in: view)
            //タップした位置(CGPoint)を指定してMKMapView上の緯度経度を取得
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            lat = center.latitude
            log = center.longitude
            convert(lat: lat, log: log)
            
            // タップした位置情報に位置にピンを追加
            pin.coordinate = center
            self.mapView.addAnnotation(pin)
            
        }
        
    }
    
    func convert(lat:CLLocationDegrees,log:CLLocationDegrees){
        
        let geocorder = CLGeocoder()
        let location = CLLocation(latitude: lat, longitude: log)
        //クロージャー
        geocorder.reverseGeocodeLocation(location){ (placeMark, error) in
            
            if let placeMark = placeMark {
                if let pm = placeMark.first {
                    
                    if pm.administrativeArea != nil || pm.locality != nil {
                        
                        self.addressString = " " + pm.administrativeArea! + " " + pm.locality! + " " + pm.name!
                        
                    } else {
                        self.addressString = " " + pm.name!
                        
                    }
                    
                    self.addressLabel.text = self.addressString
                    
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        // 許可されてない場合
        case .notDetermined:
            // 許可を求める
            manager.requestWhenInUseAuthorization()
        // 拒否されてる場合
        case .restricted, .denied:
            // 何もしない
            break
        // 許可されている場合
        case .authorizedAlways, .authorizedWhenInUse:
            // 現在地の取得を開始
            manager.startUpdatingLocation()
            
            break
        default:
            break
        }
        
    }
    
    @IBAction func myLocation(_ sender: Any) {
        
        // 現在地に照準を合わす
        // 0.01が距離の倍率
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        // 現在地の取得
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: span)
        // ここで照準を合わせている
        mapView.region = region
    }
    
    
    @IBAction func settingButton(_ sender: Any) {
        let nav = self.navigationController
        // 一つ前のViewControllerを取得する
        let postFormViewController = nav?.viewControllers[(nav?.viewControllers.count)!-2] as! PostFormViewController
        // 値を渡す
        postFormViewController.addressString = addressString
        postFormViewController.lat = lat
        postFormViewController.log = log
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    
    
    
    
    
}

