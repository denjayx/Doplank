//
//  RootTabView.swift
//  Doplank
//
//  Created by Deni Wijaya on 17/04/26.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            SessionListView()
                .tabItem {
                    Label("Sessions", systemImage: "list.bullet")
                }
        }
		.tint(.orangeBrand)
    }
}

#Preview {
    RootTabView()
}
