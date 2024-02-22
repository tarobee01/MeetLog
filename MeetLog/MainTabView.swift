//
//  MainTabView.swift
//  MeetLog
//
//  Created by 武林慎太郎 on 2024/02/21.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    var body: some View {
        TabView {
            UserListView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            UserListView(filter: .contacted)
                .tabItem {
                    Label("Contacted", systemImage: "checkmark.circle")
                }
            UserListView(filter: .nocontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            MyProfileView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    MainTabView()
}
