//
//  LoginPageView.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 20/7/2567 BE.
//

import SwiftUI
import Firebase

struct LoginPageView: View {
    //MARK: - Property
    @StateObject private var authService = AuthService.shared
    
    @State var email: String = ""
    @State var password: String = ""
    @State private var  userIsLoggedIn = false
    @State private var isSecure: Bool = true
    
    @FocusState private var focusedField: Bool
    
    @State private var isNavigating = false
    
    //MARK: - Body
    //Check login status
    var body: some View {
        if userIsLoggedIn {
            ContentView()
        } else {
            content
        }
    }
    
    //MARK: - Login UI
    var content: some View {
        NavigationView {
            VStack {
                Image("CHOW")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180)
                    .padding(.bottom,-24)
                    .padding(.top,80)
                
                Text("Welcome!")
                    .font(.system(size:32))
                    .fontWeight(.bold)
                    .foregroundColor(Color("ColorPrimary"))
                    .padding(.bottom,8)
                
                Text("Sign in to continue")
                    .font(.system(size: 16))
                    .foregroundColor(.secondary)
                    .padding(.bottom,24)
                    
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
                    Text("Password or Email is invalid.")
                                        .foregroundColor(.red)
                                        .font(.system(size: 14))
                                        .padding(.top, 8)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                
                Button(action: {
                    authService.login(email: email, password: password)
                    focusedField = false
                }, label: {
                    AuthServiceButtonView(text: "Sign in")
                })
                //Check Email and Password
                .onAppear {
                    Auth.auth().addStateDidChangeListener( { auth, user in
                        if user != nil {
                            userIsLoggedIn.toggle()
                        }
                    })
                }
                .navigationDestination(isPresented: $isNavigating) {RegisterPageView()}
                
                //Go to Register Page
                NavigationLink(
                    destination: RegisterPageView()) {
                        Text("Sign up")
                            .font(.system(size: 16))
                            .foregroundColor(Color("ColorPrimary"))
                            .padding(.top, 4)
                            .navigationBarBackButtonHidden(true)
                }
                
                Spacer()
            }//:VStack
        }//:Navigation
        .navigationBarBackButtonHidden(true)
    }
}


//MARK: - Preview
#Preview {
    LoginPageView()
}
