//
//  SettingsView.swift
//  NumbersExchange
//
//  Created by Jakub Chojak on 20/10/2022.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

        var btnBack : some View { Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                Image(systemName: "chevron.backward") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    Text("Powrót")
                        .foregroundColor(.white)
                }
            }
        }
    
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
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 80)
                
                HStack(spacing: 50) {
                    Text("Precyzja liczb rzeczywistych")
                        .foregroundColor(.white)
                    
                    Picker("", selection: $realApproximationSliderValue) {
                        ForEach(picks, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .foregroundColor(.white)
                    .accentColor(.white)
                    .onChange(of: realApproximationSliderValue) { value in
                        print(value)
                        writeApproxToFile(userApprox: value)
                    }
                }
                .padding()
                
                HStack {
                    Link(destination: URL(string: "https://metrystadiamentowy.wixsite.com/my-site-2/privacy-policy")!) {
                        Text("Polityka prywatności")
                            .foregroundColor(.white)
                            .bold()
                    }
                    Link(destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!) {
                        Text("EULA")
                            .foregroundColor(.white)
                            .bold()
                    }
                }
                .padding(.top, 50)
            }
        }
        .background(Color.teal).ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
    
    }
}
