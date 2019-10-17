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
func customMap(arr: [Double], closure: (Double) -> Double) -> [Double] {
    var mapResultArr = [Double]()
    for num in arr {
        mapResultArr.append(closure(num))
    }
    return mapResultArr
}

func customPlusReduce(arr: [Double], number: Double) -> Double {
    let reducedNum = arr.reduce(number, +)
    return reducedNum
}
func customMultReduce(arr: [Double], number: Double) -> Double {
    let reducedNum = arr.reduce(number, *)
    return reducedNum
}
var isCalculating = true

print("Welcome to Calculator, I can perform basic calculations for you or perform high-order calculations!!!")
print("""
For Basic Calculations.... enter like so:
    For addition... Please enter like so \"x + y\"!!!
    For subtraction...  \"x - y\"!!!
    For multiplication... \"x * y\"!!!
    For division... \"x / y\"!!!
    If you want me to perform a random math operation... Please enter like so \"x ? y\"!!!
    
""")
sleep(1)
print("""
For High-Order calculations.... enter like so:
    e.g \"map 1,2,3,4 by + 4\"
    e.g \"map 1,2,3,4 by * 4\"
    e.g \"filter 1,2,3,4 </<=/>/>= 4\"
    e.g \"reduce 1,2,3,4 by + 4\"
    e.g \"reduce 1,2,3,4 by + 4\"
""")
sleep(1)

