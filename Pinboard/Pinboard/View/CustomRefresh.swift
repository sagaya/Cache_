//
//  CustomRefresh.swift
//  Pinboard
//
//  Created by Sagaya Abdulhafeez on 10/05/2019.
//  Copyright © 2019 cosmo. All rights reserved.
//

import UIKit


class CutomRefresh: UIView {
    let loaderContainer = UIView()
    var loaderImage = UIImageView(image: #imageLiteral(resourceName: "loader"))
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(loaderContainer)
        loaderContainer.addSubview(loaderImage)
        loaderImage.contentMode = .scaleAspectFit
        loaderContainer.backgroundColor = .darkGray
        loaderImage.translatesAutoresizingMaskIntoConstraints = false
        loaderContainer.translatesAutoresizingMaskIntoConstraints = false
        loaderContainer.layer.cornerRadius = 15
        loaderContainer.clipsToBounds = true
        NSLayoutConstraint.activate([
            loaderContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            loaderContainer.widthAnchor.constraint(equalToConstant: 30),
            loaderContainer.heightAnchor.constraint(equalToConstant: 30),
            loaderContainer.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loaderImage.centerXAnchor.constraint(equalTo: loaderContainer.centerXAnchor),
            loaderImage.widthAnchor.constraint(equalToConstant: 15),
            loaderImage.heightAnchor.constraint(equalToConstant: 15),
            loaderImage.centerYAnchor.constraint(equalTo: loaderContainer.centerYAnchor),
            
            ])
    }
    var isAnimating = false
    func animate(){
        isAnimating = true
        UIView.animate(withDuration: 1.0,delay: 0.5, animations: {
            self.loaderImage.transform = CGAffineTransform(rotationAngle: 180)
        }) { (_) in
            UIView.animate(withDuration: 2.0, delay: 0.5 , animations: {
                self.loaderImage.transform = .identity
            }, completion: { (_) in
                if self.isAnimating{
                    self.animate()
                }
            })
        }
    }
    func stopAnimation(){
        self.isAnimating = false
        UIView.animate(withDuration: 1) {
            self.loaderImage.transform = .identity
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
