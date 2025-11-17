//
//  ContentView.swift
//  CHRONOS
//
//
import SwiftUI

struct ContentView: View {
    //struct= deger tipi-> kopyalanir-> Swiftui Viewlar struct
    let buttonColor = Color(red: 25/255, green: 0/255, blue: 108/255)  // <– ekledik

    var body: some View {
        TabView {
            TimerView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }

            RecordsView()
                .tabItem {
                    Label("Records", systemImage: "list.bullet")
                }

            WeeklyChartView()
                .tabItem {
                    Label("Charts", systemImage: "chart.bar")
                }
        }
        .tint(buttonColor)   // <<<<<<<<<< SEÇİLİ TAB RENGİ BUTONLA AYNI OLUR
    }
}


    #Preview {
        ContentView()
            .environmentObject(SessionStore())
    }
    

