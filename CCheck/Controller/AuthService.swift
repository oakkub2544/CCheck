//
//  File.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 21/7/2567 BE.
//

import Foundation
import Firebase

class AuthService: ObservableObject {
    //MARK: - Property
    static let shared = AuthService()
    @Published var errorMessage: String? = nil
    
    //MARK: - Function
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.errorMessage = nil
            }
        }
    }
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
            } else {
                self?.errorMessage = nil
            }
        }
    }
}
