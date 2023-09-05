//
//  ViewController.swift
//  MarubatsuApp
//  Created by Fukumoto Asako on 2023/09/02.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var questionLabel: UILabel!
    
    
    // Put Question number
    var currentQuestionNum: Int = 0
    

     var questions: [[String: Any]] = [
  ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        showQestion()
        // Display question after loading
    }
    
    
    // Display question
    func showQestion(){
        if currentQuestionNum >= questions.count {
            questionLabel.text = "問題がありません"
            return
        }
        
        let question = questions[currentQuestionNum]
        
        if let que = question["question"] as? String {
            questionLabel.text = que
        }
    }
    
    // Check answer is corrent proceed next question
    func checkAnswer(yourAnswer: Bool){
        // 現在の問題番号がquestionsの範囲外である場合、アラートを表示して関数を終了
        if currentQuestionNum >= questions.count {
            showAlert(message: "問題がありません")
            return
        }
        let question = questions[currentQuestionNum]
        
        if let ans = question["answer"] as? Bool{
            if yourAnswer == ans {
                // When correct answer
                // Plus 1 to currentQuestionNum and next question
                currentQuestionNum += 1
                showAlert(message: "正解")
            } else {
                // When incorrect
                showAlert(message: "不正解")
            }
            
        } else { // When not answer
            print("答えが入っていません")
            return
        }
        // if currentQuestionNum more tha qty of Question, back to initial question
        if currentQuestionNum >= questions.count {
            currentQuestionNum = 0
        }
        
        
        showQestion() //Correct -> next Question, Incorrect -> Same question.
    }
    
    // アラートを表示する関数
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func tappedNoButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func tappedYesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
    
    // 問題作成画面に遷移するボタンのアクション
    @IBAction func createQuestionButtonTapped(_ sender: Any) {
        let createQuestionVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateQuestionViewController") as! CreateQuestionViewController
        createQuestionVC.questions = self.questions
        createQuestionVC.delegate = self // ViewControllerをデリゲートとして設定
        present(createQuestionVC, animated: true, completion: nil)
    }
    
}
// CreateQuestionViewControllerからのデータを受け取るための拡張
extension ViewController: CreateQuestionDelegate {
    func didUpdateQuestions(updatedQuestions: [[String : Any]]) {
        self.questions = updatedQuestions
        currentQuestionNum = 0
        showQestion()
    }
}


/*
 import UIKit
 
 class ViewController: UIViewController {
 //変数　上の方にまとめておいておく
 //表示中の問題番号を格納　: Int = 0はあってもなくてもいい
 
 var currentQuestionNum: Int = 0
 // 問題
 let questions: [[String: Any]] = [
 [
 "question": "iPhoneアプリを開発する統合環境はZcodeである",
 "answer": false
 ],
 [
 
 "question": "Xcode画面の右側にはユーティリティーズがある",
 "answer": true
 ],
 [
 "question": "UILabelは文字列を表示する際に利用する",
 "answer": true
 ]
 ]
 
 @IBOutlet weak var questionLabel: UILabel!
 override func viewDidLoad() {
 super.viewDidLoad()
 showQuestion()
 //直前にshowQuestionが実行。画面表示された時には問題文が出ている状態になる
 }
 
 //問題を表示する関数
 // 配列の中の0番目の配列を取り出します
 func showQuestion(){
 let questions = questions[currentQuestionNum]
 //indexが範囲外　存在ないところを参照しようとしている　３件しかなかった
 //辞書の中からQeustionというキーを持った中身をStringとして代入できるかどうか　文字列入れているので取り出せるよ
 //関数できたけど実行するのがない
 
 if let que  = questions["question"] as? String{
 questionLabel.text = que
 
 }
 
 }
 
 /*
  //1個めの辞書を取り出す
  [         "question":iphoneアプリ何たら！
  "answer:false
  ]
  */
 //回答チェックの関数、正解なら次の問題を表示
 func checkAnswer(yourAnswer: Bool) {
 
 let question = questions[currentQuestionNum]
 if let ans = question["answer"] as? Bool{
 
 if yourAnswer == ans{
 //正解の時の処理 currentQuestionNum ni
 currentQuestionNum += 1
 showAlert(message: "正解")
 
 
 } else {
 showAlert(message: "不正解😭")
 // 不正解
 
 }
 }else{
 print("答えが入っていません")
 return
 }
 // currentQuestionNumのアたちが問題数以上なら最初の問題へ
 if currentQuestionNum >= questions.count {
 currentQuestionNum = 0
 
 }
 
 showQuestion()
 
 }
 //messageには引数が入る
 func showAlert(message:String){
 //alertのほゆじ領域を作ります　　メッセージを
 let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
 //alert　ウィンドウが表示される　 actionsheetでもいける
 let close = UIAlertAction(title: "閉じる", style:.cancel)
 //ボタンを押すとキャンセルされる
 
 alert.addAction(close)
 //閉じるを表示する
 present(alert, animated: true)
 //表示する　アニメーションを使う
 }
 
 
 
 //関数ボタン処理が入る　IBactionでまとめていると探しやすい
 @IBAction func tappedNoButton(_ sender: Any) {
 checkAnswer(yourAnswer:false)
 
 }
 
 
 @IBAction func tappedYesButton(_ sender: Any) {
 checkAnswer(yourAnswer: true)
 
 }
 
 }
 */

