//
//  AddButton.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 21/7/2567 BE.
//

import SwiftUI

struct AddButtonView: View {
    @State private var animatingButton: Bool = false
    
    var body: some View {
        ZStack {
            Group {
                Circle()
                    .fill(Color("ColorPrimary"))
                    .opacity(self.animatingButton ? 0.2 : 0)
                    .frame(width: 48, height: 48, alignment: .center)
                Circle()
                    .fill(Color("ColorPrimary"))
                    .opacity(self.animatingButton ? 0.15 : 0)
                    .frame(width: 64, height: 64, alignment: .center)
            }
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color("ColorPrimary"))
                .frame(width: 40, height: 40)
        }
        .accentColor(Color("ColorPrimary"))
        .onAppear(perform: {
            self.animatingButton.toggle()
        })
    }
}

#Preview {
    AddButtonView()
}
