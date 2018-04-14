//
//  File.swift
//  TavOlduk
//
//  Created by Sadik Ekin Ozbay on 14.04.2018.
//  Copyright © 2018 Sadik Ekin Ozbay. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    lazy var weatherImage: UIImageView = {
        let IV = UIImageView(image: UIImage(named: "sunny"))
        return IV
    }()
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Sunny"
        label.textAlignment = .center
        label.font = UIFont(name: "Futura", size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(weatherImage)
        self.addSubview(label)
    }
    
    func setupAnchor() {
        _ = weatherImage.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 6, leftConstant: 6, bottomConstant: 6, rightConstant: 0, widthConstant: 36, heightConstant: 0)
        
        _ = label.anchor(self.topAnchor, left: self.weatherImage.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 6, leftConstant: 6, bottomConstant: 6, rightConstant: 6, widthConstant: 0, heightConstant: 0)
    }
}
