//
//  ViewController.swift
//  mymap
//
//  Created by 志賀大河 on 2019/12/29.
//  Copyright © 2019 Taigashiga. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    //textField
    @IBOutlet weak var inputText: UITextField!
    // map
    @IBOutlet weak var displayMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputText.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let serchKeyword = textField.text
        // 検索したやつが入力されているか
        print(serchKeyword!)
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(serchKeyword!, completionHandler: { (placemarks,Error ) in
        
            if let placemarks = placemarks?.first {
                if let location = placemarks.location {
                    let targetCoordinate = location.coordinate
                    print(targetCoordinate)
                    
                    let pin = MKPointAnnotation()
                    pin.coordinate = targetCoordinate
                    pin.title = serchKeyword
                    
                    self.displayMap.addAnnotation(pin)
                    self.displayMap.region = MKCoordinateRegion.init(center: targetCoordinate, latitudinalMeters: 500.0,longitudinalMeters: 500.0)
                }
            }
        
        })
        return true
    }
    
}

