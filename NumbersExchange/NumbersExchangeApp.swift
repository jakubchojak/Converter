//
//  NumbersExchangeApp.swift
//  NumbersExchange
//
//  Created by Jakub Chojak on 19/10/2022.
//

import SwiftUI

@main
struct NumbersExchangeApp: App {
    @StateObject var alerter = Alerter()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
