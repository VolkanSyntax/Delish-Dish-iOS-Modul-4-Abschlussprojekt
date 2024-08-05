//
//  SettingsView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 08.07.24.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: VARIABLE -
    
    @EnvironmentObject var loginViewModel: LoginViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("User Details")) {
                    Text(loginViewModel.user?.name ?? "Unknown Name")
                    Text(loginViewModel.user?.nachname ?? "Unknown Surname")
                    Text(loginViewModel.user?.email ?? "Unknown Email")
                }

                Section {
                    Button("Abmelden") {
                        loginViewModel.logout()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Settings")
            }
        }
    
}

#Preview {
    SettingsView()
        .environmentObject(LoginViewModel())
}
