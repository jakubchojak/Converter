//
//  ContentView.swift
//  NumbersExchange
//
//  Created by Jakub Chojak on 19/10/2022.
//

import SwiftUI

struct ContentView: View {
    var toPick = [2, 8, 10, 16]
    @State var selectedExpectedSystem = 2
    @State var selectedUserSystem = 10
    private enum Field: Int, CaseIterable {
            case numberToConvert, numberSystem, expectedSystem
    }
    @State var userInput = ""
    @State var userSystem = ""
    @State var expectedSystem = ""
    @State var answerLabel = ""
    @State var action: Int?
    
    @FocusState private var focus: Field?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.teal.ignoresSafeArea()
                VStack {
                    Text("Converter")
                        .bold()
                        .font(.system(size: 32))
                        .padding(.bottom, 50)
                        .padding(.top, -50)
                        .foregroundColor(.white)
                    
                    
                    TextField("Wprowadź liczbę do konwersji", text: $userInput)
                        .focused($focus, equals: .numberToConvert)
                        .foregroundColor(.white)
                        .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                
//                    TextField("Wprowadź podstawę systemu", text: $userSystem)
//                        .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
//                        .foregroundColor(.white)
//                        .focused($focus, equals: .numberSystem)
//                        .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
//
//                    TextField("Wprowadź system do którego liczba ma zostać skonwertowana", text: $expectedSystem)
//                        .keyboardType(/*@START_MENU_TOKEN@*/.numberPad/*@END_MENU_TOKEN@*/)
//                        .foregroundColor(.white)
//                        .focused($focus, equals: .expectedSystem)
//                        .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    HStack {
                        Text("System podstawowy")
                            .foregroundColor(.white)
                        
                        Picker("", selection: $selectedUserSystem, content: {
                            ForEach(toPick, id: \.self) {
                                Text("\($0)")
                            }
                        })
                        .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    }
                    
                    HStack {
                        Text("System docelowy")
                            .foregroundColor(.white)
                        
                        Picker("", selection: $selectedExpectedSystem, content: {
                            ForEach(toPick, id: \.self) {
                                Text("\($0)")
                            }
                        })
                        .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                    }
                    
                    .toolbar {
                        ToolbarItem(placement: .keyboard) {
                            Button {
                                focus = nil
                            } label: {
                                Text("Ukryj")
                            }
                        }
                    }
                    
                    Button {
                        numberRepresentatorManager.setBody(b: userInput.uppercased())
                        numberRepresentatorManager.setSystem(s: selectedUserSystem)
                        answerLabel = numberRepresentatorManager.convertToAnySystem(anySystem: selectedExpectedSystem) ?? ""
                    } label: {
                        Text("Wykonaj")
                            .bold()
                            .foregroundColor(Color(uiColor: UIColor(red: 0.9098, green: 0.9098, blue: 0.9412, alpha: 1.0)))
                            .font(.system(size: 24))
                    }
                    .padding(.top, 20)
                    
                    if answerLabel != "" {
                        Text("Wynik: \(answerLabel)")
                            .padding(.top, 50)
                            .foregroundColor(.white)
                            .bold()
                            .font(.system(size: 20))
                    }
                }
            }
            .padding(25)
            .background(Color.teal)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView()
                    } label: {
                        Image(systemName: "gear")
                            .foregroundColor(.white)
                    }


                }
            }
        }
    }
}

