//
//  Image+Extension.swift
//  CacheFramework
//
//  Created by Sagaya Abdulhafeez on 10/05/2019.
//  Copyright © 2019 cosmo. All rights reserved.
//

import UIKit

public extension UIImageView{
    public func transition(toImage image: UIImage?){
        UIView.transition(with: self, duration: 0.5, options: [.transitionCrossDissolve], animations: {
            self.image = image
        }, completion: nil)
    }
    
    public func setImage(withUrl url:String, placeholder: UIImage?){
        if placeholder != nil{
            self.image = placeholder
        }
        CacheLibrary.shared.loadData(fromUrl: url, completion: { (data) in
            let newImage = UIImage(data: data)
            self.image = newImage
        }) { (err) in
            print(err)
        }
    }
    
}
