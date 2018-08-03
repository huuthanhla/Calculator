//
//  ViewController.swift
//  Calculator
//
//  Created by Thành Lã on 8/3/18.
//  Copyright © 2018 MonstarLab. All rights reserved.
//

import UIKit

postfix operator ..
public postfix func ..<T: RawRepresentable> (lhs: T) -> T.RawValue {
    return lhs.rawValue
}

enum Tag: Int {
    case none = 0
    case number0 = 1, number1, number2, number3, number4, number5, number6, number7, number8, number9
    case clear = 11
    case divide = 12, mutiple, minus, plus
    case equal = 16
    
    var operation: String {
        switch self {
        case .divide:
            return "/"
        case .mutiple:
            return "*"
        case .plus:
            return "+"
        case .minus:
            return "-"
        default:
            break
        }
        return ""
    }
}

enum State {
    case normal
    case next
    case continuous
}

class ViewController: UIViewController {
    @IBOutlet weak var numberOnScreenLabel: UILabel!
    @IBOutlet weak var operatorLabel: UILabel!
    
    var numberOnScreen: Double = 0
    var previousNumber: Double = 0
    var calculation: Tag = .none
    
    @IBAction func numbers(_ sender: UIButton) {
        if calculation != .none {
            numberOnScreenLabel.text = String(sender.tag - 1)
            if let text = numberOnScreenLabel.text, let number = Double(text) {
                numberOnScreen = number
            }
            
        } else {
            if let text = numberOnScreenLabel.text {
                var isPreviousNumber = true
                if let number = Double(text), number == 0 {
                    isPreviousNumber = false
                }
                numberOnScreenLabel.text = (isPreviousNumber ? text : "") + String(sender.tag - 1)
            }
            
            if let number = numberOnScreenLabel.text, let value = Double(number) {
                numberOnScreen = value
            }
        }
    }
    
    @IBAction func operatiors(_ sender: UIButton) {
        calculation = Tag(rawValue: sender.tag) ?? .none
        operatorLabel.text = calculation.operation
        if let text = numberOnScreenLabel.text, let value = Double(text) {
            previousNumber = value
        }
    }
    
    @IBAction func equal(_ sender: UIButton) {
        var result: Double = 0
        switch calculation {
        case .divide:
            guard numberOnScreen != 0 else { return }
            result = previousNumber / numberOnScreen
        case .mutiple:
            result = previousNumber * numberOnScreen
        case .minus:
            result = previousNumber - numberOnScreen
        case .plus:
            result = previousNumber + numberOnScreen
        default:
            break
        }
        numberOnScreenLabel.text = String(result)
        previousNumber = result
    }
    
    @IBAction func clear(_ sender: UIButton) {
        numberOnScreenLabel.text = "0"
        calculation = .none
        previousNumber = 0
        numberOnScreen = 0
        operatorLabel.text = ""
    }
    
    @IBAction func opposite(_ sender: UIButton) {
        
    }
    
    @IBAction func percent(_ sender: UIButton) {
        
    }
}

