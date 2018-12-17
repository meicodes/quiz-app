//
//  ViewController.swift
//  Quizzler
//

import UIKit

class ViewController: UIViewController {
    
    //Place your instance variables here
    let allQuestions = QuestionBank()
    var index : Int
    var score :Int
    var currentQuestion : Question
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        self.index = 0
        self.score = 0
        self.currentQuestion = allQuestions.list[index]
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        var pickedAnswer : Bool = false
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        
        if checkAnswer(question: currentQuestion, answer: pickedAnswer) {
            ProgressHUD.showSuccess("Correct")
            score += 1
        } else {
            ProgressHUD.showError("Wrong")
        }
        
        nextQuestion()
        updateUI()
    }
    
    func updateUI() {
        currentQuestion = allQuestions.list[index]
        questionLabel.text = currentQuestion.questionText
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(index + 1) / 13"
        progressBar.frame.size.width = view.frame.size.width / 13 * CGFloat(index + 1)
    }

    func nextQuestion() {
        if index < 12 {
            index += 1
            currentQuestion = allQuestions.list[index]
        } else {
            let alert = UIAlertController(title: "Awesome", message: "Start over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })
            
            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func checkAnswer(question : Question, answer : Bool) -> Bool {
        return question.answer == answer
    }
    
    func startOver() {
        index = 0
        score = 0
        updateUI()
    }
}
