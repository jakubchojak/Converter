//
//  ContentController.swift
//  NumbersExchange
//
//  Created by Jakub Chojak on 19/10/2022.
//

import Foundation

var numberRepresentatorManager = NumberRepresentation()

func convertToInt(system: String) throws -> Int {
    var output = 0
    var i = system.count - 1
    for char in system {
        let tmp = Int(String(char)) ?? -1 - Int("0")!
        guard tmp > Int("0")! else {
            K.showErrorMessage = true
            throw ConversionErrors.ImproperlySystemSet
        }
        K.showErrorMessage = false
        output +=  tmp * Int(pow(10.0, Double(i)))
        i -= 1
    }
    return output
}

func doubleToString(number: Double) -> String {
    return String(String(format: "%f", number).suffix(String(format: "%f", number).count - 2))
}

func getApproxFromFile() -> Int? {
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("approx.txt")
    let cont = try? String(contentsOf: filePath, encoding: .utf8)
    if let c = cont {
        do {
            let tmp = try convertToInt(system: c)
            return tmp
        }
        catch ConversionErrors.ImproperlySystemSet {
            print("My bad")
            return nil
        }
        catch {
            print("Unexpected Error")
        }
    }
    return nil
}

func writeApproxToFile(userApprox: Int) {
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("approx.txt")
    try! String(userApprox).write(to: filePath, atomically: true, encoding: .utf8)
}
