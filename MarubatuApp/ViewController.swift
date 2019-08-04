//
//  ViewController.swift
//  MarubatuApp
//
//  Created by 吉澤優衣 on 2019/08/03.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // クイズの問題を表示
    @IBOutlet weak var questionLabel: UILabel!
    
    // クイズの問題を管理する
    var currentQuestionNum: Int = 0
    
    // ヒント管理
    var isHint: Bool = false
    
    // 正解数
    var result: [Bool] = []    // let/var 配列名: [型] = [値1, 値2, 値3, ...] で配列を作成
    
    @IBOutlet weak var maru: UIButton!
    // 問題を管理
    let questions: [[String: Any]] = [    // ?なんで二重括弧なの?
        ["question": "iPhoneアプリを開発する統合環境はZcodeである",
         "answer": false,
         "hint": "バツだよ"
        ],
        ["question": "Xcode画面の右側にはユーティリティーズがある",
         "answer": true,
         "hint": "マルだよ"
        ],
        ["question": "UILabelは文字列を表示する際に利用する",
         "answer": true,
         "hint": "マルだよ"
        ],
        ["question": "ドラえもんは常に地面から浮いている",
         "answer": true,
         "hint": "マルだよ"
        ],
    ]
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    //    maru.isHidden = true
        
    }
    
    // 問題を表示する関数
    func showQuestion() {
        // currentQuestionNum(問題番号)の問題を取得
        let question = questions[currentQuestionNum]    // 配列を作ってる。?questions はなぜ必要?
        
        //問題(辞書型)から Key を指定して内容を取得
        if let que = question["question"] as? String {    // ?は?
            // question Key の中身を Label に代入
            questionLabel.text = que
        }
    }
    

    // 回答をチェックする関数
    // 正解なら次の問題を表示します
    func checkAnswer(yourAnswer: Bool) {
        // どの問題か取得する
        let question = questions[currentQuestionNum]    // ?上にも同じコードあるけど?
        
        // 問題の答えを取り出す
        if let ans = question["answer"] as? Bool {    // ?上がわかればわかるはず?
            
            // 選択された答えと問題の答えを比較する
            if yourAnswer == ans {
                // currentQuestionNumを1足す
                currentQuestionNum += 1
                // 正解の数だけ追加
                result.append(true)    // 要素を追加
                
                if currentQuestionNum >= questions.count {
                 showAlert(message: "\(questions.count)問中\(result.count)問正解しました！")
                 isHint = false
                    currentQuestionNum = 0
                } else {
                    showAlert(message: "正解！")
                }
            
            } else {
                // 不正解
                currentQuestionNum += 1
                if currentQuestionNum >= questions.count {
                    showAlert(message: "\(questions.count)問中\(result.count)問正解しました！")
                    isHint = false
                    currentQuestionNum = 0
                } else {
                showAlert(message: "不正解...")
                }
            }
                
        }else{
            print("答えが入ってません")
            return
        }

        
        
        // 問題を表示します。
        // 正解であれば次の問題が、不正解であれば同じ問題が再表示されます。
        showQuestion()
    }

    // アラートを表示する関数
    func showAlert(message: String) {
        // アラートの作成
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        // アラートのアクション（ボタン部分の定義）
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        // 作成した alert に閉じるボタンを追加
        alert.addAction(close)
        // アラートを表示する
        present(alert, animated: true, completion: nil)
    }
    
    
    
    // ヒントボタン
    @IBAction func ヒント(_ sender: Any) {
        if !isHint {
            let question = questions[currentQuestionNum]
            if let que = question["hint"]as? String {
                // question Key の中身を Label に代入
                showAlert(message: que)
                isHint = true
            }
        } else {
            showAlert (message: "もう使ったよ")
        }
    }
    
    
    // バツボタン
    @IBAction func noButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    
    // マルボタン
    @IBAction func yesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
}


