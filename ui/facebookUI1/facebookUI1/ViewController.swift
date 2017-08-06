//
//  ViewController.swift
//  facebookUI1
//
//  Created by ishikura keisuke on 2016/10/16.
//  Copyright © 2016年 ishikura keisuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // 各コンテナビューのOutlet指定
    @IBOutlet weak var topNavContainer: UIView!
    @IBOutlet weak var topTabContainer: UIView!
    @IBOutlet weak var feedContainer: UIView!
    
    // 各コンテナビューの起動時のY座標を保持する
    var topNavOrgPosisionY: CGFloat?
    var topTabOrgPosisionY: CGFloat?
    var feedOrgPosisionY: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // フィードがスクロールされた時に通知設定
        NotificationCenter.default.addObserver(self,selector: #selector(self.feedScrollMove),name: .feedScrollMoveNotificationKey,object: nil)
        
        // 各コンテナビューの起動時のY座標を保持し、移動距離算出時の起点とする
        topNavOrgPosisionY = topNavContainer.frame.origin.y
        topTabOrgPosisionY = topTabContainer.frame.origin.y
        feedOrgPosisionY = feedContainer.frame.origin.y
    }

    // フィードがスクロールされた時の通知で起動
    // フィードのスクロールに合わせで、各コンテナビューを移動させる
    func feedScrollMove(notification: NSNotification) {
        
        // フィードをスクロールした距離を取得する
        let posisionY:CGFloat = notification.userInfo?["offsety"] as! CGFloat
        
        // タブとフィードそのものの移動
        if posisionY >= 0 && posisionY <= 100 {
            topTabContainer.frame.origin.y = topTabOrgPosisionY! - posisionY
            feedContainer.frame.origin.y = feedOrgPosisionY! - posisionY
        }else if posisionY > 100 {
            topTabContainer.frame.origin.y = topTabOrgPosisionY! - 100
            feedContainer.frame.origin.y = feedOrgPosisionY! - 100
        }else{
            topTabContainer.frame.origin.y = topTabOrgPosisionY!
            feedContainer.frame.origin.y = feedOrgPosisionY!
        }
        
        // サーチバーの移動
        if posisionY >= 30 && posisionY <= 100 {
            topNavContainer.frame.origin.y = topNavOrgPosisionY! - posisionY + 30
        }else if posisionY > 100 {
            topNavContainer.frame.origin.y = topNavOrgPosisionY! - 100
        }else{
            topNavContainer.frame.origin.y = topNavOrgPosisionY!
        }
    }
}

