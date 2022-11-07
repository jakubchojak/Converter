//
//  ContentController.swift
//  NumbersExchange
//
//  Created by Jakub Chojak on 19/10/2022.
//

import Foundation

var numberRepresentatorManager = NumberRepresentation()

func convertToInt(system: String) -> Int {
    var output = 0
    var i = system.count - 1
    for char in system {
        let tmp = Int(String(char))! - Int("0")!
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
        return convertToInt(system: c)
    }
    return nil
}

func writeApproxToFile(userApprox: Int) {
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("approx.txt")
    try! String(userApprox).write(to: filePath, atomically: true, encoding: .utf8)
}
