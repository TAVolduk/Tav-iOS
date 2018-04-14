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
    let mapView = GMSMapView(frame: CGRect.zero)
    override func setupViews() {
        self.view.backgroundColor = .white
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        mapView.camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        self.view.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    override func setupAnchors() {
        _ = mapView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        
    }
    override func fetchData() {
        
    }
}
