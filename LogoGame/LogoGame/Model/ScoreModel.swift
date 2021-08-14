//
//  ScoreModel.swift
//  LogoGame
//
//  Created by Poonamchand on 14/08/21.
//

import Foundation


struct ScoreModel {
    
    var startTime: TimeInterval
    var endTime: TimeInterval
    
    var totalQuiz: Int
    var correctAnswer: Int
    var wrongAnswer: Int
    var attempted: Int
    
    lazy var timeTaken: String = {
        let timeTake = endTime - startTime
        let (h, m, s) = secondsToHoursMinutesSeconds(seconds: Int(timeTake))
        
        var result = ""
        if h > 0 {
            result += "\(h) Hours "
        }
        if m > 0 {
            result += "\(m) Minutes "
        }
        if s > 0 {
            result += "\(s) Seconds"
        }
        
        return result
    }()

    func secondsToHoursMinutesSeconds(seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
