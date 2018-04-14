//
//  BaseViewController.swift
//  RhExtranet
//
//  Created by AnadoluRH on 4.10.2017.
//  Copyright © 2017 AnadoluRH. All rights reserved.
//

import UIKit
import PopupDialog


class BaseController: UIViewController , UINavigationControllerDelegate {
    
    let leftConstant = CGFloat(16)
    let rightConstant = CGFloat(16)
    let heightConstant = CGFloat(48)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        fetchData()
        setupViews()
        setupAnchors()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        didReceiveMemoryWarningAfterBase()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    
    
    
    //Oluşturulacak Viewlar bu metodda gerçekleşecek.
    func setupViews(){
        
        
    }
    
    //Anchorlar ile ilgili sıralama bu metodlarda yapılacak.
    func setupAnchors(){
        
        
    }
    
    //Memory düşük bilgisi gelirse
    func didReceiveMemoryWarningAfterBase(){
        
        
    }
    //Api seviyesinde çağırımlar bu metodlarda gerçekleştirilecek
    func fetchData(){
        
        
        
    }
    
    
    
}
