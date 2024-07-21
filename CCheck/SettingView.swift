//
//  SettinView.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 21/7/2567 BE.
//


import SwiftUI
import Firebase

struct SettingView: View {
    
    @State private var showingLoginView = false
    @State private var showingLogoutConfirmation = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            List {
                Section (
                    header: Text("About the app")
                        .padding(.top,-32),
                    footer: HStack {
                        Spacer()
                        Text("Copyright © All right reserved.")
                        Spacer()
                    }
                        .padding(.vertical, 8)
                ){
                        SettingListView(
                            rowLabel: "Application",
                            rowIcon: "apps.iphone",
                            rowtintColor: .blue,
                            rowLinkLabel: "CCheck"
                        )
                        SettingListView(
                            rowLabel: "Compatibility",
                            rowIcon: "info.circle",
                            rowtintColor: .red,
                            rowLinkLabel: "iOS"
                        )
                        SettingListView(
                            rowLabel: "Technology",
                            rowIcon: "swift",
                            rowtintColor: .orange,
                            rowLinkLabel: "Swift"
                        )
                        SettingListView(
                            rowLabel: "Devaloper",
                            rowIcon: "ellipsis.curlybraces",
                            rowtintColor: .mint,
                            rowLinkLabel: "Kanawat"
                        )
                        SettingListView(
                            rowLabel: "Designer",
                            rowIcon: "paintpalette",
                            rowtintColor: .pink,
                            rowLinkLabel: "Kanawat"
                        )
                    }
                    Section {
                            Button(action: {
                                showingLogoutConfirmation = true
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Logout")
                                        .foregroundColor(.red)
                                        .bold()
                                    Spacer()
                                }
                            }
                        }
                    .frame(height: 24)
                }

                .alert(isPresented: $showingLogoutConfirmation) {
                    Alert(
                        title: Text("Confirm Logout"),
                        message: Text("Are you sure you want to logout?"),
                        primaryButton: .destructive(Text("Logout")) {
                            try! Auth.auth().signOut()
                            showingLoginView = true
                        },
                        secondaryButton: .cancel()
                    )
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Setting")
                            .font(.title2)
                            .bold()
                    }
                }
                .navigationDestination(isPresented: $showingLoginView) {
                    NavigationView {
                        LoginPageView()
                    }
                    .navigationBarBackButtonHidden(true)
                }
                .frame(height: .infinity)
        }//:Navigation
    }
}

#Preview {
    SettingView()
    
}

