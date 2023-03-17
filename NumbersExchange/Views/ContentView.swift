//
//  ContentView.swift
//  NumbersExchange
//
//  Created by Jakub Chojak on 19/10/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.alerterKey) var theAlerter
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
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(maxHeight: 40)
                            .foregroundColor(Color(uiColor: K.textColor))
                        
                        TextField("Wprowadź liczbę do konwersji", text: $userInput)
                            .focused($focus, equals: .numberToConvert)
                            .foregroundColor(.teal)
                            .accentColor(.teal)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                    ZStack {
                        
                        RoundedRectangle(cornerRadius: 25)
                            .frame(maxHeight: 80)
                            .foregroundColor(Color(uiColor: K.textColor))
                        
                        HStack(spacing: 50) {
                            Picker("", selection: $selectedUserSystem, content: {
                                ForEach(toPick, id: \.self) {
                                    Text("\($0)")
                                }
                            })
                            .accentColor(.teal)
                            
                            Image(systemName: "arrow.right")
                                .foregroundColor(.gray)
                                .bold()
                            
                            Picker("", selection: $selectedExpectedSystem, content: {
                                ForEach(toPick, id: \.self) {
                                    Text("\($0)")
                                }
                            })
                            .accentColor(.teal)
                            
                        }
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
                    
                    Spacer()
                    
                    Button {
                        numberRepresentatorManager.setBody(b: userInput.uppercased())
                        numberRepresentatorManager.setSystem(s: selectedUserSystem)
                        answerLabel = numberRepresentatorManager.convertToAnySystem(anySystem: selectedExpectedSystem) ?? ""
                        if K.showErrorMessage {
                            theAlerter.showErrorMessage = true
                        }
                        else {
                            theAlerter.showErrorMessage = false
                        }
                        
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color(uiColor: K.textColor))
                                .frame(maxHeight: 80.0)
                            Text("Oblicz")
                                .bold()
                                .foregroundColor(Color.blue)
                                .font(.system(size: 24))
                        }
                        
                        
                    }
                    .padding(.top, 20)
                    
                    
                    if answerLabel != "" {
                        
                        Button {
                            UIPasteboard.general.string = answerLabel
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 25)
                                    .foregroundColor(Color(uiColor: K.textColor))
                                    .frame(maxHeight: 40.0)
                                
                                HStack {
                                    Image(systemName: "clipboard.fill")
                                        .foregroundColor(.gray)
                                    Text("\(answerLabel)")
                                        .foregroundColor(.cyan)
                                        .bold()
                                        .font(.system(size: 20))
                                }
                            }
                        }
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
        .accentColor(Color(uiColor: K.textColor))
    }
}
