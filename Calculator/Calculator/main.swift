//
//  main.swift
//  Calculator
//
//  Created by Alex Paul on 10/25/18.
//  Copyright © 2018 Pursuit. All rights reserved.
//

import Foundation

func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
    
      switch opString {
      case "+":
        return {x, y in x + y }
      case "-":
        return {x, y in x - y }
      case "*":
        return {x, y in x * y }
      case "/":
        return {x, y in x / y }
      default:
        return {x, y in x + y }
  }
}

//func myFilter(inputArr: [Double], filter: (Double) -> Bool) -> [Double] {
//    var filterResultArr = [Double]()
//    for num in inputArr {
//        filterResultArr.append(filter(num))
//    }
//    return filterResultArr
//}

func customMap(arr: [Double], closure: (Double) -> Double) -> [Double] {
    var mapResultArr = [Double]()
    for num in arr {
        mapResultArr.append(closure(num))
    }
    return mapResultArr
}

var isCalculating = true
repeat {
    print()
    print("Enter Equation")
    print()
    let legitOperator = ["+", "-", "*", "/"]
    let randomOperator = legitOperator.randomElement()

    let userEntryOpt = readLine() ?? ""
    let userEntry = userEntryOpt.lowercased()
    //let containsChar = legitOperator.joined()
    var containsChar = " "
        if userEntry.contains("map") {
            containsChar = "map"
        } else if userEntry.contains("+") {
            containsChar = "+"
        } else if userEntry.contains("-") {
            containsChar = "-"
        } else if userEntry.contains("/") {
            containsChar = "/"
        } else if userEntry.contains("?") {
            containsChar = "?"
        } else if userEntry.contains("*") {
            containsChar = "*"
        } else if userEntry.contains("filter") {
            containsChar = "filter"
        }
    switch containsChar {
    case "+":
        let plusArr = userEntry.split(separator: "+")
        let numOne = Double(plusArr[0])
        let numTwo = Double(plusArr[1])
        if let validNumOne = numOne, let validNumTwo = numTwo {
            let operation = mathStuffFactory(opString: "+")
            let result = operation(validNumOne, validNumTwo)
            print()
            print("Answer: \(validNumOne) + \(validNumTwo) = \(result)")
            isCalculating = false
        } else {
            print("For addition... Please enter like so \"x+y\"!!!")
        }
    case "-":
        let minusArr = userEntry.split(separator: "-")
        let numOne = Double(minusArr[0])
        let numTwo = Double(minusArr[1])
        if let validNumOne = numOne, let validNumTwo = numTwo {
            let operation = mathStuffFactory(opString: "-")
            let result = operation(validNumOne, validNumTwo)
            print()
            print("Answer: \(validNumOne) + \(validNumTwo) = \(result)")
            isCalculating = false
        } else {
            print("For addition... Please enter like so \"x+y\"!!!")
        }
    case "*":
        let productArr = userEntry.split(separator: "*")
        let numOne = Double(productArr[0])
        let numTwo = Double(productArr[1])
        if let validNumOne = numOne, let validNumTwo = numTwo {
            let operation = mathStuffFactory(opString: "*")
            let result = operation(validNumOne, validNumTwo)
            print()
            print("Answer: \(validNumOne) * \(validNumTwo) = \(result)")
            isCalculating = false
        } else {
            print()
            print("For Multiplication... Please enter like so \"x*y\"!!!")
        }
    case "/":
        let divideArr = userEntry.split(separator: "/")
        let numOne = Double(divideArr[0])
        let numTwo = Double(divideArr[1])
        if let validNumOne = numOne, let validNumTwo = numTwo {
            let operation = mathStuffFactory(opString: "/")
            let result = operation(validNumOne, validNumTwo)
            print()
            print("Answer: \(validNumOne) / \(validNumTwo) = \(result)")
            isCalculating = false
        } else {
            print()
            print("For Division... Please enter like so \"x/y\"!!!")
        }
    case "?":
        let punctArr = userEntry.split(separator: "?")
        let numOne = Double(punctArr[0])
        let numTwo = Double(punctArr[1])
        if let validNumOne = numOne, let validNumTwo = numTwo {
            let operation = mathStuffFactory(opString: randomOperator!)
            let result = operation(validNumOne, validNumTwo)
            print()
            print("\(validNumOne) ? \(validNumTwo) = \(result)")
            print()
            sleep(1)
            print("Guess what operator was used in this equation!!!")
            let guessOperator = readLine() ?? ""
            if guessOperator == randomOperator {
                print()
                print("nice job")
                sleep(1)
                isCalculating = false
            } else {
                print("Oops, it was actually \(randomOperator!)")
                isCalculating = false
            }
        } else {
            print()
            print("For Random Operator... Please enter like so \"x?y\"!!!")
        }
    case "map":
        let allElements = userEntry.components(separatedBy: " ")
        if allElements.count == 5 {
            let inputArr = allElements[1].split(separator: ",")
            var numArrAsDouble = [Double]()
            let byDouble = Double(allElements[4])
    //        let userOperator = allElements[3]
            for num in inputArr {
                let dubnum = Double(num)
                if let validDubNum = dubnum {
                    numArrAsDouble.append(validDubNum)
                }
            }
            if let validDouble = byDouble {
                if userEntry.contains("*") {
                    let mappedResult = customMap(arr: numArrAsDouble) { $0 * validDouble}
                    for num in mappedResult {
                        print(num, terminator: " , ")
                    }
                } else if userEntry.contains("+") {
                    let mappedResult = customMap(arr: numArrAsDouble) { $0 + validDouble}
                    for num in mappedResult {
                        print(num, terminator: " , ")
                    }
                }
                isCalculating = false
            } else {
                print("error")
            }
        } else {
            print("in order to use this function please enter like so......")
            print("e.g 1. \"map 1,2,3,4,5 by * 5\"")
            print("e.g 1. \"map 1,2,3,4,5 by + 5\"")
            isCalculating = true
        }
    case "filter":
        let allElements = userEntry.components(separatedBy: " ")
        if allElements.count == 4 {
            let inputArr = allElements[1].split(separator: ",")
            var numArrAsDouble = [Double]()
            let byInt = Double(allElements[3])
    //        let userOperator = allElements[3]
            for num in inputArr {
                let dubnum = Double(num)
                if let validDubNum = dubnum {
                    numArrAsDouble.append(validDubNum)
                }
            }
            if let validDub = byInt {
                if userEntry.contains("<=") {
                    print(numArrAsDouble.filter { $0 <= validDub })
                } else if userEntry.contains("<") {
                    print(numArrAsDouble.filter { $0 < validDub })
                } else if userEntry.contains(">=") {
                print(numArrAsDouble.filter { $0 >= validDub })
                } else if userEntry.contains(">") {
                print(numArrAsDouble.filter { $0 >= validDub })
                } else {
                    print("Error")
                }
                isCalculating = false
            }
            
        } else {
            print("in order to use this function please enter like so.....")
            print("1. \"Filter x,y,z,etc. < n\"")
            print("2. \"Filter x,y,z,etc. <= n\"")
            print("3. \"Filter x,y,z,etc. > n\"")
            print("4. \"Filter x,y,z,etc. >= n\"")
        }
    
    default:
        print("Please enter a valid equation")
    }
    print()
    print("Would you like to try another calculation?")
    let calcAgain = readLine() ?? ""
    if calcAgain.lowercased() == "yes" {
        isCalculating = true
    } else if calcAgain.lowercased() == "no" {
        isCalculating = false
        sleep(1)
        print("🆗✚👍＝🤯")
        sleep(1)
        print("Thanks for doing MATH with me!!!")
    } else {
        print("Please enter \"yes\" or \"no\"!!!")
    }
} while isCalculating == true



