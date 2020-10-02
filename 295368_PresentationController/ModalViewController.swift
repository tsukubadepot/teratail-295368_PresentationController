//
//  ModalViewController.swift
//  295368_PresentationController
//
//  Created by Jun Yamashita on 2020/10/02.
//
//  Original code was written by soushi t (@Sossiii) in the article on https://qiita.com/Sossiii/items/7f8dc9e0ed0d87d2a2aa
import UIKit

// MARK: - プロトコルは class を継承させる。継承させなければ weak キーワードをつけることができない
protocol SendMailDelegate: class {
    func sendMail()
}

class ModalViewController: UIViewController {
    // MARK: - ボタンのインスタンス
    lazy var mailSendButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("ご意見・ご要望はこちら", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(self.clickSendMailButton(sender:)), for: .touchUpInside)
        button.backgroundColor = .yellow
        
        return button
    }()
    
    // MARK:　- delegate に使うプロパティは、循環参照を防止するために weak キーワードをつける
    weak var sendMailDelegate: SendMailDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .lightGray
        
        // MARK: -  この段階では、標準の View Controller のサイズしか求まらない
        let viewSize = (width: self.view.bounds.width, height: self.view.bounds.height)
        print(#function, viewSize)
        
        // ここでは、ボタンのインスタンスを作って、view に配置するだけ
        self.view.addSubview(mailSendButton)
    }
    
    // MARK: - レイアウトする段階になって初めて実際のサイズが判明する
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        // viewDidLoad で計算した viewSize と比較してみるとわかりやすい
        let viewSize = (width: self.view.bounds.width, height: self.view.bounds.height)
        print(#function, viewSize)
        
        // ボタンをモーダルビューの中央に移動させ、文字が入るようにサイズを調整する
        mailSendButton.center = CGPoint(x: viewSize.width / 2, y: viewSize.height / 2)
        mailSendButton.sizeToFit()
    }
    
    @objc func clickSendMailButton(sender: UIButton){
        print("押したよ")
        sendMailDelegate?.sendMail()
        
        //　ボタンを押したらモーダルウィンドウを閉じる
        dismiss(animated: true, completion: nil)
    }
}
