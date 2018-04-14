//
//  File.swift
//  TavOlduk
//
//  Created by Sadik Ekin Ozbay on 14.04.2018.
//  Copyright © 2018 Sadik Ekin Ozbay. All rights reserved.
//

import UIKit




class CarParkView : UITableViewCell {
    lazy var mainLabel : UILabel = {
        let label = UILabel()
        label.text = "Outdoor"
        label.numberOfLines = 0
        label.font = UIFont(name:"Futura-Bold", size: 12.0)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    lazy var firstFloor : UILabel = {
        let label = UILabel()
        label.text = "Outdoor"
        label.numberOfLines = 0
        label.font = UIFont(name:"Futura-Bold", size: 12.0)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    lazy var secondFloor : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.numberOfLines = 0
        label.font = UIFont(name:"Futura-Bold", size: 12.0)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    lazy var thirdFloor : UILabel = {
        let label = UILabel()
        label.text = "0"
        label.numberOfLines = 0
        label.font = UIFont(name:"Futura-Bold", size: 12.0)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    lazy var fourthFloor : UILabel = {
        let label = UILabel()
        label.text = "259"
        label.numberOfLines = 0
        label.font = UIFont(name:"Futura-Bold", size: 12.0)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupAnchor()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(mainLabel)
        self.addSubview(firstFloor)
        self.addSubview(secondFloor)
        self.addSubview(thirdFloor)
        self.addSubview(fourthFloor)
    }
    
    func setupAnchor() {
        _ = self.mainLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 3, leftConstant: 0, bottomConstant: 3, rightConstant: 0, widthConstant: self.frame.width/3, heightConstant: 0)
        _ = self.firstFloor.anchor(self.topAnchor, left: self.mainLabel.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 3, leftConstant: 0, bottomConstant: 3, rightConstant: 0, widthConstant: self.frame.width/6, heightConstant: 0)
        _ = self.secondFloor.anchor(self.topAnchor, left: self.firstFloor.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 3, leftConstant: 0, bottomConstant: 3, rightConstant: 0, widthConstant: self.frame.width/6, heightConstant: 0)
        _ = self.thirdFloor.anchor(self.topAnchor, left: self.secondFloor.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 3, leftConstant: 0, bottomConstant: 3, rightConstant: 0, widthConstant: self.frame.width/6, heightConstant: 0)
        _ = self.fourthFloor.anchor(self.topAnchor, left: self.thirdFloor.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 3, leftConstant: 0, bottomConstant: 3, rightConstant: 0, widthConstant: self.frame.width/6, heightConstant: 0)
//        - = self.fourthFloor.anchor(self.topAnchor, left: self.thirdFloor.rightAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 3, leftConstant: 0, bottomConstant: 3, rightConstant: 0, widthConstant: self.frame.width/6, heightConstant: 0)
    }
}