//func calculateOperation(str: String) -> Double {
//   let userEntryArray = str.components(separatedBy: " ") // 2 + 2 => ["2", "+", "2"]
//   if userEntryArray.count != 3 { // 0, 1, 2
//       return 0.0
//   }
//   let operand1 = Double(userEntryArray[0]) ?? 0.0
//   let operand2 = Double(userEntryArray[2]) ?? 0.0
//   let operatorSymbol = userEntryArray[1] //+, -, *, /
//   let operationClosure = mathStuffFactory(opString: operatorSymbol)
//   let result = operationClosure(operand1, operand2)
//   return result
//}
//print("calculate")
//let entryUser = readLine() ?? ""
//let resultCalculation = calculateOperation(str: entryUser)
//print(resultCalculation)

//repeat {
//    print()
//    print("Enter Equation")
//    print()
//    let legitOperator = ["+", "-", "*", "/"]
//    let randomOperator = legitOperator.randomElement()
//
//    let userEntry = readLine() ?? ""
//
//    if userEntry.contains("+") {
//        let plusArr = userEntry.split(separator: "+")
//        let numOne = Double(plusArr[0])
//        let numTwo = Double(plusArr[1])
//        if let validNumOne = numOne, let validNumTwo = numTwo {
//            let operation = mathStuffFactory(opString: "+")
//            let result = operation(validNumOne, validNumTwo)
//            print()
//            print("Answer: \(validNumOne) + \(validNumTwo) = \(result)")
//            isCalculating = false
//        } else {
//            print("For addition... Please enter like so \"x+y\"!!!")
//        }
//    } else if userEntry.contains("-") {
//        let minusArr = userEntry.split(separator: "-")
//        let numOne = Double(minusArr[0])
//        let numTwo = Double(minusArr[1])
//        if let validNumOne = numOne, let validNumTwo = numTwo {
//            let operation = mathStuffFactory(opString: "-")
//            let result = operation(validNumOne, validNumTwo)
//            print()
//            print("Answer: \(validNumOne) - \(validNumTwo) = \(result)")
//            isCalculating = false
//        } else {
//            print("For Subtraction.... Please enter like so \"x-y\"!!!")
//        }
//
//    } else if userEntry.contains("*") {
//        let productArr = userEntry.split(separator: "*")
//        let numOne = Double(productArr[0])
//        let numTwo = Double(productArr[1])
//        if let validNumOne = numOne, let validNumTwo = numTwo {
//            let operation = mathStuffFactory(opString: "*")
//            let result = operation(validNumOne, validNumTwo)
//            print()
//            print("Answer: \(validNumOne) * \(validNumTwo) = \(result)")
//            isCalculating = false
//        } else {
//            print()
//            print("For Multiplication... Please enter like so \"x*y\"!!!")
//        }
//
//    } else if userEntry.contains("/") {
//        let divideArr = userEntry.split(separator: "/")
//        let numOne = Double(divideArr[0])
//        let numTwo = Double(divideArr[1])
//        if let validNumOne = numOne, let validNumTwo = numTwo {
//            let operation = mathStuffFactory(opString: "/")
//            let result = operation(validNumOne, validNumTwo)
//            print()
//            print("Answer: \(validNumOne) / \(validNumTwo) = \(result)")
//            isCalculating = false
//        } else {
//            print()
//            print("For Division... Please enter like so \"x/y\"!!!")
//        }
//
//    } else if userEntry.contains("?") {
//        let punctArr = userEntry.split(separator: "?")
//        let numOne = Double(punctArr[0])
//        let numTwo = Double(punctArr[1])
//        if let validNumOne = numOne, let validNumTwo = numTwo {
//            let operation = mathStuffFactory(opString: randomOperator!)
//            let result = operation(validNumOne, validNumTwo)
//            print()
//            print("Answer: \(validNumOne) ? \(validNumTwo) = \(result)")
//            print()
//            print("Guess what operator was used in this equation!!!")
//            let guessOperator = readLine() ?? ""
//            if guessOperator == randomOperator {
//                print()
//                print("nice job")
//                isCalculating = false
//            } else {
//                print("Oops, it was actually \(randomOperator!)")
//                isCalculating = false
//            }
//        } else {
//            print()
//            print("For Random Operator... Please enter like so \"x?y\"!!!")
//        }
//    } else {
//        print("Please Enter a Valid Equation")
//    }
//
//    print()
//    print("would you like to try another calculation")
//    let calcAgain = readLine() ?? ""
//    if calcAgain.lowercased() == "yes" {
//        isCalculating = true
//    } else if calcAgain.lowercased() == "no" {
//        isCalculating = false
//        print("thanks for calculating have a nice day")
//    } else {
//        print("Please enter \"yes\" or \"no\"!!!")
//    }
//
//} while isCalculating == true
