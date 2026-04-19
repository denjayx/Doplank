//
//  HelpView.swift
//  Doplank
//
//  Created by Deni Wijaya on 17/04/26.
//

import SwiftUI

struct HelpView: View {
    private let dummyText = "Sint pariatur ullamco adipisicing veniam ad elit fugiat labore. Laborum non ut id elit ea id deserunt fugiat. Exercitation veniam qui consectetur magna sint ipsum in ea deserunt duis laboris laboris magna. Cupidatat cillum velit fugiat Lorem culpa."

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Help")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    
                    helpCard(title: "Pre-requisite", content: dummyText)
                    helpCard(title: "Do's", content: dummyText)
                    helpCard(title: "Dont's", content: dummyText)
                }
                .padding()
            }
            .background(Color(uiColor: .systemGroupedBackground))
            .toolbar(.hidden, for: .navigationBar)
        }
    }
    
    // MARK: - Reusable Card
    
    private func helpCard(title: String, content: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            Text(content)
                .font(.subheadline)
                .foregroundStyle(.primary.opacity(0.85)) // Slightly softer than primary
                .multilineTextAlignment(.leading)
                .lineSpacing(2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(Color(uiColor: .secondarySystemGroupedBackground), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    HelpView()
        .preferredColorScheme(.dark)
}
