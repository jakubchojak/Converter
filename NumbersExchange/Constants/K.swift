//
//  K.swift
//  NumbersExchange
//
//  Created by Jakub Chojak on 26/10/2022.
//

import Foundation
import UIKit

struct K {
    static let defaultApprox = 6;
    static var showErrorMessage = false
    static let textColor = UIColor(red: 0.9098, green: 0.9098, blue: 0.9412, alpha: 1.0)
    static var animationDuration = 0.33
}

class Alerter: ObservableObject {
    @Published var showErrorMessage = false
}

enum ConversionErrors: Error {
    case ImproperlySystemSet
}
