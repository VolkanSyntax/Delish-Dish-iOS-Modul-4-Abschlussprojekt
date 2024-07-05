//
//  AuthentificationView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 05.07.24.
//

import SwiftUI

struct AuthentificationView: View {
    
    // MARK: Variables -
    
    @State private var anmelden = false
    @State private var registrieren = false
    
    var body: some View {
        VStack{
            
            Button("Anmelden"){
                anmeldenToggle()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .bold()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            Button("Registrieren"){
                registrierenToggle()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .foregroundStyle(.white)
            .bold()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
        }
        .padding()
        
        .sheet(isPresented: $anmelden){
            NavigationView{
                LoginView()
                    .navigationBarItems(trailing: Button(action: {
                        anmelden.toggle()
                    }){
                        Image(systemName: "xmark")
                    })
            }
        }
        .sheet(isPresented: $registrieren){
            NavigationView{
                RegistrierenView()
                    .navigationBarItems(trailing: Button(action: {
                        registrieren.toggle()
                    }){
                        Image(systemName: "xmark")
                    })
            }
        }
        
    }
        
    
    
    
    
    // MARK: Functions -
    func anmeldenToggle() {
        anmelden.toggle()
    }
    
    
    func registrierenToggle() {
        registrieren.toggle()
    }
    
    
}







#Preview {
    AuthentificationView()
}
