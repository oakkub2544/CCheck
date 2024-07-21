//
//  RegisterPageView.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 20/7/2567 BE.
//

import SwiftUI
import Firebase

struct RegisterPageView: View {
    //MARK: - Property
    @StateObject private var authService = AuthService.shared
    
    @State var email: String = ""
    @State var password: String = ""
    @FocusState private var focusedField: Bool
    @State private var isSecure: Bool = true
    
    @State private var navigateToLogin = false
    
    //MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Hi!")
                        .font(.system(size:32))
                        .fontWeight(.bold)
                        .foregroundColor(Color("ColorPrimary"))
                        .padding(.bottom,8)
                        .padding(.leading,16)
                    Spacer()
                }//:HStack
                
                HStack {
                    Text("Create a new account")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .padding(.bottom,24)
                        .padding(.leading,16)
                    Spacer()
                }//:HStack
                
                TextField("Email", text:$email)
                    .font(.system(size: 16))
                    .padding()
                    .background(
                        Color(UIColor.systemGray6)
                        )
                    .cornerRadius(8)
                    .frame(width: 358, height: 48)
                    .focused($focusedField)
                
                ZStack {
                    HStack {
                        //Secure Password
                        if isSecure {
                            SecureField("Password (6-12 characters)", text: $password)
                                .font(.system(size: 16))
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(8)
                                .frame(width: 358, height: 48)
                                .focused($focusedField)
                                .padding(.top, 8)
                        } else {
                            TextField("Password (6-12 characters)", text: $password)
                                .font(.system(size: 16))
                                .padding()
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(8)
                                .frame(width: 358, height: 48)
                                .focused($focusedField)
                                .padding(.top, 8)
                        }
                    }//:HStack
                    //Eye button in Textfield
                    HStack {
                        Spacer()
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(systemName: isSecure ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                        .frame(height: 48)
                    .padding(.trailing, 32)
                    .padding(.top, 4)
                    }//:HStack
                }//:ZStack
                
                //Case: Password or Email invalid , Don't have account
                if authService.errorMessage != nil {
                    Text("Password doesn't meet the required format.")
                                        .foregroundColor(.red)
                                        .font(.system(size: 14))
                                        .padding(.top, 8)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                
                Button(action: {
                    authService.register(email: email, password: password)
                    focusedField = false
                }, label: {
                    AuthServiceButtonView(text: "Sign up")
                })
                //Go to Register Page
                NavigationLink(
                    destination: LoginPageView()) {
                        Text("Sign in")
                            .font(.system(size: 16))
                            .foregroundColor(Color("ColorPrimary"))
                            .padding(.top, 4)
                            .navigationBarBackButtonHidden(true)
                }
                
            }//:VStack
        }//:Navigation
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RegisterPageView()
}
