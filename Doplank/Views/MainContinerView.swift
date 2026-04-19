//
//  MainTabView.swift
//  Doplank
//
//  Created by Deni Wijaya on 17/04/26.
//

import SwiftUI

struct MainContainerView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            SessionListView()
                .tabItem {
                    Label("History", systemImage: "list.bullet")
                }
            HelpView()
                .tabItem {
                    Label("Help", systemImage: "book.pages")
                }
        }
        .tint(Color.orange)
    }
}

#Preview {
    MainContainerView()
}
