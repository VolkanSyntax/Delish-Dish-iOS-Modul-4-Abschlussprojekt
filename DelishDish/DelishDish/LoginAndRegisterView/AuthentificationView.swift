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
    
    let backgroundgradientcolor = LinearGradient(
        stops: [
            Gradient.Stop(color: Color(red: 0.17, green: 0.26, blue: 0.3), location: 0.14),
            Gradient.Stop(color: Color(red: 0.07, green: 0.18, blue: 0.23), location: 0.41),
        ],
        startPoint: UnitPoint(x: 0, y: 0.01),
        endPoint: UnitPoint(x: 0.97, y: 1)
    )
    
    
    
    var body: some View {
        ZStack {
            backgroundgradientcolor
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                VStack {
                    Spacer()
                        .padding()
                    Image("Logo") 
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.bottom, 110)
                    Button("sign_in"){
                        anmeldenToggle()
                    }
                    
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(backgroundgradientcolor)
                    .bold()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                    
                    Button("register"){
                        registrierenToggle()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(backgroundgradientcolor)
                    .bold()
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding()
                }
                Spacer()
                    .padding()
                
                    .sheet(isPresented: $anmelden){
                        NavigationStack{
                            LoginView()
                                .navigationBarItems(trailing: Button(action: {
                                    anmelden.toggle()
                                }){
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                })
                        }
                    }
                    .sheet(isPresented: $registrieren){
                        NavigationStack{
                            RegistrierenView()
                                .navigationBarItems(trailing: Button(action: {
                                    registrieren.toggle()
                                }){
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                })
                        }
                    }
                
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
