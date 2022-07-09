//
//  MainListView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/07/02.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var store: MemoStore
    
    @State private var showComposer: Bool = false
    
    var body: some View {
        NavigationView {
            List(store.list) { memo in
                NavigationLink {
                    DetailView(memo: memo)
                } label: {
                    MemoCell(memo: memo)
                }
            }
            .listStyle(.plain)
            .navigationTitle("My Memo")
            .toolbar {
                Button{
                    showComposer = true
                }label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showComposer) { ComposeView()
        }
        
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
            .environmentObject(MemoStore())
    }
}


}
