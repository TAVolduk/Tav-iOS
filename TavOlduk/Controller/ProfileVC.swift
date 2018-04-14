//
//  ProfileVC.swift
//  TavOlduk
//
//  Created by Sadik Ekin Ozbay on 14.04.2018.
//  Copyright © 2018 Sadik Ekin Ozbay. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON

class ProfileVC: BaseController {
    var gateArray = [[String]]()
    lazy var profileImage : UIImageView = {
        let pp = UIImageView(image: UIImage(named: "AvatarAang"))
        return pp
    }()
    lazy var nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Avatar Aang"
        label.numberOfLines = 0
        label.font = UIFont(name:"Futura-Bold", size: 24.0)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    let mapView = GMSMapView(frame: CGRect.zero)
    
    override func setupViews() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(profileImage)
        self.view.addSubview(nameLabel)
        
        setupMap()
    }
    func setupMap() {
        mapView.camera = GMSCameraPosition.camera(withLatitude: 40.980377, longitude: 28.816474, zoom: 18.00)
        self.view.addSubview(mapView)
        

    }
    
    override func setupAnchors() {
        _ = profileImage.anchor(self.view.topAnchor, left: nil, bottom: nil, right: self.view.rightAnchor, topConstant: 48, leftConstant: 0, bottomConstant: 0, rightConstant: rightConstant, widthConstant: 108, heightConstant: 108)
        
        _ = nameLabel.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.profileImage.leftAnchor, topConstant: 48, leftConstant: 6, bottomConstant: 0, rightConstant: 6, widthConstant: 0, heightConstant: 108)
        
        _ = mapView.anchor(self.nameLabel.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: leftConstant, leftConstant: leftConstant, bottomConstant: 48+leftConstant, rightConstant: leftConstant, widthConstant: 0, heightConstant: 0)
    }
    
    override func fetchData() {
        Alamofire.request("http://35.159.15.121:8080/domesticGates/gatesList?language=tr&location=ist").responseJSON { response in
            if let data = response.data{
                let jsonData = try? JSON(data: data)
                if let results = jsonData!["results"].array {
                    for r in results{
                        let marker = GMSMarker()
                        marker.position = CLLocationCoordinate2D(latitude: Double(r["lat"].string!)!, longitude: Double(r["lng"].string!)!)
                        marker.title = r["title"].string!
                        marker.map = self.mapView
                    }
                }
            }
        }
    }


}
