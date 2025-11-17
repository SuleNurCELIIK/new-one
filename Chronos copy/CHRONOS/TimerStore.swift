//
//  TimerStore.swift
//  CHRONOS
//
//  
//


import Foundation
import Combine
// takip et degisinde degistir
//timRemaining=ekranda geri sayan
class TimerStore: ObservableObject {
    @Published var timeRemaining: Int = 0
    @Published var isRunning: Bool = false
    
    private var timer: Timer?// iOS’un calisan zamanlayıcisi

    //Timer baslarken zamanlayici ayarlandi
    func start(duration: Int) {
        timeRemaining = duration
        isRunning = true
        //Burasi onemli cunku burada ""her 1 saniyede calsitir" kodu gonderiliyor
        //withTimeInterval:1 sn ifade ediyor
        //repeast: true -> durmadan calis
        // closure icinde calisacak kod timer her tick tack edince calisir
        //*weak self* bellek sizintisini onlemek icin
        //guard= bir kosula baglanir ve olmazsa cik demektir-> true ise no problem, false ise *else* baglanir return, continuie veya throw gibi bir zorunlu baglama baglanir
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            // bu kodda ise guard let self"yani degerin hayatta mi= eger degilse fonksiyondan geri don"
            //durdur calistir
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                self.stop()
            }
        }
    }
    //durdurma fonksiyonu
    func stop() {
        isRunning = false
        timer?.invalidate()//timer tamamen kapatir arka planda calismaz
        timer = nil //nil=bos deger
    }
    //reset fonksiyon
    func reset() {
        stop()
        timeRemaining = 0
    }
}
//let=sabit
//var=degisken
//class= referans tipi-> View kac kez degisirse degissin, ayni nesneui kullan

