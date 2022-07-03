//
//  MemoStore.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/07/03.
//

import Foundation

class MemoStore: ObservableObject {
    @Published var list: [Memo]
    /* 배열을 published로 선언하면 배열을 업데이트 할때마다 바인딩되어있는 뷰도 자동 업데이트됨*/
    
    init() {
        list = [
            Memo(content: "Hello", insertDate: Date.now),
            Memo(content: "Awesome", insertDate: Date.now.addingTimeInterval(3600 * -24)),
            Memo(content: "SwiftUI", insertDate: Date.now.addingTimeInterval(3600 * -48))
        ]
    }
    
    func insert(memo: String) {
        list.insert(Memo(content: memo), at: 0)
        /*새로운 메모를 항상 0번 인덱스에 추가함으로써 가장 먼저 표시되는 기능!*/
    }
    
    func update(memo: Memo?, content: String) {
        guard let memo = memo else {
            return
        }
        
        memo.content = content
    }
    
    func delete(memo: Memo){
    list.removeAll { $0.id == memo.id}
    }
    
    func delete(set: IndexSet) {
        for index in set {
            list.remove(at: index)
        }
    }
}
