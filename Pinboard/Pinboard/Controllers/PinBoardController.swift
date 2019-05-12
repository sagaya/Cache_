//
//  PinBoardController.swift
//  Pinboard
//
//  Created by Sagaya Abdulhafeez on 10/05/2019.
//  Copyright © 2019 cosmo. All rights reserved.
//

import UIKit
import CacheFramework
class PinBoardController: UICollectionViewController {
    var dataSource:PinboardDataSource!
    private let refreshControl = UIRefreshControl()
    let customRefresh = CutomRefresh()
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = PinboardDataSource(didScroll: scrollViewDidScroll, didSelectRow: didSelectRow)
        collectionView.backgroundColor = .white
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        collectionView.register(PinCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.showsVerticalScrollIndicator = false
        
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNow(_:)), for: .valueChanged)
        setupRefresh()
        fetchImages()
    }
    
    func setupRefresh(){
        customRefresh.frame = refreshControl.bounds
        refreshControl.addSubview(customRefresh)
    }
    func scrollViewDidScroll(_ toOffset: CGFloat){
        if refreshControl.isRefreshing{
            customRefresh.animate()
        }else{
            customRefresh.stopAnimation()
        }
    }
    func fetchImages(){
        self.refreshControl.beginRefreshing()
        CacheService.shared.fetchData(forUrl: "https://pastebin.com/raw/wgkJgazE", completion: {[weak self] (response: [Pin]) in
            self?.dataSource.pins = response
            DispatchQueue.main.async {
                self?.refreshControl.endRefreshing()
                self?.collectionView.reloadData()
            }
        }) {[weak self] (err) in
            print(err)
        }
    }
    @objc func refreshNow(_ sender: UIRefreshControl){
        self.fetchImages()
    }
    
    var detailController: PinDetailController!
    var startingFrame: CGRect?
    
    //Constraints
    
    var detailViewTopAnchor:NSLayoutConstraint?
    var detailLeadingAnchor:NSLayoutConstraint?
    var detailWidthAnchor:NSLayoutConstraint?
    var detailHeightAnchor:NSLayoutConstraint?

    func setupDetailController(for indexPath: IndexPath){
        let detailController = PinDetailController()
        guard let cell = collectionView.cellForItem(at: indexPath) as? PinCell else {return}
        let newPincell = PinCell()
        newPincell.imageView.image = cell.imageView.image
        detailController.backgroundCell = newPincell
        
        detailController.view.layer.cornerRadius = 11
        detailController.dismissHandler = {[weak self] in
            self?.handleDismissFullscreen(indexPath)
        }
        
        self.detailController = detailController
        let fullscreenView = self.detailController.view!
        view.addSubview(fullscreenView)
        fullscreenView.translatesAutoresizingMaskIntoConstraints = false
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        addChild(self.detailController)
        
        self.collectionView.isUserInteractionEnabled = false
        detailViewTopAnchor = fullscreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        detailLeadingAnchor = fullscreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        detailWidthAnchor = fullscreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        detailHeightAnchor = fullscreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        NSLayoutConstraint.activate([
            detailViewTopAnchor!,
            detailLeadingAnchor!,
            detailHeightAnchor!,
            detailWidthAnchor!
        ])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
                self.detailViewTopAnchor?.constant = 0
                self.detailLeadingAnchor?.constant = 0
                self.detailWidthAnchor?.constant = self.view.frame.width
                self.detailHeightAnchor?.constant = self.view.frame.height
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    func handleDismissFullscreen(_ indexPath:IndexPath){
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.detailController.view.layer.cornerRadius = 11
            guard let startingFrame = self.startingFrame else { return }
            self.detailViewTopAnchor?.constant = startingFrame.origin.y
            self.detailLeadingAnchor?.constant = startingFrame.origin.x
            self.detailWidthAnchor?.constant = startingFrame.width
            self.detailHeightAnchor?.constant = startingFrame.height
            self.view.layoutIfNeeded()
            
        }, completion: { _ in
            self.detailController.view.removeFromSuperview()
            self.detailController.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
    
    func didSelectRow(_ index: IndexPath){
        self.setupDetailController(for: index)
    }
}
