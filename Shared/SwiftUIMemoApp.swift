//
//  SwiftUIMemoApp.swift
//  Shared
//
//  Created by mobicom on 2022/07/02.
//

import SwiftUI

@main // 앱의 시작점인 Entry Points를 지정하는 것
struct SwiftUIMemoApp: App {
    let manager = CoreDataManager.shared

    @StateObject var navigationState = NavigationState()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            MainListView()
                .environment(\.managedObjectContext, manager.mainContext)
                .environmentObject(manager)
                .environmentObject(navigationState)
        }.onChange(of: scenePhase) {
            newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is background")
            @unknown default:
                print("I received an unexpected thing.")
            }
        }
    }
}
