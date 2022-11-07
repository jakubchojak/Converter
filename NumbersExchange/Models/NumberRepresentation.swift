//
//  NumberRepresentation.swift
//  NumbersExchange
//
//  Created by Jakub Chojak on 19/10/2022.
//

import Foundation

class NumberRepresentation {
    private var body: String?
    private var system: Int?
    private var floatingBody: String?
    
    func isFloating() -> Bool {
        for char in body! {
            if char == "." || char == "," {
                return true
            }
        }
        return false
    }
    
    func divideIntoIntegerAndFloating() {
        var newBody = ""
        var newFloatingPoint = ""
        var isInteger = true
        for char in body! {
            if isInteger && (char != "." && char != ",") {
                newBody.append(char)
            }
            else if isInteger {
                isInteger = false
            }
            else {
                newFloatingPoint.append(char)
            }
        }
        
        if newFloatingPoint != "" {
            body = newBody
            floatingBody = newFloatingPoint
        }
    }
    
    func convertToDecimal() {
        var output = 0
        var power = body!.count - 1
        
        for char in body ?? "" {
            if char.asciiValue! > UnicodeScalar("9").value {
                let tmp = UInt32(char.asciiValue!) - UnicodeScalar("A").value + 10
                output += Int(tmp) * Int(pow(Double(system!), Double(power)))
            }
            else {
                let tmp = Int(String(char))! - Int("0")!
                output +=  tmp * Int(pow(Double(system!), Double(power)))
            }
            power -= 1
        }
        
        system = 10
        body = String(output)
    }
    
    func convertFromDecimal(into: Int) {
        var output = ""
        var number = convertToInt(system: body ?? "")
        while number > 0 {
            if number % into < 10 {
                output.append(String(number % into))
            }
            else {
                let tmp = Character(UnicodeScalar(number % into + Int(UnicodeScalar("A").value) - 10)!)
                output.append(String(tmp))
            }
            number = number / into
        }
        body = String(output.reversed())
        system = into
    }
    
    func convertToAnySystem(anySystem: Int) -> String? {
        let isFloatingNumber = isFloating()
        divideIntoIntegerAndFloating()
        
        if system != 10 && anySystem != 10 {
            if isFloatingNumber {
                convertFloatingToDecimal()
            }
            convertToDecimal()
            if isFloatingNumber {
                convertFloatingFromDecimal(into: anySystem)
            }
            convertFromDecimal(into: anySystem)
        }
        else if system == 10 {
            if isFloatingNumber {
                convertFloatingFromDecimal(into: anySystem)
            }
            convertFromDecimal(into: anySystem)
        }
        
        if anySystem == 10 {
            if isFloatingNumber {
                convertFloatingToDecimal()
            }
            convertToDecimal()
        }
        
        mergeBodies()
        
        return self.getBody()
    }
    
    func mergeBodies() {
        if let fBody = floatingBody {
            if let b = body {
                body = b + "." + fBody
            }
        }
    }
    
    func convertFloatingToDecimal() {
        var output: Double = 0.0
        var power = -1
        
        for char in floatingBody ?? "" {
            if char.asciiValue! > UnicodeScalar("9").value {
                let tmp = UInt32(char.asciiValue!) - UnicodeScalar("A").value + 10
                output += Double(tmp) * Double(pow(Double(system!), Double(power)))
            }
            else {
                let tmp = Int(String(char))! - Int("0")!
                output +=  Double(tmp) * Double(pow(Double(system!), Double(power)))
            }
            power -= 1
        }
        
        floatingBody = doubleToString(number: output)
    }
    
    func convertFloatingFromDecimal(into: Int) {
        var output = ""
        var number = Double(floatingBody ?? "0")! / pow(10, Double(floatingBody!.count))
        var precision = (getApproxFromFile() ?? K.defaultApprox)
        
        while precision > 0 {
            let dNumber = number * Double(into)
            if Int(dNumber) % 100 >= 10 {
                let currCharacter = UnicodeScalar("A").value + UInt32(dNumber) % 100 - 10
                output += String(currCharacter)
                number = dNumber - Double(Int(dNumber) % 100)
            }
            else if Int(dNumber) % 10 >= 0 && Int(dNumber) % 10 < 10 {
                output += String(Int(dNumber) % 10)
                number = dNumber - Double(Int(dNumber) % 10)
            }
            precision -= 1
        }
        floatingBody = String(output)
    }
    
    func setBody(b: String) {
        body = b
    }
    
    func setSystem(s: Int) {
        system = s
    }
    
    func getBody() -> String?{
        return body
    }
    
    func getSystem() -> Int? {
        return system
    }
}
