//
//  LogoModel.swift
//  LogoGame
//
//  Created by Poonamchand on 14/08/21.
//


import Foundation

// MARK: - LogoModel
struct LogoModel: Codable {
    
    let imgURL: String
    let name: String
    var answer: String?
    
    lazy var isCorrect: Bool = {
        if let ans = answer {
            return ans == name
        }
        return false
    }()

    enum CodingKeys: String, CodingKey {
        case imgURL = "imgUrl"
        case name
    }
}

typealias Logos = [LogoModel]
