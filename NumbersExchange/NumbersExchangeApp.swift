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
            ContentView().environment(\.alerterKey, alerter)
                .alert(isPresented: $alerter.showErrorMessage) {
                    Alert(title: Text("Niepoprawne dane"), message: Text("Błędnie wprowadzone dane, sprawdź wybrany system konwersji"), dismissButton: .default(Text("OK")))
                }
        }
    }
}

struct AlerterKey: EnvironmentKey {
    static let defaultValue = Alerter()
}

extension EnvironmentValues {
    var alerterKey: Alerter {
        get { return self[AlerterKey.self] }
        set { self[AlerterKey.self] = newValue }
    }
}
