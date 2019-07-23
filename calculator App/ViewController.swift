//
//  ViewController.swift
//  calculator App
//
//  Created by MOHIT PAREEK on 03/07/19.
//  Copyright © 2019 MOHIT PAREEK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    //outlet of the label
    @IBOutlet weak var labelOutlet: UILabel!
    
    
    //asigning variables to keep count of number of times they are pressed
    var countOfPoint = 0
    var countOfPlusOperator = 0
    var countOfMinusOperator = 0
    var countOfMultiplyOperator = 0
    var countOfDivisionOperator = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //action for all the digits and the operator buttons

    @IBAction func buttons(_ sender: UIButton) {
        
        // required when the label is empty
        if labelOutlet.text == "" {
            switch sender.tag {
            case 1:
                break
            case 12:
                return
            case 13:
                return
            case 14:
                return
            case 15:
                return
            default:
                break
            }

        }
        //to handle number of zeroes
        if sender.tag == 1 {
            if labelOutlet.text == "0"{
            return
            }
            if (labelOutlet.text?.hasSuffix("/0"))!{
                return
            }
            if (labelOutlet.text?.hasSuffix("*0"))!{
                return
            }
            if (labelOutlet.text?.hasSuffix("-0"))!{
                return
            }
            if (labelOutlet.text?.hasSuffix("+0"))!{
                return
            }
        }
        //to handle the no. of points
        if sender.tag == 16 {
            countOfPoint = countOfPoint+1
            print(countOfPoint)
            if countOfPoint >= 2 {
                return
            }
        }
        //to handle no.of plus operator
        if sender.tag == 13 {
            countOfPlusOperator = countOfPlusOperator+1
            print("count of operator+=\(countOfPlusOperator)")
            if countOfPlusOperator >= 2 {
                return
            }
        }
        
        //to handle no. of division operator
        if sender.tag == 12 {
            countOfDivisionOperator = countOfDivisionOperator+1
            print("count of operator/=\(countOfDivisionOperator)")
            if countOfDivisionOperator >= 2 {
                return
            }
        }
        //to handle no. of minus operators
        if sender.tag == 14 {
            countOfMinusOperator = countOfMinusOperator+1
            print("count of operator-=\(countOfMinusOperator)")
            if countOfMinusOperator >= 2 {
                return
            }
        }
        //to handle no. of multiply operators
        if sender.tag == 15 {
            countOfMultiplyOperator = countOfMultiplyOperator+1
            print("count of operatorx=\(countOfMultiplyOperator)")
            if countOfMultiplyOperator >= 2 {
                return
            }
        }
    
        labelOutlet.text = labelOutlet.text! + sender.currentTitle!
        
    }
    
    

    //action for equals to button
    @IBAction func tappedEqualsTo(_ sender: UIButton) {
        
        if labelOutlet.text == "" {
            return
        }
        
        let result = test(labelOutlet.text!)
        labelOutlet.text = result
        countOfPlusOperator = 0
        countOfMultiplyOperator = 0
        countOfMinusOperator = 0
        countOfDivisionOperator = 0
        
        
    }
    
    //action for clear button
    
    @IBAction func clearbuttonPressed(_ sender: Any) {

        labelOutlet.text = ""
        countOfPoint = 0
        countOfPlusOperator = 0
        countOfMultiplyOperator = 0
        countOfMinusOperator = 0
        countOfDivisionOperator = 0

    }
    
    //action for delete button
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        
        if labelOutlet.text == "" {

            return
        }
        
        sender.isEnabled = true
        let name: String = labelOutlet.text!
        let lastElement = name.last
        
        let stringLength = labelOutlet.text?.count
        let substringIndex = stringLength! - 1
        labelOutlet.text = (name as NSString).substring(to: substringIndex)
        
        if lastElement == "." {
            countOfPoint = 0
        }
        
        if lastElement == "+" {
            countOfPlusOperator = 0
        }
        
        if lastElement == "-" {
            countOfMinusOperator = 0
        }
        
        if lastElement == "x" {
            countOfMultiplyOperator = 0
        }
        
        if lastElement == "/" {
            countOfDivisionOperator = 0
        }
        
        

    }
    
    
    //function to pass string and get the value calculated and the again return value is in string format
    
    func test(_ expressrion: String) -> String{
        var numinString : String!
        if let num = expressrion.calculate() {
             numinString = String(num)
            print("\(expressrion) = \(num)")
        } else {
            print("\(expressrion) = nil")

        }
        return numinString
    }

    
    
}

// extension of string created for calculation of the string entered

extension String {
    private func allNumsToDouble() -> String {
        
        let symbolsCharSet = ".,"
        let fullCharSet = "0123456789" + symbolsCharSet
        var i = 0
        var result = ""
        var chars = Array(self)
        while i < chars.count {
            if fullCharSet.contains(chars[i]) {
                var numString = String(chars[i])
                i += 1
                loop: while i < chars.count {
                    if fullCharSet.contains(chars[i]) {
                        numString += String(chars[i])
                        i += 1
                    } else {
                        break loop
                    }
                }
                if let num = Double(numString) {
                    result += "\(num)"
                } else {
                    result += numString
                }
            } else {
                result += String(chars[i])
                i += 1
            }
        }
        return result
    }
    //calculation of string and value returned as double from this function
    
    func calculate() -> Double? {
        let transformedString = allNumsToDouble()
        let expr = NSExpression(format: transformedString)
        return expr.expressionValue(with: nil, context: nil) as? Double
    }
}

