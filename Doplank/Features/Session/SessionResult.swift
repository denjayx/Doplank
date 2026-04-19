//
//  SessionResult.swift
//  Doplank
//

import Foundation

struct SessionResult: Identifiable {
    let id = UUID()
    let date: Date
    let totalSeconds: Int
    let stableSeconds: Int
    let breakSeconds: Int

    var minutes: Int { totalSeconds / 60 }
    var seconds: Int { totalSeconds % 60 }

    /// Dummy result for Xcode Preview
    static let preview = SessionResult(
        date: Date(),
        totalSeconds: 58,
        stableSeconds: 54,
        breakSeconds: 4
    )

    /// Dummy list for History/Session list
    static let dummies: [SessionResult] = [
        SessionResult(date: Date(), totalSeconds: 54, stableSeconds: 50, breakSeconds: 4),
        SessionResult(date: Date(), totalSeconds: 32, stableSeconds: 30, breakSeconds: 2),
        SessionResult(date: Date(), totalSeconds: 20, stableSeconds: 20, breakSeconds: 0),
        SessionResult(date: Date(), totalSeconds: 15, stableSeconds: 10, breakSeconds: 5)
    ]
}
