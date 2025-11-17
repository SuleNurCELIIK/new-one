The project is built with Swift 6 and SwiftUI, targeting modern iOS devices (iOS 17/18+).
The app follows a simplified MVVM (Model–View–ViewModel) structure, where Store classes act as lightweight ViewModels to keep data logic separated from the UI layer. Chronos is a learning-focused UI prototype designed to explore Apple ecosystem tools such as Charts, Accessibility, and SwiftUI navigation.

ContainerView.swift; This file serves as the entry point of the app’s navigation.
It uses SwiftUI’s modern TabView syntax to manage the bottom Tab Bar, which contains three main sections: (Timer- Records- Charts)  The ContainerView ensures a consistent navigation flow between these core experiences.

MainTimerView.swift; The primary screen of the app — a clean, focused Timer interface.
It includes:  (Circular tap-to-start Timer, animated and accessible/ Reset controls/ 
Dynamic Typography for readable time formatting/ Accessibility labels and fully VoiceOver-safe interactions/ A background designed with proper contrast for WCAG compliance). 
The view is wrapped in a NavigationStack for clean hierarchical management.

SaveSessionView.swift; The screen used to save a completed session.
Features include: (TextFields for Title and optional Subject/ Activity Tag Selector (Study, Reading, Work, Exercise, Other)/ Form-style layout with high accessibility contrast/ Primary CTA: "Save record"). This view demonstrates SwiftUI form design, semantic grouping, and accessible input flows.

RecordsView.swift; The section dedicated to previously saved sessions. Contains:( A List-based session viewer/ Swipe actions (UI only)/ Toolbar Edit button/ Properly labeled cells for VoiceOver reading order)

Note: Although the UI is fully interactive, data persistence is still under development. Records are not permanently stored yet, which is expected behavior at this stage of the prototype.

ChartView.swift (Charts Framework); This screen visualizes daily or weekly activity using Apple’s Charts framework.
Highlights; (BarChart (UI prototype)/ Adaptable layout that scales for different screen sizes/
Proper color contrast using accessible palette choices/ Rounded typography for improved number readability). Charts update based on recorded data, but because session storage is not yet persistent, the displayed values currently rely on placeholder/mock data.

Technical Note:
This app is a UI Prototype.
Buttons, forms, and navigation flows are rendered and interactive, but features like persistent saving, record management, and data-driven charts are not yet connected to actual storage logic.
All displayed data inside the views is static or mock-based, used only for prototyping the user experience.

Author: Şule Nur Çelik --> This project is an independent educational prototype and is not affiliated with Apple or any third-party app.








