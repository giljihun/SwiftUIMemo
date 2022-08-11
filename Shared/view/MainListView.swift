//
//  MainListView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/07/02.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var manager: CoreDataManager
    @State private var showComposer: Bool = false
    @FetchRequest(sortDescriptors: [SortDescriptor(\MemoEntity.insertDate, order: .reverse)]) //fechrequest 특성은 항상 뷰 안에서 실행해야된다.
    var memoList: FetchedResults<MemoEntity>
    
    var body: some View {
        
        NavigationView {
                    List {
                            ForEach(memoList) { memo in
                                NavigationLink {
                                    DetailView(memo: memo)
                                } label: {
                                    MemoCell(memo: memo)
                                }
                            }
                            .onDelete(perform: delete)
                        }
                    .listStyle(PlainListStyle())
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            VStack {
                                Text("   MEMOBICOM")
                                    .font(.custom("Copperplate", size: 30))
                                    .padding(.leading)
                                    .frame(width: 500, height: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/)
                            }
                        }
                    }
                    
                    .toolbar {
                        Button{
                            showComposer = true
                        }label: {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .sheet(isPresented: $showComposer) {
                        ComposeView()
                }
            }
        }
    
    func delete(set: IndexSet){
        for index in set {
            manager.delete(memo: memoList[index])
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
            .environmentObject(CoreDataManager.shared)
            .environment(\.managedObjectContext,
                          CoreDataManager.shared.mainContext)
    }
}


                            	
