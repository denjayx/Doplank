import SwiftUI

struct CardStyle: ViewModifier {
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                Color(uiColor: .secondarySystemGroupedBackground),
                in: RoundedRectangle(cornerRadius: cornerRadius)
            )
    }
}

extension View {
    func cardStyle(cornerRadius: CGFloat = 28) -> some View {
        self.modifier(CardStyle(cornerRadius: cornerRadius))
    }
}
