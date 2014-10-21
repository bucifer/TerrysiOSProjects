//
//  ViewController.swift
//  SwiftFirstPractcie
//
//  Created by Aditya Narayan on 10/21/14.
//  Copyright (c) 2014 TerryBuOrganization. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //constant and variable declaration
        let myConstant = 25;
        var myVariable = 11;
        
        //explicit type declaration
        let explicitDouble : Double = 70;
        
        //String concatenation
        let label = "My name is "
        let name = 24610
        let nameLabel = label + String(name)
        println(nameLabel)
        
        //variable injection
        var apples = 3
        var oranges = 5
        var appleSummary = "I have \(apples) apples."
        let fruitSummary = "I have \(apples + oranges) pieces of fruit."
        println(appleSummary)
        println(fruitSummary)
        
        //convenient array syntax
        var shoppingList = ["sword", "axe", "bow", "spear"]
        println(shoppingList[1])
        
        //syntactic sugar for dictionaries
        var occupations = [
        
            "Malcom" : "Pastor",
            "Ellen" : "Designer",
            "Terry" : "Trailblazer"

        ]
        
        occupations["Jane"] = "Writer"
        println(occupations)
        
        //creating empty arrays/dictionaries
        var emptyArray = [String]()
        var emptyDictionary = [String : Float]()
        
        emptyDictionary["age"] = 2.11
        println(emptyDictionary)
        
        var immutableArraySyntaxEmpty = []
        
        emptyArray.append("hi")
        println(emptyArray)
        
        
        
        //Control Flow if else
        //Parentheses around the condition or loop variable are optional. Braces around the body are required.
        let guysAges = [23, 24, 25, 26, 27]
        for age in guysAges {
            if age < 26 {
                println("younger than terry")
            }
            else {
                println("older than Terry")
            }
        }
        
        //Looping through key-value in dictionaries
        /* You use for-in to iterate over items in a dictionary by providing a pair of names to use for each key-value pair. Dictionaries are an unordered collection, so their keys and values are iterated over in an arbitrary order. */
        let interestingNumbers = [
            "Prime": [2, 3, 5, 7, 11, 13],
            "Fibonacci": [1, 1, 2, 3, 5, 8],
            "Square": [1, 4, 9, 16, 25],
        ]
        var largest = 0
        for (kind, numbers) in interestingNumbers {
            for number in numbers {
                if number > largest {
                    largest = number
                }
            }
        }
        println(largest)
        
        
        //More syntactic sugar for for-loops
        //Use ..< to make a range that omits its upper value, and use ... to make a range that includes both values.
        
        var randomResult = 0
        for i in 0..<5 {
            randomResult += 1;
        }
        println(randomResult)
        
        var randomResult2 = 0;
        for i in 0 ... 5 {
            randomResult2 += 1;
        }
        println(randomResult2)
        
        
        //Functions and closures
        /* Use func to declare a function. Call a function by following its name with a list of arguments in parentheses. Use -> to separate the parameter names and types from the function’s return type. */
        
        func greet (name: String, lunchSpecial: String) -> String {
            var returnString = "Hello, \(name), today's lunch special is \(lunchSpecial)!"
            println(returnString)
            return returnString
        }
        greet("Bob", "sushi")
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

