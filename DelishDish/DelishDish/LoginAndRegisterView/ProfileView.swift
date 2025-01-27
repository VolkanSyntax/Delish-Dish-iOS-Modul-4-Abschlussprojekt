//
//  ProfileView.swift
//  DelishDish
//
//  Created by Volkan Yücel on 08.07.24.
//

import SwiftUI

struct ProfileView: View {
    
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
                    Button("log_out") {
                        loginViewModel.logout()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("settings")
            .navigationBarTitleDisplayMode(.inline)
            }
        }
    
}

#Preview {
    ProfileView()
        .environmentObject(LoginViewModel())
}
