//
//  OnboardingView.swift
//  Doplank
//
//  Created by Deni Wijaya on 17/04/26.
//

import SwiftUI

struct OnboardingView: View {
    var onGetStarted: () -> Void
    
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                colors: [Color(red: 0.75, green: 0.35, blue: 0.05), .black, .black],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Spacer()
                
                // Title Area
                VStack(alignment: .leading, spacing: 4) {
                    Text("Stop guessing.")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundColor(Color(red: 0.95, green: 0.55, blue: 0.2))
                    Text("Start planking right.")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 36)
                
                // Features List
                VStack(alignment: .leading, spacing: 20) {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.8, green: 0.35, blue: 0.0))
                                .frame(width: 44, height: 44)
                            Image(systemName: "video.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                        Text("We watch your form.")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                    }
                    
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(Color(red: 0.8, green: 0.35, blue: 0.0))
                                .frame(width: 44, height: 44)
                            Image(systemName: "person.fill.checkmark")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                        }
                        Text("We fix it in real time.")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
                .padding(.bottom, 36)
                
                // Description Text
                Text("Place your device, get into plank position, and hold steady. The timer starts automatically, with voice guidance to help you maintain proper form.")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white.opacity(0.9))
                    .lineSpacing(4)
                    .padding(.bottom, 48)
                
                // CTA Button
                Button(action: {
                    onGetStarted()
                }) {
                    Text("Get Started")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color(red: 0.75, green: 0.3, blue: 0.0))
                        .cornerRadius(28)
                        .overlay(
                            RoundedRectangle(cornerRadius: 28)
                                .stroke(Color.white.opacity(0.3), lineWidth: 1)
                        )
                }
                .padding(.bottom, 16)
            }
            .padding(.horizontal, 24)
        }
    }
}

#Preview {
    OnboardingView(onGetStarted: {})
}
