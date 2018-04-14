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

class MainVC: BaseController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    var foodArray = [String]()
    var parkArray = [[String]]()
    
    lazy var carParkStatusTableView : UITableView = {
        let collectionView = UITableView()
        collectionView.tag = 1
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(CarParkView.self, forCellReuseIdentifier: "cellTwo")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.layer.borderColor = UIColor.lightGray.cgColor
        collectionView.layer.borderWidth = 0.3
        collectionView.layer.backgroundColor = UIColor.white.cgColor
        collectionView.layer.cornerRadius = 3
        return collectionView
    }()
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
        self.view.addSubview(carParkStatusTableView)
        self.collectionViewer.addSubview(menuListCollectionView)
    }
    override func setupAnchors() {
        _ = weatherView.anchor(self.view.topAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: 48, leftConstant: leftConstant, bottomConstant: 0, rightConstant: rightConstant, widthConstant: 0, heightConstant: heightConstant)
        
        _ = collectionViewer.anchor(self.weatherView.bottomAnchor, left: self.view.leftAnchor, bottom: nil, right: self.view.rightAnchor, topConstant: leftConstant, leftConstant: leftConstant, bottomConstant: 0, rightConstant: leftConstant, widthConstant: 0, heightConstant: 2*heightConstant)
        
        _ = menuListCollectionView.anchor(self.collectionViewer.topAnchor, left: self.collectionViewer.leftAnchor, bottom: self.collectionViewer.bottomAnchor, right: self.collectionViewer.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        
        _ = carParkStatusTableView.anchor(self.menuListCollectionView.bottomAnchor, left: self.view.leftAnchor, bottom: self.view.bottomAnchor, right: self.view.rightAnchor, topConstant: leftConstant, leftConstant: leftConstant, bottomConstant: 96, rightConstant: rightConstant, widthConstant: 0, heightConstant: 0)
    }
    
    override func fetchData() {
        
        Alamofire.request("http://35.159.15.121:8080/weather/getWeatherInfoByCityNameAndLangCode?cityname=%C4%B0stanbul&language=en").responseJSON { response in
            if let data = response.data{
                let jsonData = try? JSON(data: data)
            
                
                if let icon = jsonData!["icon"].string {

                    
                    let url = URL(string: icon)
                    if let data = try? Data(contentsOf: url!){
                        if let desc = jsonData!["description"].string {
                            self.weatherView.label.text = desc
                        }
                        self.weatherView.weatherImage.image = UIImage(data: data)
                    }
                }
            }
        }
        
        Alamofire.request("http://35.159.15.121:8080/foodAndBeverage/restaurantList?language=tr&location=ist").responseJSON { response in
            if let data = response.data{
                let jsonData = try? JSON(data: data)
                if let results = jsonData!["results"].array {
                    print(results)
                    for r in results{
                        self.foodArray.append(r["title"].string!)
                    }
                    self.menuListCollectionView.reloadData()
                }
            }
        }
        
        Alamofire.request("http://35.159.15.121:8080/carparkStatus/getCarparkStatus").responseJSON { response in
            if let data = response.data{
                let jsonData = try? JSON(data: data)
                if let results = jsonData!["Colors"].array {
                    for r in results{
                        var tempStringArray = [String]()
                        tempStringArray.append(r["ColorName"].string!)
                        tempStringArray.append(r["CarParkFloors"]["Floor1"].string!)
                        tempStringArray.append(r["CarParkFloors"]["Floor2"].string!)
                        tempStringArray.append(r["CarParkFloors"]["Floor3"].string!)
                        tempStringArray.append(r["CarParkFloors"]["Floor4"].string!)
                        self.parkArray.append(tempStringArray)
                    }
                }
            }
            print(self.parkArray)
            self.carParkStatusTableView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodArray.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: menuListCollectionView.frame.height-16, height: menuListCollectionView.frame.height-16);
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = menuListCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCellView
            cell.nameOfTheRestaurant.text = foodArray[indexPath.item]
            return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parkArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = carParkStatusTableView.dequeueReusableCell(withIdentifier: "cellTwo") as! CarParkView
        cell.mainLabel.text = parkArray[indexPath.item][0]
        cell.firstFloor.text = parkArray[indexPath.item][1]
        cell.secondFloor.text = parkArray[indexPath.item][2]
        cell.thirdFloor.text = parkArray[indexPath.item][3]
        cell.fourthFloor.text = parkArray[indexPath.item][4]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = carParkStatusTableView.dequeueReusableCell(withIdentifier: "cellTwo") as! CarParkView
        headerCell.backgroundColor = UIColor(red: 42.0/255, green: 13.0/255, blue: 99.0/255, alpha: 0.8)
        headerCell.mainLabel.text = "Name"
        headerCell.firstFloor.text = "First Floor"
        headerCell.secondFloor.text = "Second Floor"
        headerCell.thirdFloor.text = "Third Floor"
        headerCell.fourthFloor.text = "Fourth Flor"
        return headerCell
    }
    

}

