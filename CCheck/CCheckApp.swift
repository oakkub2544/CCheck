//
//  CCheckApp.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 20/7/2567 BE.
//

import SwiftUI
import Firebase

@main
struct CCheckApp: App {
    let persistenceController = PersistenceController.shared

    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            //MARK: - Start at Login Page
            LoginPageView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
