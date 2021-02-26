import Foundation

protocol MathManagerProtocol {
    func updateUI(score: Int, answerOptions: [Int], question: String)
}

class MathManager {
    let operationSymbols = ["+", "-", "*", "/"]
    var score = 0
    
    //delegate
    var delegate: MathManagerProtocol?
    
    //math variables
    var firstNumber = 0
    var secondNumber = 0
    var answer = 0
    var operation = "+"
    
    
    func answered(_ text: String, max: Int, operations: Set<Int>){
        let selectedAnswer = Int(text)
        if selectedAnswer == answer {
            score += 1
        } else {
            score = score > 2 ? score - 2: 0
        }
        let answerOptions = randomiseAnswers(max: max, operations: operations)
        let questionString = "\(firstNumber) \(operation) \(secondNumber)"
        
        delegate?.updateUI(score: score, answerOptions: answerOptions, question: questionString)
       
    }
    

    
    //randomise numbers and returns list of answer options
    func randomiseAnswers(max: Int, operations: Set<Int>) -> [Int] {
    
        let randomChoice = Int.random(in: 0...(operations.count - 1))
        let operationArray = Array(operations)
        let operationIndex = operationArray[randomChoice]
        
        if operationIndex == 0 { //addition
            firstNumber = Int.random(in: 1...max/2)
            secondNumber = Int.random(in: 1...max/2)
            answer = firstNumber + secondNumber
            operation = "+"
        } else if operationIndex == 1 { //subsraction
            firstNumber = Int.random(in: 1...max)
            secondNumber = Int.random(in: 1...max)
            answer = firstNumber - secondNumber
            operation = "-"
        } else if operationIndex == 2 { //multiplication
            let newMax = Int(sqrt(Double(max)))
            firstNumber = Int.random(in: 1...newMax)
            secondNumber = Int.random(in: 1...newMax)
            answer = firstNumber * secondNumber
            operation = "*"
        } else { // division
            let newMax = Int(sqrt(Double(max)))
            firstNumber = Int.random(in: 1...newMax)
            secondNumber = Int.random(in: 1...newMax)
            answer = firstNumber * secondNumber
            let temp = answer
            answer = firstNumber
            firstNumber = temp
            operation = "/"
        }
        
        
        
        
        
        
        var answerOptions: [Int] = [answer]
        while answerOptions.count < 4 {
            let tempNumber = Int.random(in: answer-20...answer+20)
            if (!answerOptions.contains(tempNumber)) {
                answerOptions.append(tempNumber)
            }
        }
        answerOptions.shuffle()
        return answerOptions
    }
    
}
