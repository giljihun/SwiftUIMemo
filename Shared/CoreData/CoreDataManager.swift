//
//  CoreDataManager.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/08/07.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager: ObservableObject {
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
        
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "SwiftUIMemo")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    
    func addMemo(content: String, Title: String, insertDate: Date) {
        let newMemo = MemoEntity(context: mainContext)
        newMemo.content = content
        newMemo.title = Title
        newMemo.insertDate = Date.now
        
        saveContext()
    }
    

    
    func update(memo: MemoEntity?, content: String, Title: String, insertDate: Date) {
        memo?.content = content
        memo?.title = Title
        memo?.insertDate = Date.now
        saveContext()
    }
    func delete(memo: MemoEntity?) {
        if let memo = memo {
            mainContext.delete(memo)
            saveContext()
        }
    }
}
