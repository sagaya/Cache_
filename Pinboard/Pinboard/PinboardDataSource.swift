//
//  PinboardDataSource.swift
//  Pinboard
//
//  Created by Sagaya Abdulhafeez on 10/05/2019.
//  Copyright © 2019 cosmo. All rights reserved.
//

import UIKit
import CacheFramework



class PinboardDataSource: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    typealias DidScroll = ((CGFloat) -> ())
    typealias DidSelectRow = ((IndexPath) -> ())
    var pins: [Pin]?
    var didScroll: DidScroll?
    var didSelectRow: DidSelectRow?
    init(didScroll: @escaping DidScroll, didSelectRow: @escaping DidSelectRow) {
        self.didScroll = didScroll
        self.didSelectRow = didSelectRow
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pins?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PinCell else{
            return UICollectionViewCell()
        }
        let pin = pins?[indexPath.row]
        cell.backgroundColor = UIColor(hex: pin?.color ?? "")
        cell.imageView.setImage(withUrl: pin?.urls.raw ?? "", placeholder: nil)
        cell.layoutIfNeeded()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2 ) - 30
        return CGSize(width: width, height: 270)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 30, left: 20, bottom: 0, right: 20)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       self.didScroll?(scrollView.contentOffset.y)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectRow?(indexPath)
    }
   
}
