//
//  TimerModel.swift
//  CHRONOS
//
//  Created by sule nur celik on 10/11/25.
// Kronomometre mantigi
//

import Foundation
import Combine // veri akisi arasinda kopru
// Kendini otomatik guncelle yani arttir
class TimerModel: ObservableObject {
    @Published var seconds: Int = 0
    @Published var isRunning: Bool = false
//IOS icinde mini saat otomatik kod
    private var timer: Timer?
//Calistir
    func start() {
        guard !isRunning else { return } // guard+else zaten calisiyorsa bir sey yapma
        isRunning = true //kullaniciya running yazisini gostermek icin
        //her bir saniye de kendini calistir (timerstore dosyasinda yazili)
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.seconds += 1 // weak self_inself??
        }
        if let t = timer { RunLoop.main.add(t, forMode: .common) } //RunLoop= iphone'nun ekranini surekli yenilemesini saglayan bir dongu sistemi=> yani swiftui "ui yogun"oldugunda Timer'i pause etmeye zorlar yani duraklama saniye atlama gibi sorunlara yol acar bu yuzden RunLoop.main.add.(.common) kodu "Timer her durumda calissin scroll olsa da animasyon olsa da uygulama yogun olsa da durmasin" deriz
    }

    func pause() {
        isRunning = false
        timer?.invalidate()
        timer = nil // nil=bos
    }

    func reset() {
        pause()
        seconds = 0
    }
//timerText=> saniyeyi formatli yazi yapar
    var timeText: String {
        let h = seconds / 3600
        let m = (seconds % 3600) / 60
        let s = seconds % 60
        return String(format: "%02d:%02d:%02d", h, m, s) // digit form
    }
}

