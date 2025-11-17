//
//  CHRONOSApp.swift
//  CHRONOS
//
//  Created by sule nur celik on 06/11/25.
//

import SwiftUI

@main
struct CHRONOSApp: App {
    @StateObject private var sessions = SessionStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sessions) // enviroment object onemli veri aksi arasinda baglanti saglar her view bununla kapat diyebiliriz galiba
        }
    }
}
