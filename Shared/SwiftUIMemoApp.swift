//
//  SwiftUIMemoApp.swift
//  Shared
//
//  Created by mobicom on 2022/07/02.
//

import SwiftUI

@main
struct SwiftUIMemoApp: App {
    let manager = CoreDataManager.shared


    var body: some Scene {
        WindowGroup {
            MainListView()
                .environment(\.managedObjectContext, manager.mainContext)
                .environmentObject(manager)
        }
    }
}