repeat {
    print()
    print("Enter Equation")
    print()
    let legitOperator = ["+", "-", "*", "/"]
    let randomOperator = legitOperator.randomElement()

    let userEntryOpt = readLine() ?? ""
    let userEntry = userEntryOpt.lowercased()
    //let containsChar = legitOperator.joined()
    let userEntryArray = userEntry.components(separatedBy: " ")
    let elementsInUserEntry = userEntryArray.count
    
    switch elementsInUserEntry {
    case 3:
        let numOne = Double(userEntryArray[0])
        let numTwo = Double(userEntryArray[2])
        let symbol = String(userEntryArray[1])
        if symbol == "?" {
            if let validNumOne = numOne, let validNumTwo = numTwo {
                let operation = mathStuffFactory(opString: randomOperator!)
                let result = operation(validNumOne, validNumTwo)
                print()
                print("\(validNumOne) \(symbol) \(validNumTwo) = \(result)")
                print()
                sleep(1)
                print("Guess what operator was used in this equation!!!")
                let guessOperator = readLine() ?? ""
                if guessOperator == randomOperator {
                    print("👌👌👌👏👏👏")
                    print()
                    sleep(1)
                    print("Good Job")
                    sleep(1)
                    print("\(validNumOne) \(randomOperator!) \(validNumTwo) = \(result)")
                } else {
                    print("Oops, it was actually \(randomOperator!)")
                }
                isCalculating = false
            } else {
                print()
                print("For Random Operator... Please enter like so \"x ? y\"!!!")
            }
        } else if symbol == "+" || symbol == "-" || symbol == "*" || symbol == "/" {
            if let validNumOne = numOne, let validNumTwo = numTwo {
                let operation = mathStuffFactory(opString: symbol)
                let result = operation(validNumOne, validNumTwo)
                print()
                print("\(validNumOne) \(symbol) \(validNumTwo) = \(result)")
            }
        } else {
            print("Oops, something went wrong, please enter the equation correctly!!!")
            continue
        }
    case 4:
        let allElements = userEntry.components(separatedBy: " ")
        let inputArr = allElements[1].split(separator: ",")
        var numArrAsDouble = [Double]()
        let byInt = Double(allElements[3])
        if inputArr[0] == "filter" {
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
            print("Oops, something went wrong, please enter the equation correctly!!!")
            continue
        }
    case 5:
        let allElements = userEntry.components(separatedBy: " ")
        let inputArr = allElements[1].split(separator: ",")
        var numArrAsDouble = [Double]()
        let byDouble = Double(allElements[4])
        let mapOrReduce = allElements[0]
        switch mapOrReduce {
        case "map":
            for num in inputArr {
                let dubnum = Double(num)
                if let validDubNum = dubnum {
                    numArrAsDouble.append(validDubNum)
                }
            }
            if let validDouble = byDouble {
                if userEntry.contains("*") {
                    let mappedResult = customMap(arr: numArrAsDouble) { $0 * validDouble}
                    print("The mapped result is, \(mappedResult)")
                } else if userEntry.contains("+") {
                    let mappedResult = customMap(arr: numArrAsDouble) { $0 + validDouble}
                    print("The mapped result is, \(mappedResult)")
                }
                isCalculating = false
            } else {
                print("Oops, something went wrong, please enter the equation correctly!!!")
            }
        case "reduce":
            for num in inputArr {
                let dubnum = Double(num)
                if let validDubNum = dubnum {
                    numArrAsDouble.append(validDubNum)
                }
            }
            if let validDouble = byDouble {
                if userEntry.contains("*") {
                    let result = customMultReduce(arr: numArrAsDouble, number: validDouble)
                    print("The reduced result is.... \(result)")
                } else if userEntry.contains("+") {
                    let result = customPlusReduce(arr: numArrAsDouble, number: validDouble)
                    print("The reduced result is....  \(result)")
                } else {
                    print("Oops, something went wrong, please enter the equation correctly!!!")
                }
                isCalculating = false
            }
        default:
            print("Oops, something went wrong, please enter the equation correctly!!!")
        }
    default:
        print("Please enter a valid equation")
        continue
    }
    print()
    sleep(1)
    print("🆗✚👍＝🤯")
    sleep(1)
    print("Thanks for doing MATH with me!!!")
    print("Would you like to try another calculation?")
    let calcAgain = readLine() ?? ""
    if calcAgain.lowercased() == "yes" {
        isCalculating = true
        continue
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

//repeat {
//    print()
//    print("Enter Equation")
//    print()
//    let legitOperator = ["+", "-", "*", "/"]
//    let randomOperator = legitOperator.randomElement()
//
//    let userEntryOpt = readLine() ?? ""
//    let userEntry = userEntryOpt.lowercased()
//    //let containsChar = legitOperator.joined()
//    let userEntryArray = userEntry.components(separatedBy: " ")
//    let elementsInUserEntry = userEntryArray.count
//
//    switch elementsInUserEntry {
//    case 3:
//        let numOne = Double(userEntryArray[0])
//        let numTwo = Double(userEntryArray[2])
//        let symbol = String(userEntryArray[1])
//        if symbol == "?" {
//            if let validNumOne = numOne, let validNumTwo = numTwo {
//                let operation = mathStuffFactory(opString: randomOperator!)
//                let result = operation(validNumOne, validNumTwo)
//                print()
//                print("\(validNumOne) \(symbol) \(validNumTwo) = \(result)")
//                print()
//                sleep(1)
//                print("Guess what operator was used in this equation!!!")
//                let guessOperator = readLine() ?? ""
//                if guessOperator == randomOperator {
//                    print("👌👌👌👏👏👏")
//                    print()
//                    sleep(1)
//                    print("Good Job")
//                    sleep(1)
//                    print("\(validNumOne) \(randomOperator!) \(validNumTwo) = \(result)")
//                } else {
//                    print("Oops, it was actually \(randomOperator!)")
//                }
//                isCalculating = false
//            } else {
//                print()
//                print("For Random Operator... Please enter like so \"x ? y\"!!!")
//            }
//        } else if symbol == "+" || symbol == "-" || symbol == "*" || symbol == "/" {
//            if let validNumOne = numOne, let validNumTwo = numTwo {
//                let operation = mathStuffFactory(opString: symbol)
//                let result = operation(validNumOne, validNumTwo)
//                print()
//                print("\(validNumOne) \(symbol) \(validNumTwo) = \(result)")
//            }
//        } else {
//            print("For addition... Please enter like so \"x + y\"!!!")
//            print("For subtraction... Please enter like so \"x - y\"!!!")
//            print("For multiplication... Please enter like so \"x * y\"!!!")
//            print("For division... Please enter like so \"x / y\"!!!")
//            print("If you want me to perform a random math operation... Please enter like so \"x ? y\"!!!")
//            continue
//        }
//    case 4:
//        let allElements = userEntry.components(separatedBy: " ")
//        if userEntry.contains("filter") {
//            let inputArr = allElements[1].split(separator: ",")
//            var numArrAsDouble = [Double]()
//            let byInt = Double(allElements[3])
//    //        let userOperator = allElements[3]
//            for num in inputArr {
//                let dubnum = Double(num)
//                if let validDubNum = dubnum {
//                    numArrAsDouble.append(validDubNum)
//                }
//            }
//            if let validDub = byInt {
//                if userEntry.contains("<=") {
//                    print(numArrAsDouble.filter { $0 <= validDub })
//                } else if userEntry.contains("<") {
//                    print(numArrAsDouble.filter { $0 < validDub })
//                } else if userEntry.contains(">=") {
//                print(numArrAsDouble.filter { $0 >= validDub })
//                } else if userEntry.contains(">") {
//                print(numArrAsDouble.filter { $0 >= validDub })
//                } else {
//                    print("Error")
//                }
//                isCalculating = false
//            }
//        } else {
//            print("in order to use this function please enter like so.....")
//            sleep(1)
//            print("1. \"Filter x,y,z,etc. < n\"")
//            print("2. \"Filter x,y,z,etc. <= n\"")
//            print("3. \"Filter x,y,z,etc. > n\"")
//            print("4. \"Filter x,y,z,etc. >= n\"")
//            continue
//        }
//    case 5:
//        let allElements = userEntry.components(separatedBy: " ")
//        let inputArr = allElements[1].split(separator: ",")
//        var numArrAsDouble = [Double]()
//        let byDouble = Double(allElements[4])
//        if userEntryArray.contains("map") {
//
//            for num in inputArr {
//                let dubnum = Double(num)
//                if let validDubNum = dubnum {
//                    numArrAsDouble.append(validDubNum)
//                }
//            }
//            if let validDouble = byDouble {
//                if userEntry.contains("*") {
//                    let mappedResult = customMap(arr: numArrAsDouble) { $0 * validDouble}
//                    print("The mapped result is, \(mappedResult)")
//                } else if userEntry.contains("+") {
//                    let mappedResult = customMap(arr: numArrAsDouble) { $0 + validDouble}
//                    print("The mapped result is, \(mappedResult)")
//                }
//                isCalculating = false
//            } else {
//                print("error")
//            }
//        } else if userEntry.contains("reduce") {
//
//            for num in inputArr {
//                let dubnum = Double(num)
//                if let validDubNum = dubnum {
//                    numArrAsDouble.append(validDubNum)
//                }
//            }
//            if let validDouble = byDouble {
//                if userEntry.contains("*") {
//                    let result = customMultReduce(arr: numArrAsDouble, number: validDouble)
//                    print("The reduced result is.... \(result)")
//                } else if userEntry.contains("+") {
//                    let result = customPlusReduce(arr: numArrAsDouble, number: validDouble)
//                    print("The reduced result is....  \(result)")
//                } else {
//                    print("for reduce enter like so....")
//                }
//                isCalculating = false
//            }
//        } else {
//            print("please enter like so")
//            continue
//        }
//    default:
//        print("Please enter a valid equation")
//        continue
//    }
//    print()
//    sleep(1)
//    print("🆗✚👍＝🤯")
//    sleep(1)
//    print("Thanks for doing MATH with me!!!")
//    print("Would you like to try another calculation?")
//    let calcAgain = readLine() ?? ""
//    if calcAgain.lowercased() == "yes" {
//        isCalculating = true
//        continue
//    } else if calcAgain.lowercased() == "no" {
//        isCalculating = false
//        sleep(1)
//        print("🆗✚👍＝🤯")
//        sleep(1)
//        print("Thanks for doing MATH with me!!!")
//    } else {
//        print("Please enter \"yes\" or \"no\"!!!")
//    }
//} while isCalculating == true

//repeat {
//    print()
//    print("Enter Equation")
//    print()
//    let legitOperator = ["+", "-", "*", "/"]
//    let randomOperator = legitOperator.randomElement()
//
//    let userEntryOpt = readLine() ?? ""
//    let userEntry = userEntryOpt.lowercased()
//    //let containsChar = legitOperator.joined()
//    var containsChar = " "
//        if userEntry.contains("map") {
//            containsChar = "map"
//        } else if userEntry.contains("+") {
//            containsChar = "+"
//        } else if userEntry.contains("-") {
//            containsChar = "-"
//        } else if userEntry.contains("/") {
//            containsChar = "/"
//        } else if userEntry.contains("?") {
//            containsChar = "?"
//        } else if userEntry.contains("*") {
//            containsChar = "*"
//        } else if userEntry.contains("filter") {
//            containsChar = "filter"
//        }
//    switch containsChar {
//    case "+":
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
//    case "-":
//        let minusArr = userEntry.split(separator: "-")
//        let numOne = Double(minusArr[0])
//        let numTwo = Double(minusArr[1])
//        if let validNumOne = numOne, let validNumTwo = numTwo {
//            let operation = mathStuffFactory(opString: "-")
//            let result = operation(validNumOne, validNumTwo)
//            print()
//            print("Answer: \(validNumOne) + \(validNumTwo) = \(result)")
//            isCalculating = false
//        } else {
//            print("For addition... Please enter like so \"x+y\"!!!")
//        }
//    case "*":
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
//    case "/":
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
//    case "?":
//        let punctArr = userEntry.split(separator: "?")
//        let numOne = Double(punctArr[0])
//        let numTwo = Double(punctArr[1])
//        if let validNumOne = numOne, let validNumTwo = numTwo {
//            let operation = mathStuffFactory(opString: randomOperator!)
//            let result = operation(validNumOne, validNumTwo)
//            print()
//            print("\(validNumOne) ? \(validNumTwo) = \(result)")
//            print()
//            sleep(1)
//            print("Guess what operator was used in this equation!!!")
//            let guessOperator = readLine() ?? ""
//            if guessOperator == randomOperator {
//                print()
//                print("nice job")
//                sleep(1)
//                isCalculating = false
//            } else {
//                print("Oops, it was actually \(randomOperator!)")
//                isCalculating = false
//            }
//        } else {
//            print()
//            print("For Random Operator... Please enter like so \"x?y\"!!!")
//        }
//    case "map":
//        let allElements = userEntry.components(separatedBy: " ")
//        if allElements.count == 5 {
//            let inputArr = allElements[1].split(separator: ",")
//            var numArrAsDouble = [Double]()
//            let byDouble = Double(allElements[4])
//    //        let userOperator = allElements[3]
//            for num in inputArr {
//                let dubnum = Double(num)
//                if let validDubNum = dubnum {
//                    numArrAsDouble.append(validDubNum)
//                }
//            }
//            if let validDouble = byDouble {
//                if userEntry.contains("*") {
//                    let mappedResult = customMap(arr: numArrAsDouble) { $0 * validDouble}
//                    for num in mappedResult {
//                        print(num, terminator: " , ")
//                    }
//                } else if userEntry.contains("+") {
//                    let mappedResult = customMap(arr: numArrAsDouble) { $0 + validDouble}
//                    for num in mappedResult {
//                        print(num, terminator: " , ")
//                    }
//                }
//                isCalculating = false
//            } else {
//                print("error")
//            }
//        } else {
//            print("in order to use this function please enter like so......")
//            print("e.g 1. \"map 1,2,3,4,5 by * 5\"")
//            print("e.g 1. \"map 1,2,3,4,5 by + 5\"")
//            isCalculating = true
//        }
//    case "filter":
//        let allElements = userEntry.components(separatedBy: " ")
//        if allElements.count == 4 {
//            let inputArr = allElements[1].split(separator: ",")
//            var numArrAsDouble = [Double]()
//            let byInt = Double(allElements[3])
//    //        let userOperator = allElements[3]
//            for num in inputArr {
//                let dubnum = Double(num)
//                if let validDubNum = dubnum {
//                    numArrAsDouble.append(validDubNum)
//                }
//            }
//            if let validDub = byInt {
//                if userEntry.contains("<=") {
//                    print(numArrAsDouble.filter { $0 <= validDub })
//                } else if userEntry.contains("<") {
//                    print(numArrAsDouble.filter { $0 < validDub })
//                } else if userEntry.contains(">=") {
//                print(numArrAsDouble.filter { $0 >= validDub })
//                } else if userEntry.contains(">") {
//                print(numArrAsDouble.filter { $0 >= validDub })
//                } else {
//                    print("Error")
//                }
//                isCalculating = false
//            }
//
//        } else {
//            print("in order to use this function please enter like so.....")
//            sleep(1)
//            print("1. \"Filter x,y,z,etc. < n\"")
//            print("2. \"Filter x,y,z,etc. <= n\"")
//            print("3. \"Filter x,y,z,etc. > n\"")
//            print("4. \"Filter x,y,z,etc. >= n\"")
//        }
//
//    default:
//        print("Please enter a valid equation")
//    }
//    print()
//    print("Would you like to try another calculation?")
//    let calcAgain = readLine() ?? ""
//    if calcAgain.lowercased() == "yes" {
//        isCalculating = true
//    } else if calcAgain.lowercased() == "no" {
//        isCalculating = false
//        sleep(1)
//        print("🆗✚👍＝🤯")
//        sleep(1)
//        print("Thanks for doing MATH with me!!!")
//    } else {
//        print("Please enter \"yes\" or \"no\"!!!")
//    }
//} while isCalculating == true

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


