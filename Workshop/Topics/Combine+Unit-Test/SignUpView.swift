//
//  ContentView.swift
//  DemoCombine
//
//  Created by Luong, D.H. (Dinh Hieu) on 23/11/2023.
//

import SwiftUI

struct SignUpView: View {
    
    @ObservedObject private var viewModel: SignUpViewModel
    
    init(viewModel: SignUpViewModel = SignUpViewModel()) {
        self.viewModel = viewModel
    }        
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("User Email:", text: $viewModel.userEmail)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $viewModel.userPassword)
                    SecureField("Repete the Password", text: $viewModel.userRepeatedPassword)
                }
                Button("Sign Up") {
                    print("Sign Up ...")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .opacity(buttonOpacity)
                .disabled(!viewModel.formIsValid)
            }
        }
        .padding()
    }
    
    var buttonOpacity: Double {
        viewModel.formIsValid ? 1 : 0.5
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
