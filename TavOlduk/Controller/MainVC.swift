//
//  ViewController.swift
//  TavOlduk
//
//  Created by Sadik Ekin Ozbay on 14.04.2018.
//  Copyright © 2018 Sadik Ekin Ozbay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainVC: BaseController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    lazy var weatherView : WeatherView = {
        let wV = WeatherView()
        wV.backgroundColor = UIColor.white
        wV.addShadow()
        wV.layer.borderColor = UIColor.lightGray.cgColor
        wV.layer.borderWidth = 0.3
        wV.layer.backgroundColor = UIColor.white.cgColor
        wV.layer.cornerRadius = 3
        wV.setupView()
        wV.setupAnchor()
        return wV
    }()
    lazy var collectionViewer : UIView = {
        let view = UIView()
        view.addShadow()
        return view
    }()
    
    lazy var menuListCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.tag = 1
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(ItemCellView.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
        collectionView.layer.borderWidth = 0.3
        collectionView.layer.backgroundColor = UIColor.white.cgColor
        collectionView.layer.cornerRadius = 3
        return collectionView
    }()
    
    override func setupViews() {
        self.view.backgroundColor = .white
        self.view.addSubview(weatherView)
        self.view.addSubview(collectionViewer)
        self.collectionViewer.addSubview(menuListCollectionView)
    }
    override func setupAnchors() {
        _ = weatherView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 48, leftConstant: leftConstant, bottomConstant: 0, rightConstant: rightConstant, widthConstant: 0, heightConstant: heightConstant)
        
        _ = collectionViewer.anchor(self.weatherView.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: leftConstant, leftConstant: leftConstant, bottomConstant: 0, rightConstant: leftConstant, widthConstant: 0, heightConstant: 2*heightConstant)
        
        _ = menuListCollectionView.anchor(self.collectionViewer.topAnchor, left: self.collectionViewer.leftAnchor, bottom: self.collectionViewer.bottomAnchor, right: self.collectionViewer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    override func fetchData() {
        Alamofire.request("http://35.159.15.121:8080/weather/getWeatherInfoByCityNameAndLangCode?cityname=%C4%B0stanbul&language=en").responseJSON { response in
            if let data = response.data{
                let jsonData = try? JSON(data: data)
                
                if let desc = jsonData!["description"].string {
                    self.weatherView.label.text = desc
                }
                
                if let icon = jsonData!["icon"].string {
                    weatherView.weatherImage.image = UIImage(data: try? Data(contentsOf: URL
                        icon))
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: menuListCollectionView.frame.height-16, height: menuListCollectionView.frame.height-16);
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = menuListCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCellView
            return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 8, 0, 8)
        
    }
    


}

