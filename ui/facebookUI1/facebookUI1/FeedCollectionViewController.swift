//
//  FeedCollectionViewController.swift
//  facebookUI1
//
//  Created by ishikura keisuke on 2016/10/19.
//  Copyright © 2016年 ishikura keisuke. All rights reserved.
//

import UIKit


class FeedCollectionViewController: UICollectionViewController {
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 20
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell:FeedCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCollectionViewCell
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // フィードをスクロールするたびに、移動距離を通知する
        let userInfo: [String: Any] = [
            "offsety": scrollView.contentOffset.y
        ]
        NotificationCenter.default.post(name: .feedScrollMoveNotificationKey, object: nil,userInfo:userInfo)
    }
    
}

