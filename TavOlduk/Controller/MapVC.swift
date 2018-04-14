//
//  MapController.swift
//  TavOlduk
//
//  Created by Sadik Ekin Ozbay on 14.04.2018.
//  Copyright © 2018 Sadik Ekin Ozbay. All rights reserved.
//

import UIKit
import GoogleMaps

class MapVC: BaseController {
    lazy var lagguageCheckView : UIView = {
        let vc = UIView
        return vc
    }()
    let mapView = GMSMapView(frame: CGRect.zero)
    override func setupViews() {
        self.view.backgroundColor = .white
        mapView.camera = GMSCameraPosition.camera(withLatitude: 40.980377, longitude: 28.816474, zoom: 10.0)
        self.view.addSubview(mapView)
    }
    override func setupAnchors() {
        _ = mapView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 24, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
    }
    override func fetchData() {
        
    }
}
