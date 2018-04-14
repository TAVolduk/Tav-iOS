//
//  File.swift
//  Anadolu Kafe
//
//  Created by Sadik Ekin Ozbay on 21.03.2018.
//  Copyright © 2018 AnadoluRH. All rights reserved.
//

import UIKit

class ItemCellView: UICollectionViewCell {
    
    lazy var imageViewOfTheMeal: UIImageView = {
        return UIImageView(image: UIImage(named: "cutlery"))
    }()
    
    lazy var nameOfTheRestaurant: UILabel = {
        let label = UILabel()
        label.text = "Burger King"
        label.numberOfLines = 0
        label.font = UIFont(name:"Futura-Bold", size: 8.0)
        label.textColor = UIColor.gray
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.3
        
        setupViews()
        setupAnchors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(imageViewOfTheMeal)
        self.addSubview(nameOfTheRestaurant)
        self.backgroundColor = UIColor(red: 206, green: 215, blue: 229, alpha: 0.6)
    }
    
    func setupAnchors() {
        _ =  self.imageViewOfTheMeal.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 6, leftConstant: 6, bottomConstant: 0, rightConstant: 6, widthConstant: 0, heightConstant: 48)
        
        _ = self.nameOfTheRestaurant.anchor(self.imageViewOfTheMeal.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 3, leftConstant: 6, bottomConstant: 0, rightConstant: 6, widthConstant: 0, heightConstant: 32)
    }
    
    
}
