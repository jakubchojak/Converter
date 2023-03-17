//
//  SettingsView.swift
//  NumbersExchange
//
//  Created by Jakub Chojak on 20/10/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @State var realApproximationSliderValue = getApproxFromFile() ?? K.defaultApprox
    var picks = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    var body: some View {
        ZStack {
            Color.teal.ignoresSafeArea()
            VStack {
                Text("Ustawienia")
                    .font(.system(size: 32))
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .foregroundColor(Color(uiColor: K.textColor))
                        .frame(maxHeight: 40.0)
                    
                    HStack(spacing: 30) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .foregroundColor(.gray)
                            .bold()
                        
                        Text("Precyzja")
                            .foregroundColor(.cyan)
                            .bold()
                        
                        
                        Picker("", selection: $realApproximationSliderValue) {
                            ForEach(picks, id: \.self) {
                                Text("\($0)")
                            }
                        }
                        .foregroundColor(.cyan)
                        .accentColor(.cyan)
                        .onChange(of: realApproximationSliderValue) { value in
                            print(value)
                            writeApproxToFile(userApprox: value)
                        }
                        
                    }
                }
                .padding()
                
                Spacer()
                
                Link(destination: URL(string: "https://metrystadiamentowy.wixsite.com/my-site-2/privacy-policy")!) {
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(maxHeight: 80)
                            .foregroundColor(Color(uiColor: K.textColor))
                        
                        Text("Polityka prywatności")
                            .foregroundColor(.blue)
                            .bold()
                    }
                    
                    
                }
                .padding(.trailing)
                .padding(.leading)
                
                Link(destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(maxHeight: 80)
                            .foregroundColor(Color(uiColor: K.textColor))
                        
                        Text("EULA")
                            .foregroundColor(.blue)
                            .bold()
                    }
                }
                .padding(.trailing)
                .padding(.leading)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .frame(maxHeight: 80)
                        .foregroundColor(Color(uiColor: K.textColor))
                    
                    HStack(spacing: 50) {
                        Link(destination: URL(string: "https://github.com/jakubchojak")!) {
                            Image("github_logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 70, maxHeight: 70)
                        }
                        
                        Link(destination: URL(string: "https://www.linkedin.com/in/jakub-chojak-282308203/")!) {
                            Image("linkedin_logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 60, maxHeight: 60)
                        }
                    }
                }
                .padding(.trailing)
                .padding(.leading)
            }
        }
    }
}
