//
//  DataController.swift
//  SwiftUIMemo (iOS)
//
//  Created by mobicom on 2022/07/21.
//
import CoreData
import Foundation


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Memo")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
