//
//  MemoData+CoreDataProperties.swift
//  SwiftUIMemo (iOS)
//
//  Created by mobicom on 2022/07/21.
//
//

import Foundation
import CoreData


extension MemoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoData> {
        return NSFetchRequest<MemoData>(entityName: "MemoData")
    }

    @NSManaged public var uuid: UUID?
    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var date: Date?

}

extension MemoData : Identifiable {

}
