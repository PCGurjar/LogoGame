//
//  ScoreViewController.swift
//  LogoGame
//
//  Created by Poonamchand on 14/08/21.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var labelAttempted: UILabel!
    @IBOutlet weak var labelTotalLogo: UILabel!
    @IBOutlet weak var labelCorrectAnswer: UILabel!
    @IBOutlet weak var labelWrongAnswer: UILabel!
    @IBOutlet weak var labelTimeTaken: UILabel!
    
    var scoreModel: ScoreModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
        setResult()
    }
    
    func setResult() {
        labelTotalLogo.text = "\(scoreModel.totalQuiz)"
        labelAttempted.text = "\(scoreModel.attempted)"
        labelCorrectAnswer.text = "\(scoreModel.correctAnswer)"
        labelWrongAnswer.text = "\(scoreModel.wrongAnswer)"
        labelTimeTaken.text = "\(scoreModel.timeTaken)"
    }

    @IBAction func btnTryAgainClick(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
