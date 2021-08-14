//
//  LogoViewModel.swift
//  LogoGame
//
//  Created by Poonamchand on 14/08/21.
//

import Foundation

class LogoViewModel {

    var arrLogos = Logos()
    var startTime: TimeInterval!
    var currentIndex = 0
    var scoreModel: ScoreModel!
    
    var arrWord = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    // get data from json
    func getLogos(completions: (_ arrLogo: [LogoModel]?)-> Void) {
        guard let path = Bundle.main.path(forResource: "exercise", ofType: "json") else { return }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            self.arrLogos = try! JSONDecoder().decode(Logos.self, from: data)
            
            completions(self.arrLogos)
        } catch {
            print(error)
            completions(nil)
        }
    }
    
    func initializeScoreModel() {
        scoreModel = ScoreModel(startTime: Date().timeIntervalSince1970, endTime: 0, totalQuiz: arrLogos.count, correctAnswer: 0, wrongAnswer: 0, attempted: 0)
    }
    
    func reInitializeLogos() {
        getLogos { logos in
            self.arrLogos = logos ?? Logos()
        }
    }
    
    func updateScoreOnFinish() {
        scoreModel.endTime = Date().timeIntervalSince1970
        let attempted = arrLogos.filter({ model in
            return model.answer?.count ?? 0 > 0
        })
        scoreModel.attempted = attempted.count
        
        scoreModel.correctAnswer = attempted.filter({ model in
            return model.answer == model.name
        }).count
        
        scoreModel.wrongAnswer = attempted.filter({ model in
            return model.answer != model.name
        }).count
    }
    
    
}
