//
//  AuthServiceButtonView.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 21/7/2567 BE.
//

import SwiftUI

struct AuthServiceButtonView: View {
    
    @State var text: String = ""
    
    var body: some View {
        HStack{
            Spacer()
            Text(text)
            Spacer()
        }
        .padding()
        .fontWeight(.bold)
        .font(.system(size: 16))
        .foregroundColor(.white)
        .background(Color("ColorPrimary"))
        .frame(width: 358,height: 56)
        .cornerRadius(8)
        .padding(.top, 8)
    }
}

#Preview {
    AuthServiceButtonView(text: "Sign in")
}
