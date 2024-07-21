//
//  SettingListView.swift
//  CCheck
//
//  Created by Kanawat Rungwattanachai on 21/7/2567 BE.
//

import SwiftUI

struct SettingListView: View {
    //MARK: - Properties
    @State var rowLabel: String
    @State var rowIcon: String
    @State var rowtintColor: Color
    @State var rowLinkLabel: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 30, height: 30)
                    .foregroundColor(rowtintColor)
                Image(systemName: rowIcon)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
            .padding(.leading,-8)
            Text(rowLabel)
                .padding(.leading,4)
            
            Spacer()
            Text(rowLinkLabel)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    List {
        SettingListView(
            rowLabel: "Designer",
            rowIcon: "paintpalette",
            rowtintColor: .pink,
            rowLinkLabel: "Setting")
    }
}
