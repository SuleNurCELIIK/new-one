//
//  WeeklyChartData.swift
//  CHRONOS
//
// 

import Foundation

// Her haftayi temsil eden basit bir model
struct DaySummary: Identifiable {
    var id: Date { day }
    let day: Date      // Haftanin baslangic tarihi
    let minutes: Int    // O hafta toplam dakika
}

// SessionRecord listesinden haftalik toplamlari cikar
func makeDailyData(from sessions: [SessionRecord]) -> [DaySummary] {
    let cal = Calendar.current
    var totals: [Date: Int] = [:]
    //call=users takvimi gunun baslangicini ayarla
    //totals=>sozluk/dictionary= date:hafta baslangici, Int: o gunun toplam dakikasi

    // Her kaydin gununu bul ve dakika olarak topla
    // r= x gibi yazilan degisken
    //
    for r in sessions {
        //bu kaydin tarihinin icinde bulundugu haftanin baslangic tarihini ver
        let startOfDay = cal.startOfDay(for: r.date)
        //?? r.date= eger dateInterval bir sekilde nil (bos) donerse en azindan kaydin kendi tarihini kullan??
        totals[startOfDay, default: 0] += r.duration / 60
        //Sozlukte bu hafta icinde daha once bir giris yoksa 0 kabul et
        //r.duration saniye cinsinden dakikaya cevir icin kullaniliyor
    }

    // Tarih sirasina göre siralayip diziye cevir
    //.sorted() kronoojik siraya diziyor
    let sortedDates = totals.keys.sorted()
//map-> her date icin bir WeekSummary olustur
    return sortedDates.map { date in
        DaySummary(day: date, minutes: totals[date] ?? 0)
    }
}
//Bu dosyayi haftalik kayittan gunluk kayda cevirdin ama dosyanin adi hala weekly unutma
