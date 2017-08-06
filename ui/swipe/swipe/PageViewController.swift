//
//  PageViewController.swift
//  swipe
//
//  Created by ishikurak73 on 2016/09/22.
//  Copyright © 2016年 ishikurak73. All rights reserved.
//

import UIKit


class PageViewController: UIPageViewController,UIPageViewControllerDataSource {
    
    let sboard: UIStoryboard? = UIStoryboard(name:"Main", bundle:nil)
    
    var pageViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage:UIImage(named: "backBokashi.png")!)
        //自分自身を指定
        dataSource = self
        //1ページ目をインスタンス化
        let firstViewController: FirstViewController = sboard!.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        //2ページ目をインスタンス化
        let secondViewController: SecondViewController = sboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        //3ページ目をインスタンス化
        let thirdViewController: ThirdViewController = sboard!.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        //全ページを配列に格納
        pageViewControllers = [firstViewController,secondViewController,thirdViewController]
        //UIPageViewControllerに表示対象を設定
        setViewControllers([pageViewControllers[0]], direction: .forward, animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController:UIViewController) -> UIViewController? {
        //右にスワイプした場合に表示したいviewControllerを返す
        //ようはページを戻す
        //今表示しているページは何ページ目か取得する
        let index = pageViewControllers.index(of: viewController)
        if index == 0 {
            //1ページ目の場合は何もしない
            return nil
        } else {
            //1ページ目の意外場合は1ページ前に戻す
            return pageViewControllers[index!-1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //左にスワイプした場合に表示したいviewControllerを返す
        //ようはページを進める
        //今表示しているページは何ページ目か取得する
        let index = pageViewControllers.index(of: viewController)
        if index == pageViewControllers.count-1 {
            //最終ページの場合は何もしない
            return nil
        } else {
            //最終ページの意外場合は1ページ進める
            return pageViewControllers[index!+1]
        }
    }
}
