//
//  ViewController.swift
//  295368_PresentationController
//
//  Created by Jun Yamashita on 2020/10/02.
//
//  Original code was written by soushi t (@Sossiii) in the article on https://qiita.com/Sossiii/items/7f8dc9e0ed0d87d2a2aa

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func modalAction(_ sender: AnyObject) {
        let modalVC = self.storyboard?.instantiateViewController(withIdentifier: "modal") as! ModalViewController
        modalVC.modalPresentationStyle = .custom
        modalVC.transitioningDelegate = self
        
        // MARK: - delegate の移譲先を設定
        modalVC.sendMailDelegate = self
        
        present(modalVC, animated: true, completion: nil)
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
        
        // MARK: - 上下マージンを PresentationController() で指定した値以外にしたい場合
        //return PresentationController(presentedViewController: presented, presenting: presenting, viewMargin: CGPoint(x: 100, y: 100))
    }
}

// MARK: - ViewController 側での処理
extension ViewController: SendMailDelegate {
    func sendMail() {
        print("ViewController 側で処理したよ。")
        
        // わかりやすいように、背景色をランダムに変えてみる
        view.backgroundColor = [ UIColor.red, UIColor.yellow, UIColor.green].randomElement()
    }
}
