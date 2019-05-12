//
//  PinDetailController.swift
//  Pinboard
//
//  Created by Sagaya Abdulhafeez on 10/05/2019.
//  Copyright © 2019 cosmo. All rights reserved.
//

import UIKit

class PinDetailController: UIViewController {
    var backgroundCell = PinCell()
    var dismissHandler: (() -> ())?
    let navigationBar = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.addSubview(backgroundCell)
        backgroundCell.isUserInteractionEnabled = true
        backgroundCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        backgroundCell.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundCell.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundCell.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundCell.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundCell.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    @objc func dismissView(){
        self.dismissHandler?()
    }

}
