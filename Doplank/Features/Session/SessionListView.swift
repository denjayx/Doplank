//
//  SessionListView.swift
//  Doplank
//
//  Created by Deni Wijaya on 13/04/26.
//

import SwiftUI

struct SessionListView: View {
    @State private var sessions = SessionResult.dummies
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("Sessions")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                
                List(sessions) { session in
                    NavigationLink(destination: SessionDetailView(result: session)) {
                        HStack {
                            Text("\(session.totalSeconds)s")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(formatDate(session.date))
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(8)
                    }
                }
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy hh:mm a"
        return formatter.string(from: date)
    }
}

#Preview {
    SessionListView()
        .preferredColorScheme(.dark)
}
