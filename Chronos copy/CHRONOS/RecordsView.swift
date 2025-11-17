//
//  RecordsView.swift
//  CHRONOS
//
//  Created by sule nur celik on 10/11/25.
//

import SwiftUI

struct RecordsView: View {
    @EnvironmentObject var sessions: SessionStore
    
    var body: some View {
        NavigationStack {
            List {
                if sessions.items.isEmpty {
                    Text("No records yet").foregroundColor(.secondary)
                } else {
                    ForEach(sessions.items) { r in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(r.title).font(.headline)
                            Text("\(format(r.duration))  \(r.date.formatted(.dateTime.year().month().day().hour().minute()))")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                    .onDelete(perform: sessions.delete) //silme butonu
                }
            }
            .navigationTitle("Records")
            .toolbar { EditButton() }
            .accessibilityLabel(Text("Edit"))
        }
    }
        
        private func format(_ s: Int) -> String {
            let h = s / 3600, m = (s % 3600) / 60, ss = s % 60
            if h > 0 { return String(format: "%dh %02dm", h, m) }
            if m > 0 { return String(format: "%dm %02ds", m, ss) }
            return String(format: "%02ds", s)
        }
    }
    
    
    #Preview {
        RecordsView()
            .environmentObject(SessionStore())
    }

