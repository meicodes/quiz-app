//
//  Question.swift
//  Quizzler
//
//  Created by Mei on 12/15/18.
//

import Foundation

class Question {
    let questionText : String
    let answer : Bool
    
    init(text : String, correctAnswer : Bool) {
        questionText = text
        answer = correctAnswer
    }
    
}
