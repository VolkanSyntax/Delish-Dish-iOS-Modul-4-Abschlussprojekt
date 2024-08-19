//
//  RegistrierenView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 05.07.24.
//

import SwiftUI

struct RegistrierenView: View {
    
    @EnvironmentObject var viewModel: LoginViewModel
    
    // MARK: VARIABLES -
    @State private var name = ""
    @State private var nachname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordCheck = ""
    @State private var hidePassword: Bool = true
    @State private var hidePasswordCheck: Bool = true
    
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
                    Text("not_registered_sign_up_now")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                    
                    HStack {
                        ZStack(alignment: .leading) {
                            if name.isEmpty {
                                Text("name")
                                    .foregroundColor(.white)
                                    .padding(.leading, 15)
                            }
                            TextField("", text: $name)
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
                        }
                        
                        ZStack(alignment: .leading) {
                            if nachname.isEmpty {
                                Text("last_name")
                                    .foregroundColor(.white)
                                    .padding(.leading, 15)
                            }
                            TextField("", text: $nachname)
                                .foregroundColor(.white)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
                        }
                    }
                    
                    HStack {
                        ZStack(alignment: .leading) {
                            if email.isEmpty {
                                Text("e_mail")
                                    .foregroundColor(.white)
                                    .padding(.leading, 15)
                            }
                            HStack {
                                TextField("", text: $email)
                                    .autocapitalization(.none)
                                    .foregroundColor(.white)
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
                            Text("password")
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
                    
                    ZStack(alignment: .leading) {
                        if passwordCheck.isEmpty {
                            Text("confirm_password")
                                .foregroundColor(.white)
                                .padding(.leading, 15)
                        }
                        HStack {
                            if hidePasswordCheck {
                                SecureField("", text: $passwordCheck)
                                    .foregroundColor(.white)
                                    .autocorrectionDisabled(true)
                                    .padding()
                            } else {
                                TextField("", text: $passwordCheck)
                                    .foregroundColor(.white)
                                    .autocorrectionDisabled(true)
                                    .padding()
                            }
                            
                            Button(action: {
                                hidePasswordCheck.toggle()
                            }) {
                                Image(systemName: hidePasswordCheck ? "eye.slash" : "eye")
                                    .foregroundColor(.white)
                            }
                            .padding(.trailing, 15)
                        }
                        .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
                    }
                    
                    Spacer(minLength: 300)
                    
                    Button("register") {
                        viewModel.register(password: password, name: name, nachname: nachname, email: email, passwordCheck: passwordCheck)
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
    RegistrierenView()
}
