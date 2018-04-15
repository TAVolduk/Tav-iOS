//
//  MapController.swift
//  TavOlduk
//
//  Created by Sadik Ekin Ozbay on 14.04.2018.
//  Copyright © 2018 Sadik Ekin Ozbay. All rights reserved.
//

import UIKit
import GoogleMaps
import SwiftyJSON
import Alamofire
import NVActivityIndicatorView
import PopupDialog

class MapVC: BaseController, NVActivityIndicatorViewable {
    lazy var lagguageCheckView : UIView = {
        let vc = UIView()
        vc.addShadow()
        
        vc.layer.borderColor = UIColor.lightGray.cgColor
        vc.layer.borderWidth = 0.3
        vc.layer.backgroundColor = UIColor.white.cgColor
        vc.layer.cornerRadius = 3
        return vc
    }()
    
    lazy var flightNum : UITextField = {
        let field = UITextField()
        field.placeholder = "Enter your flight number"
        field.font = UIFont(name:"Futura", size: 12.0)
        field.textColor = UIColor.gray
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: self.view.frame.size.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 0.3
        field.layer.backgroundColor = UIColor.white.cgColor
        field.layer.cornerRadius = 3
        return field
    }()
    
    lazy var seatNum : UITextField = {
        let field = UITextField()
        field.placeholder = "Enter your seat number"
        field.font = UIFont(name:"Futura", size: 12.0)
        field.textColor = UIColor.gray
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 6, height: self.view.frame.size.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 0.3
        field.layer.backgroundColor = UIColor.white.cgColor
        field.layer.cornerRadius = 3
        return field

    }()
    
    lazy var findIt : UIButton = {
        let button = UIButton()
        button.setTitle("Find It", for: .normal)
        button.backgroundColor = UIColor.brown
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name:"Futura", size: 12.0)
        button.isEnabled = true
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.brown.cgColor
        button.addTarget(self, action: #selector(sendIt), for: .touchUpInside)
        return button
    }()
    
    
    let mapView = GMSMapView(frame: CGRect.zero)
    override func setupViews() {
        self.view.backgroundColor = .white
        mapView.camera = GMSCameraPosition.camera(withLatitude: 40.980377, longitude: 28.816474, zoom: 10.0)
        self.view.addSubview(lagguageCheckView)
        self.view.addSubview(mapView)
        self.lagguageCheckView.addSubview(seatNum)
        self.lagguageCheckView.addSubview(flightNum)
        self.lagguageCheckView.addSubview(findIt)
    }
    override func setupAnchors() {
        _ = lagguageCheckView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 48, leftConstant: leftConstant, bottomConstant: 0, rightConstant: rightConstant, widthConstant: 0, heightConstant: 1.7*heightConstant)
        
        _ = mapView.anchor(self.lagguageCheckView.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: leftConstant, leftConstant: leftConstant, bottomConstant: 48+leftConstant, rightConstant: leftConstant, widthConstant: 0, heightConstant: 0)
        _ = seatNum.anchor(self.lagguageCheckView.topAnchor, left: self.lagguageCheckView.leftAnchor, bottom: nil, right: nil, topConstant: 3, leftConstant: 3, bottomConstant: 0, rightConstant: 0, widthConstant: (self.view.frame.width-2*leftConstant-20)/2, heightConstant: heightConstant-3)
        
        _ = flightNum.anchor(self.lagguageCheckView.topAnchor, left: nil, bottom: nil, right: self.lagguageCheckView.rightAnchor, topConstant: 3, leftConstant: 0, bottomConstant: 0, rightConstant: 3, widthConstant: (self.view.frame.width-2*leftConstant-20)/2, heightConstant: heightConstant-3)
        
        _ = findIt.anchor(self.flightNum.bottomAnchor, left: self.lagguageCheckView.leftAnchor, bottom: self.lagguageCheckView.bottomAnchor, right: self.lagguageCheckView.rightAnchor, topConstant: 6, leftConstant: 3*leftConstant, bottomConstant: 6, rightConstant: 3*leftConstant, widthConstant: 0, heightConstant: 0)
        
    }
    
    @objc func sendIt() {
        startAnimating()
        Alamofire.request("https://tavbackend.us-west-1.elasticbeanstalk.com/luggage", parameters: ["flightNumber": flightNum.text ?? "", "seatNumber": seatNum.text ?? ""]).responseJSON { response in
            self.stopAnimating()
            if (response.error != nil){
                let title = "Luggage Status"
                let message = "Check-in(Counter): OK \n Security: OK \n Sorter: OK \n Loading: OK \n Unloading: Waiting \n Carousel: Waiting"
                let popup = PopupDialog(title: title, message: message)
                let buttonOne = CancelButton(title: "Okay") {
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: 40.980377, longitude: 28.816474)
                    marker.title = "Your Laggage"
                    marker.map = self.mapView
                    self.mapView.animate(toZoom: 13.0)
                }
                
                popup.addButtons([buttonOne])
                self.present(popup, animated: true, completion: nil)
            }else{
                print(response.description)
                print(response.debugDescription)
                if let data = response.data{
                    print(data)
                    let jsonData = try? JSON(data: data)
                    print(jsonData ?? "")

                }
            }
        }
    }
    override func fetchData() {
    }
}
