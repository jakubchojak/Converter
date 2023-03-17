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
    @State var showCopyAlert = false
    @State var showImproperNumberAlert = false
    
    @FocusState private var focus: Field?
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.teal.ignoresSafeArea()
                VStack {
                    if showCopyAlert {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color(uiColor: K.textColor))
                                .frame(maxWidth: 200, maxHeight: 30)
                            Button {
                                withAnimation(.easeOut(duration: K.animationDuration)) {
                                    self.showCopyAlert = false
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundColor(.gray)
                                    Text("Copied!")
                                        .foregroundColor(.black)
                                        .bold()
                                }
                            }
                        }
                        .padding(.vertical, -35)
                    }
                    
                    if showImproperNumberAlert {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25)
                                .foregroundColor(Color(uiColor: K.textColor))
                                .frame(maxWidth: 200, maxHeight: 30)
                            Button {
                                withAnimation(.easeOut(duration: K.animationDuration)) {
                                    self.showImproperNumberAlert = false
                                }
                            } label: {
                                HStack {
                                    Image(systemName: "x.circle.fill")
                                        .foregroundColor(.gray)
                                    Text("Improper number!")
                                        .foregroundColor(.black)
                                        .bold()
                                }
                            }
                        }
                        .padding(.vertical, -35)
                    }
                    
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
                        withAnimation(.easeInOut(duration: K.animationDuration)) {
                            answerLabel = numberRepresentatorManager.convertToAnySystem(anySystem: selectedExpectedSystem) ?? ""
                        }
                        if K.showErrorMessage {
                            withAnimation(.easeIn(duration: K.animationDuration)) {
                                self.showImproperNumberAlert = true
                            }
                        }
                        else {
                            withAnimation(.easeOut(duration: K.animationDuration)) {
                                self.showImproperNumberAlert = false
                            }
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
                            withAnimation(.easeInOut(duration: K.animationDuration)) {
                                showCopyAlert = true
                            }
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
