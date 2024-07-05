//
//  LoginView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 05.07.24.
//

import SwiftUI

struct LoginView: View {
    
    // MARK: VARIABLES -
   
    @State private var email = ""
    @State private var password = ""
    
    
   
    
    
    
    var body: some View {
        VStack{
            Text("Melde dich jetzt an!")
                .font(.title2)
                .bold()
          
            TextField("E-Mail", text: $email)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
            
            TextField("Password", text: $password)
                .padding()
                .background(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
            
            Spacer()
         
            Button("Anmelden!"){
                
                
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
 /*
    private func registrierenToggle(){
        registrieren.toggle()
    }
}
  */
    
#Preview {
    LoginView()
}
