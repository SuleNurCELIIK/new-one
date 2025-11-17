//
//  SessionStore.swift
//  CHRONOS
//
//  Created by sule nur celik on 10/11/25.
//
import SwiftUI      
import Foundation
import Combine
// Identifiable=taninabilirlik, Codable= Ileride bunlari UsersDefault/dosya/JSON'a kaydedilebilmesi icin yazdigim deger
struct SessionRecord: Identifiable, Codable {
    var id = UUID() //kimlik
    let title: String //baslik "Study"
    let duration: Int  // kac sn surdu
    let date: Date
    let activityType: ActivityType
    let subject: String? //opsiyonel
}
//Aktivite tipi
enum ActivityType: String, CaseIterable, Codable, Identifiable { // enum= bu degerler sadece """ olabilir demek icin kullanilir.
    case study
    case reading
    case work
    case exercise
    case other

    var id: String { self.rawValue } // rawValue=gercek deger

    var displayName: String {
        switch self {
        case .study: return "Study"
        case .reading: return "Reading"
        case .work: return "Work"
        case .exercise: return "Exercise"
        case .other: return "Other"
        }
    }
}
//Tum kayitlarin tutuldugu yer

class SessionStore: ObservableObject {
    @Published var items: [SessionRecord] = []
//items=tum kayitlari bir arada tutar
//add=yeni kayit ekle
//delete=sil tabii
    func add(title: String, duration: Int, activityType: ActivityType, subject: String?) {
        let record = SessionRecord(
            title: title,
            duration: duration,
            date: Date(),
            activityType: activityType,
            subject: subject
        )
        items.insert(record, at: 0)
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }
}

