//
//  Memo.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/07/03.
//

import Foundation
import SwiftUI

class Memo: Identifiable, ObservableObject {
    /*idetifiable -> 데이터를 리스트에 쉽게 바인딩하기 위해 필요,  observableobject -> 메모를 편집할 때 뷰를 자동으로 업데이트하기 위해 필요*/
    let id: UUID
    @Published var content: String /*published -> 새로운 값을 저장할 때마다 바인딩되어있는 ui가 자동 업데이트됨*/
    let insertDate: Date /* 날짜를 저장하는 속성 */
    
    init(content: String, insertDate: Date = Date.now) {
        id = UUID()
        self.content = content
        self.insertDate = insertDate
    }
}
