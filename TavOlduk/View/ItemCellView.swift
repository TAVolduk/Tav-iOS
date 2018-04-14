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
        return UIImageView(image: UIImage(named: "adana"))
    }()
    
    lazy var nameOfTheMeal: UILabel = {
        let label = UILabel()
        label.text = "Adana"
        label.numberOfLines = 0
        label.font = UIFont(name:"Futura-Bold", size: 18.0)
        label.textColor = UIColor.gray
        label.textAlignment = .left
        return label
    }()
    
    lazy var priceOfTheMeal: UILabel = {
        let label = UILabel()
        label.text = "19.99 TL"
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.font = UIFont(name:"Futura-Bold", size: 18.0)
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupAnchors()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.addSubview(imageViewOfTheMeal)
        self.addSubview(nameOfTheMeal)
        self.addSubview(priceOfTheMeal)
    }
    
    func setupAnchors() {
        _ =  self.imageViewOfTheMeal.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 6, leftConstant: 6, bottomConstant: 0, rightConstant: 6, widthConstant: 0, heightConstant: self.frame.height*8/10)
        
        _ = self.nameOfTheMeal.anchor(self.imageViewOfTheMeal.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 3, leftConstant: 24, bottomConstant: 0, rightConstant: 0, widthConstant: self.frame.width/2, heightConstant: self.frame.height*1/10)
        
        _ = self.priceOfTheMeal.anchor(self.imageViewOfTheMeal.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 3, leftConstant: 6, bottomConstant: 0, rightConstant: 24, widthConstant: self.frame.width/2, heightConstant: self.frame.height*1/10)
    }
    
    
}
