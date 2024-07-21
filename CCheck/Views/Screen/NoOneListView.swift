//
//  NoOneListView.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 21/7/2567 BE.
//

import SwiftUI

struct NoOneListView: View {
    //MARK: - Body
    var body: some View {
        VStack {
            Image("NoOne")
                .resizable()
                .scaledToFit()
                .frame(width: 136)
                .padding(.bottom,16)
            Text("Looks like there’s nothing here yet. \nAdd something to get started!")
                .font(.system(size:16))
                .fontWeight(.bold)
                .foregroundColor(Color("ColorPrimary"))
                .padding(.top,24)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    NoOneListView()
}
