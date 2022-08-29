//
//  MainListView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/07/02.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var manager: CoreDataManager
    @EnvironmentObject var navigationState: NavigationState
    
    @State private var showComposer: Bool = false
    @FetchRequest(sortDescriptors: [SortDescriptor(\MemoEntity.insertDate, order: .reverse)]) //fechrequest 특성은 항상 뷰 안에서 실행해야된다.
    var memoList: FetchedResults<MemoEntity>
    
    @State private var keyword = ""
    
    
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
                            .frame(width: 500, height: 0.0)
                    }
                }
            }
            
            .toolbar {
                Button{
                    showComposer = true
                }label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .frame(width: 26, height: 26)
                }
                
            }
            .sheet(isPresented: $showComposer) {
                ComposeView()
            }
            .searchable(text: $keyword, prompt: "Search")
            .onChange(of: keyword) { newValue in
                if keyword.isEmpty {
                    memoList.nsPredicate = nil
                } else {
                    let titlePredicate: NSPredicate = NSPredicate(format:
                                                                    "title CONTAINS[c] %@", newValue)
                    let contentPredicate: NSPredicate = NSPredicate(format:
                                                                        "content CONTAINS[c] %@", newValue)
                    memoList.nsPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [titlePredicate, contentPredicate])
                    
                    
                    
                }
            }
            
            VStack {
                Text("내 메모를 탭한 다음 메모를 선택하거나\n새 메모를 추가할 수 있어요 :)")
                    .multilineTextAlignment(.center)
                    .font(.title3)
                Button{
                    showComposer = true
                } label: {
                    Image(systemName: "plus")
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
        }
        #if os(iOS)
        .id(navigationState.listId)
        #endif
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
            .environmentObject(NavigationState())
    }
}


                            	
