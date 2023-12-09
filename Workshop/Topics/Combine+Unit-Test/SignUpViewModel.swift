//
//  ViewModel.swift
//  DemoCombine
//
//  Created by Luong, D.H. (Dinh Hieu) on 23/11/2023.
//

import Foundation
import Combine

// MVVM + Combine
final class SignUpViewModel: ObservableObject {
    
    // MARK: - Inputs from View
    
    @Published var userEmail = ""
    @Published var userPassword = ""
    @Published var userRepeatedPassword = ""

    // MARK: - Outputs to View
    
    @Published var formIsValid = false        
    
    // MARK: - Init
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        isSignUpFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.formIsValid, on: self)
            .store(in: &cancellable)
    }
    
    
    // MARK: - Publishers
    
    var isUserEmailValidPublisher: AnyPublisher<Bool, Never> {
        $userEmail
            .map { email in
                email.contains("@")
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $userPassword
            .map { password in
                password.count >= 8
            }
            .eraseToAnyPublisher()
    }
    
    var isPasswordRepeated: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($userPassword, $userRepeatedPassword)
            .map { password, repeatedPassword in
                password == repeatedPassword
            }
            .eraseToAnyPublisher()
    }
    
    var isSignUpFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(
            isUserEmailValidPublisher,
            isPasswordValidPublisher,
            isPasswordRepeated
        )
        .map { isUserEmailValid, isPasswordValid, isPasswordRepeatedValid in
            isUserEmailValid && isPasswordValid && isPasswordRepeatedValid
        }
        .eraseToAnyPublisher()
    }
}
