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
    @Binding var showMenu: Bool
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\MemoEntity.insertDate, order: .reverse)])
    
    var memoList: FetchedResults<MemoEntity>
    
    @State private var keyword = ""
    @State private var sortByDateDesc = true
    
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
                //ToolbarItem(placement: //.navigationBarLeading) {
                    //Button {
                        //sortByDateDesc.toggle()
                    //} label: {
                       // Image(systemName:  "arrow.up.arrow.down")
                   // }
                //}
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            withAnimation {
                                self.showMenu = true
                            }
                        }) {
                            Image(systemName: "list.bullet.circle.fill")
                                .resizable()
                                .frame(width: 35, height: 35)
                        }
                    }
                
                    ToolbarItem(placement: .principal) {
                        VStack {
                            Text("MEMOBICOM")
                                .font(.custom("Copperplate", size: 30))
                                .padding()
                                .frame(width: 500, height: 0.0)
                        }
                    }
                
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button{
                            showComposer = true
                        }label: {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width: 30, height: 30)
                            }
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
                .onChange(of: sortByDateDesc) { desc in
                    if desc {
                        memoList.sortDescriptors = [
                            SortDescriptor(\.insertDate, order: .reverse)
                        ]
                    } else {
                        memoList.sortDescriptors = [
                            SortDescriptor(\.insertDate, order: .forward)]
                    }
                }
            
            VStack {
                Text("내 메모를 탭한 다음 메모를 선택하거나\n\n새 메모를 추가해보세요 ! \n :p")
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
        //뷰에 아이디를 추가, 아이디가 바뀌면 뷰 전체를 다시 그림
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
        MainListView(showMenu: .constant(true))
            .environmentObject(CoreDataManager.shared)
            .environment(\.managedObjectContext,
                          CoreDataManager.shared.mainContext)
            .environmentObject(NavigationState())
            .previewInterfaceOrientation(.portrait)
    }
}
