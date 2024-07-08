//
//  LoginView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 05.07.24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel : LoginViewModel
    
    // MARK: VARIABLES -
    @State private var email = ""
    @State private var password = ""
    
    let backgroundgradientcolor2 = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.32, green: 0.48, blue: 0.56), location: 0.48),
            Gradient.Stop(color: Color(red: 0.17, green: 0.44, blue: 0.57), location: 0.73),
        ],
        startPoint: UnitPoint(x: 0, y: 0.01),
        endPoint: UnitPoint(x: 1, y: 1.01)
    )
    
    
    var body: some View {
        ZStack {
            backgroundgradientcolor2
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text("Melde dich jetzt an!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)
                
                TextField("E-Mail", text: $email)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.white, lineWidth: 1))
                
                Spacer()
                
                Button("Anmelden!"){
                    viewModel.login(email: email, password: password)
                }
                .frame(maxWidth: .infinity)
                .bold()
                .padding()
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding()
                .foregroundStyle(backgroundgradientcolor2)
                
                
            }
            .padding()
            Spacer()
            
        }
    }
}
 
    
#Preview {
    LoginView().environmentObject(LoginViewModel())
}
