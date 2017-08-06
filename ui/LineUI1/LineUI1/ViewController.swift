//
//  ViewController.swift
//  LineUI1
//
//  Created by ishikura keisuke on 2016/09/15.
//  Copyright © 2016年 ishikura keisuke. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate,UIPageViewControllerDataSource {
    //メッセージ入力用テキストフィールド
    @IBOutlet weak var textField1: UITextField!

    @IBOutlet weak var sendBtn: UIButton!
    
    //スクロールビュー
    @IBOutlet weak var scView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var coverView: UIView!
    
    let sboard: UIStoryboard? = UIStoryboard(name:"Main", bundle:nil)
    var pageViewControllers: [UIViewController] = []
    var stampImageNames1: [String] = []
    var stampImageNames2: [String] = []
    var stampImageNames3: [String] = []
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!) {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // stamp画像の取得
        stampImageNames1 = ["stamp_01.png","stamp_02.png","stamp_03.png","stamp_04.png","stamp_05.png","stamp_06.png","stamp_07.png","stamp_08.png","stamp_09.png","stamp_10.png","stamp_11.png","stamp_12.png","stamp_13.png","stamp_14.png","stamp_15.png","stamp_16.png","stamp_17.png","stamp_18.png","stamp_19.png","stamp_20.png","stamp_21.png","stamp_22.png","stamp_23.png","stamp_24.png","stamp_25.png","stamp_26.png","stamp_27.png","stamp_28.png","stamp_29.png"]
        stampImageNames2 = ["stamp_30.png","stamp_31.png","stamp_32.png","stamp_33.png","stamp_34.png","stamp_35.png","stamp_36.png","stamp_37.png","stamp_38.png","stamp_39.png","stamp_40.png","stamp_41.png","stamp_42.png","stamp_43.png","stamp_44.png","stamp_45.png","stamp_46.png","stamp_47.png","stamp_48.png","stamp_49.png","stamp_50.png","stamp_51.png","stamp_52.png","stamp_53.png","stamp_54.png","stamp_55.png","stamp_56.png","stamp_57.png","stamp_58.png","stamp_59.png"]
        stampImageNames3 = ["stamp_60.png","stamp_61.png","stamp_62.png","stamp_63.png","stamp_64.png","stamp_65.png","stamp_66.png","stamp_67.png","stamp_68.png","stamp_69.png","stamp_70.png","stamp_71.png","stamp_72.png","stamp_73.png","stamp_74.png","stamp_75.png","stamp_76.png","stamp_77.png","stamp_78.png","stamp_79.png","stamp_80.png","stamp_81.png","stamp_82.png","stamp_83.png","stamp_84.png","stamp_85.png","stamp_86.png","stamp_87.png","stamp_88.png","stamp_89.png","stamp_90.png","stamp_91.png","stamp_92.png","stamp_93.png","stamp_94.png","stamp_95.png","stamp_96.png","stamp_97.png","stamp_98.png","stamp_99.png","stamp_100.png"]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scView.backgroundColor = UIColor(patternImage:UIImage(named: "backb.png")!)
        //ユーザ操作を受け付ける設定
        coverView.isUserInteractionEnabled = true
        //タップでキーボードを閉じるジェスチャー登録
        let scViewTapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard(_:)))
        coverView.addGestureRecognizer(scViewTapGesture)
        
        //もろもろUI実装
        sendBtn.layer.cornerRadius = 2.0;
        textField1.delegate = self
        textField1.layer.cornerRadius = 2.0
        
        //カスタムキーボード非表示
        hideCustomKeyboard(isHidden:true)
        
        //スタンプ選択フィールドのページング実装
        let firstCollectionViewController: FirstCollectionViewController = sboard!.instantiateViewController(withIdentifier: "FirstCollectionViewController") as! FirstCollectionViewController
        //スタンプ画像をコレクションビューに設定
        firstCollectionViewController.stampImages = stampImageNames1
        let secondCollectionViewController: SecondCollectionViewController = sboard!.instantiateViewController(withIdentifier: "SecondCollectionViewController") as! SecondCollectionViewController
        //スタンプ画像をコレクションビューに設定
        secondCollectionViewController.stampImages = stampImageNames2
        let thirdCollectionViewController: ThirdCollectionViewController = sboard!.instantiateViewController(withIdentifier: "ThirdCollectionViewController") as! ThirdCollectionViewController
        //スタンプ画像をコレクションビューに設定
        thirdCollectionViewController.stampImages = stampImageNames3
        
        //UIPageViewControllerの取得
        let pageViewController:UIPageViewController? = childViewControllers[0] as? UIPageViewController
        //dataSourceに自分自身を設定
        pageViewController?.dataSource = self
        pageViewControllers = [firstCollectionViewController,secondCollectionViewController,thirdCollectionViewController]
        //UIPageViewControllerに表示対象を設定
        pageViewController?.setViewControllers([pageViewControllers[0]], direction: .forward, animated: false, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController:UIViewController) -> UIViewController? {
        //右にスワイプした場合に表示したいviewControllerを返す
        //ようはページを戻す
        let index = pageViewControllers.index(of: viewController)
        if index == 0 {
            return nil
        } else {
            return pageViewControllers[index!-1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //左にスワイプした場合に表示したいviewControllerを返す
        //ようはページを進める
        let index = pageViewControllers.index(of: viewController)
        if index == pageViewControllers.count-1 {
            return nil
        } else {
            return pageViewControllers[index!+1]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // キーボードを表示する直前、キーボードを非表示にする直前、キーボードを表示した直後のobserver設定
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(ViewController.handleKeyboardDidShowNotification(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
    }
    
    // キーボードのリターンキーを押した時の処理
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードを閉じる
        textField.resignFirstResponder()
        return true
    }
    
    // キーボードを表示する直前の処理
    func handleKeyboardWillShowNotification(_ notification: Notification) {
        // キーボードの高さを取得し、テキストフィールドをキーボードの高さ分上に移動する
        let userInfo = (notification as NSNotification).userInfo!
        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scView.contentOffset.y = keyboardScreenEndFrame.size.height
    }
    
    // キーボードを非表示する直前の処理
    func handleKeyboardWillHideNotification(_ notification: Notification) {
        if containerView.isHidden {
            // テキストフィールドを画面の底に移動
            scView.contentOffset.y = 0
        }
    }
    
    // キーボードを表示した直後の処理
    func handleKeyboardDidShowNotification(_ notification: Notification) {
        //カスタムキーボード非表示
        hideCustomKeyboard(isHidden:true)
    }
    
    // keyboard外がタップされた時に起動する
    func hideKeyBoard(_ sender: UITapGestureRecognizer) {
        if textField1.isFirstResponder {
            // カスタムキーボードを消す
            hideCustomKeyboard(isHidden:true)
            // キーボードを消す
            textField1.resignFirstResponder()
        } else {
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                // テキストフィールドを画面の底に移動
                self.scView.contentOffset.y = 0
            },completion: { finished in
                // カスタムキーボードを消す
                self.hideCustomKeyboard(isHidden:true)
            })
        }
    }
    
    @IBAction func doSwKeyboard(_ sender: UIButton) {
        //キーボードが表示されていない状況でキーボードスイッチボタンがおされた場合
        if self.scView.contentOffset.y == 0 {
            hideCustomKeyboard(isHidden:false)
            UIView.animate(withDuration: 0.2, animations: { () -> Void in
                // キーボードの高さを取得し、テキストフィールドをキーボードの高さ分上に移動する
                self.scView.contentOffset.y = CGFloat(SizeSettings.getKeyboardSizeHeight())
            })
        }else{
            if containerView.isHidden {
                //カスタムキーボード表示
                hideCustomKeyboard(isHidden:false)
                if textField1.isFirstResponder {
                    textField1.resignFirstResponder()
                }
            } else{
                textField1.becomeFirstResponder()
            }
        }
    }
    
    // カスタムkeyboardの表示非表示制御
    func hideCustomKeyboard(isHidden:Bool) {
        //スタンプ選択画面表示非表示切替
        containerView.isHidden = isHidden
    }

}

