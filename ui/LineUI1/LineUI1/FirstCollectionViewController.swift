//
//  FirstCollectionViewController.swift
//  LineUI1
//
//  Created by ishikura keisuke on 2016/09/29.
//  Copyright © 2016年 ishikura keisuke. All rights reserved.
//

import UIKit


class FirstCollectionViewController: UICollectionViewController {
    //スタンプ画像格納用プロパティ
    var stampImages: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        //表示するスタンプ画像の件数を返す
        return stampImages.count
    }
        
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell:FirstCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstCell", for: indexPath) as! FirstCollectionViewCell
        //スタンプ画像配列から画像名を取得してセルに表示する
        cell.stampImg.image = UIImage(named: stampImages[indexPath.item])
        cell.backgroundColor = UIColor.clear
        return cell
    }
}
