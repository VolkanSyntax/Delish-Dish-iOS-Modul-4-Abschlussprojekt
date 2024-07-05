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
            
        }
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
        
    }
        
    
    
    
    
    // MARK: Functions -
    func anmeldenToggle() {
        anmelden.toggle()
    }
}







#Preview {
    AuthentificationView()
}
