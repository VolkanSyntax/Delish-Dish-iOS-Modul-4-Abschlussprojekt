//
//  LoginView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 05.07.24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: LoginViewModel
    
    // MARK: VARIABLES -
    @State private var email = ""
    @State private var password = ""
    @State private var hidePassword: Bool = true
    
    let backgroundgradientcolor = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.32, green: 0.48, blue: 0.56), location: 0.48),
            Gradient.Stop(color: Color(red: 0.17, green: 0.44, blue: 0.57), location: 0.73),
        ],
        startPoint: UnitPoint(x: 0, y: 0.01),
        endPoint: UnitPoint(x: 1, y: 1.01)
    )
    
    var body: some View {
        ZStack {
            backgroundgradientcolor
                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    Text("Melde dich jetzt an!")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                    
                    HStack {
                        ZStack(alignment: .leading) {
                            if email.isEmpty {
                                Text("E-Mail")
                                    .foregroundColor(.white)
                                    .padding(.leading, 15)
                            }
                            HStack {
                                TextField("", text: $email)
                                    .foregroundColor(.white)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled(true)
                                    .padding()
                                Image(systemName: "envelope")
                                    .foregroundColor(.white)
                                    .padding(.trailing, 15)
                            }
                        }
                        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
                    }
                    
                    ZStack(alignment: .leading) {
                        if password.isEmpty {
                            Text("Password")
                                .foregroundColor(.white)
                                .padding(.leading, 15)
                        }
                        HStack {
                            if hidePassword {
                                SecureField("", text: $password)
                                    .foregroundColor(.white)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled(true)
                                    .padding()
                            } else {
                                TextField("", text: $password)
                                    .foregroundColor(.white)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled(true)
                                    .padding()
                            }
                            
                            Button(action: {
                                hidePassword.toggle()
                            }) {
                                Image(systemName: hidePassword ? "eye.slash" : "eye")
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing, 15)
                        }
                        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
                    }
                    
                    Spacer(minLength: 430)
                    
                    Button("Anmelden!") {
                        viewModel.login(email: email, password: password)
                    }
                    .frame(maxWidth: .infinity)
                    .bold()
                    .padding()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                    .foregroundStyle(backgroundgradientcolor)
                    
                }
                .padding()
                .padding(.bottom, 20) // Extra padding to avoid button overlap with keyboard
            }
        }
    }
}



#Preview {
    LoginView().environmentObject(LoginViewModel())
}

