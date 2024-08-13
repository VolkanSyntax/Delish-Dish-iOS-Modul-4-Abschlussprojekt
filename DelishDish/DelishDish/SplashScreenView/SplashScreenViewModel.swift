//
//  SplashScreenViewModel.swift
//  DelishDish
//
//  Created by Volkan Yücel on 13.08.24.
//

import SwiftUI
import AVFoundation

class SplashScreenViewModel: ObservableObject {
    @Published var isActive = false
    @Published var size: CGFloat = 5.00
    @Published var opacity: Double = 3.0
    @Published var color = Color(red: 0.17, green: 0.26, blue: 0.3)
    private var player: AVAudioPlayer?

    func onAppear() {
        animateSplashScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
            withAnimation {
                self.isActive = true
                self.stopMusic()
            }
        }
    }

    func animateSplashScreen() {
        withAnimation(.easeIn(duration: 1.6)) {
            self.size = 0.8
            self.opacity = 1.0
        }
        withAnimation(.easeOut(duration: 20.2).delay(3.28)) {
            self.size = 250.00
            self.color = Color(red: 0.17, green: 0.26, blue: 0.3)
        }
        playMusic()
    }

    func playMusic() {
        if let url = Bundle.main.url(forResource: "SplashScreenMusic", withExtension: "mp3") {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.play()
            } catch {
                print("Error playing music: \(error.localizedDescription)")
            }
        }
    }

    func stopMusic() {
        player?.stop()
    }
}
