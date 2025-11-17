import SwiftUI

struct TimerView: View {
    @StateObject private var timer = TimerModel()
    @EnvironmentObject var sessions: SessionStore
    
    @State private var showSave = false
    @State private var titleText: String = "Study"
    
    // SaveSheet için gerekli ek state'ler
    @State private var selectedType: ActivityType = .study
    @State private var subjectText: String = ""
    
    
    private let primaryText = Color(.systemYellow)
    private let bg = Color(.systemGroupedBackground)
    private let buttonBG = Color (red: 25/255, green: 0/255, blue: 108/255)

    
    var body: some View {
        NavigationStack {
            ZStack {
                bg.ignoresSafeArea()
                
                VStack {
                    Text(Date(), format: .dateTime.year().month().day().weekday())
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                    
                    Spacer()
                    
                    // Big center circle
                    Button {
                        if timer.isRunning {
                            timer.pause()
                            showSave = true
                        } else {
                            timer.start()
                        }
                    } label: {
                        VStack(spacing: 6) {
                            Text(timer.timeText)
                                .font(.system(.title, design: .rounded).weight(.bold))
                                .monospacedDigit()
                            Text(timer.isRunning ? "Running" : "Tap to start")
                                .font(.subheadline)
                                
                        }
                        .foregroundColor(.white)
                        .frame(width: 310, height: 310)
                        .background(
                            Circle()
                                .fill(buttonBG)
                                .shadow(color: .black.opacity(0.08), radius: 12, y: 6)
                        )
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(timer.isRunning ? "Pause timer" : "Start timer")
                    .padding(.bottom, 100)
                    
                    Spacer()
                    
                    Button(action: {
                        print("Reset tapped")
                        timer.reset()
                    }) {
                        Text("Reset")
                            .font(.callout)
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .contentShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .buttonStyle(.plain)
                    .background(buttonBG)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(buttonBG, lineWidth: 2)
                    )
                    .cornerRadius(30)
                    .padding(.top, -145)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationTitle("Timer")
        }
        .sheet(isPresented: $showSave) {
            SaveSheet(
                titleText: $titleText,
                activityType: $selectedType,
                subjectText: $subjectText,
                onSave: {
                    let secs = timer.seconds
                    timer.reset()
                    
                    let subject = subjectText.trimmingCharacters(in: .whitespacesAndNewlines)
                    sessions.add(
                        title: titleText,
                        duration: secs,
                        activityType: selectedType,
                        subject: subject.isEmpty ? nil : subject
                    )
                    
                    showSave = false
                    UIAccessibility.post(notification: .announcement, argument: "Session saved")
                },
                onCancel: {
                    timer.reset()
                    showSave = false
                    UIAccessibility.post(notification: .announcement, argument: "Cancelled")
                }
            )
        }
    }
}


private struct SaveSheet: View {
    @Binding var titleText: String
    @Binding var activityType: ActivityType
    @Binding var subjectText: String
    
    var onSave: () -> Void
    var onCancel: () -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Title") {
                    TextField("Study / Work / Math…", text: $titleText)
                        .textInputAutocapitalization(.words)
                        .disableAutocorrection(true)
                }
                
                Section("Activity") {
                    Picker("Type", selection: $activityType) {
                        ForEach(ActivityType.allCases) { t in
                            Text(t.displayName).tag(t)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Subject (optional)") {
                    TextField("Math, Thermo…", text: $subjectText)
                        .textInputAutocapitalization(.words)
                }
                
                Section {
                    Button("Save record") { onSave() }
                    Button("Cancel", role: .cancel) { onCancel() }
                }
            }
            .navigationTitle("Save Session")
        }
    }
}

#Preview {
    TimerView()
        .environmentObject(SessionStore())
}
