//
//  RegistrierenView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 05.07.24.
//

import SwiftUI



struct RegistrierenView: View {
    
    @EnvironmentObject var viewModel : LoginViewModel
    
    
    // MARK: VARIABLES -
    @State private var name = ""
    @State private var nachname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordCheck = ""
    
    
    
    var body: some View {
        VStack{
            Text("Neu hier? Jetzt registrieren!")
                .font(.title2)
                .bold()
            
            HStack{
                TextField("Name", text: $name)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
                TextField("Nachname", text: $nachname)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
            }
            TextField("E-Mail", text: $email)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
            TextField("Password", text: $password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
            TextField("Password bestätigen!", text: $passwordCheck)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
            
            Spacer()
            
            Button("Registrieren!"){
                viewModel.register(password: password, name: name, nachname: nachname, email: email, passwordCheck: passwordCheck)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .padding()
            .foregroundStyle(.white)
            
            
        }
        .padding()
        Spacer()
        
    }
    // MARK: Functions -
    
}
#Preview {
    RegistrierenView()
}
