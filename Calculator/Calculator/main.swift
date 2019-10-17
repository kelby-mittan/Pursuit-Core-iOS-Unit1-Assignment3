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
print()
sleep(2)
print("""
For Basic Calculations.... enter like so:
    e.g \"x + y\"!!!
    For subtraction...  \"x - y\"!!!
    For multiplication... \"x * y\"!!!
    For division... \"x / y\"!!!
    If you want me to perform a random math operation... Please enter like so \"x ? y\"!!!
    
""")
sleep(1)
sleep(1)
print("""
For High-Order Calculations.... enter like so:
    e.g \"map 1,2,3,4 by + 4\"
    e.g \"map 1,2,3,4 by * 4\"
    e.g \"filter 1,2,3,4 </<=/>/>= 4\"
    e.g \"reduce 1,2,3,4 by + 4\"
    e.g \"reduce 1,2,3,4 by * 4\"
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
        if allElements[0] == "filter" {
            for num in inputArr {
                let dubnum = Double(num)
                if let validDubNum = dubnum {
                    numArrAsDouble.append(validDubNum)
                }
            }
            if let validDub = byInt {
                var filteredArray = [Double]()
                if userEntry.contains("<=") {
                    filteredArray = numArrAsDouble.filter { $0 <= validDub }
                } else if userEntry.contains("<") {
                    filteredArray = numArrAsDouble.filter { $0 < validDub }
                } else if userEntry.contains(">=") {
                    filteredArray = numArrAsDouble.filter { $0 >= validDub }
                } else if userEntry.contains(">") {
                    filteredArray = numArrAsDouble.filter { $0 >= validDub }
                } else {
                    print("Oops, something went wrong... please enter the equation correctly!!!")
                }
                print("Your filtered result is \(filteredArray)")
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
                print("Oops, something went wrong... please enter the equation correctly!!!")
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
                    print("Oops, something went wrong... please enter the equation correctly!!!")
                }
                isCalculating = false
            }
        default:
            print("Oops, something went wrong... please enter the equation correctly!!!")
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



