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
    // Gibt an, ob der Splash-Screen aktiv ist oder nicht.
    // Splash ekranının aktif olup olmadığını belirtir.
    @Published var size: CGFloat = 5.00
    // Steuert die Größe des Splash-Screen-Logos.
    // Splash ekranı logosunun boyutunu kontrol eder.
    @Published var opacity: Double = 3.0
    // Steuert die Deckkraft des Splash-Screen-Logos.
    // Splash ekranı logosunun opaklığını kontrol eder.
    private var player: AVAudioPlayer?
    // Ein Audio-Player-Objekt zum Abspielen von Musik während des Splash-Screens.
    // Splash ekranı sırasında müzik çalmak için bir ses oynatıcı nesnesi.
    func onAppear() {
        animateSplashScreen()
        // Startet die Animation des Splash-Screens.
        // Splash ekranının animasyonunu başlatır.
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.2) {
            withAnimation {
                self.isActive = true
                self.stopMusic()
            }
        }
        // Schaltet den Splash-Screen nach 3,2 Sekunden aus und stoppt die Musik.
        // 3,2 saniye sonra Splash ekranını kapatır ve müziği durdurur.
    }
    
    func animateSplashScreen() {
        withAnimation(.easeIn(duration: 1.6)) {
            self.size = 0.8
            self.opacity = 1.0
        }
        // Führt eine Einblendanimation für das Logo aus, die 1,6 Sekunden dauert.
        // 1,6 saniye süren logo için bir giriş animasyonu gerçekleştirir.
        
        withAnimation(.easeOut(duration: 20.2).delay(3.28)) {
            self.size = 250.00
        }
        // Führt eine Vergrößerungsanimation aus, die nach 3,28 Sekunden beginnt und 20,2 Sekunden dauert.
        // 3,28 saniye sonra başlayan ve 20,2 saniye süren bir büyüme animasyonu gerçekleştirir.
        
        playMusic()
        // Spielt die Musik für den Splash-Screen ab.
        // Splash ekranı için müziği çalar.
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
        // Spielt die im Bundle enthaltene Musikdatei ab, falls verfügbar.
        // Uygulama paketi içinde bulunan müzik dosyasını çalar, eğer mevcutsa.
    }
    
    func stopMusic() {
        player?.stop()
        // Stoppt die Musikwiedergabe.
        // Müzik çalmayı durdurur.
    }
}

