import SwiftUI
import Charts

struct WeeklyChartView: View {
    @EnvironmentObject var sessions: SessionStore
    
    var body: some View {
        let data = makeDailyData(from: sessions.items)
        ZStack {
            // arka plan (TimerView'deki gibi)
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            Chart(data) { item in
                BarMark(
                    x: .value("Day", item.day),
                    y: .value("Minutes", item.minutes)
                )
                .annotation(position: .top) {
                    Text("\(Int(item.minutes)) dk")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
            }
            .chartPlotStyle { plot in
                plot.background(.clear)    // <-- Chart'ın beyaz arka planini seffaf yapar
            }
            .border (Color.black)
            .padding(.bottom, 250)
            .frame(width: 380, height:700)
            .navigationTitle("Weekly")
            
        }
    }
}
    
    #Preview {
        let store = SessionStore()
        let now = Date()
        let cal = Calendar.current
        
        store.items = [
            SessionRecord(title: "Study",
                          duration: 60*60,
                          date: now,
                          activityType: .study,
                          subject: "Math"),
            SessionRecord(title: "Reading",
                          duration: 30*60,
                          date: now,
                          activityType: .reading,
                          subject: nil),
            SessionRecord(title: "Work",
                          duration: 120*60,
                          date: cal.date(byAdding: .weekOfYear, value: -1, to: now)!,
                          activityType: .work,
                          subject: nil)
        ]
        
        return WeeklyChartView()
            .environmentObject(store)
    }

