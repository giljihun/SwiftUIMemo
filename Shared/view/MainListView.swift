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
    
    @Binding var showComposer: Bool
    @Binding var showMenu: Bool
    @Binding var sortByDateDesc: Bool
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\MemoEntity.insertDate, order: .reverse)])
    
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
                }.onDelete(perform: delete)
                
            } // 메모를 리스트로 뷰잉
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                  ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        sortByDateDesc.toggle()
                    } label: {
                        Image(systemName:  "arrow.up.arrow.down")
                    }
                }

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
                
                    
                
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button{
//                            showComposer = true
//                        }label: {
//                            Image(systemName: "square.and.pencil")
//                                .resizable()
//                                .frame(width: 30, height: 30)
//                            }
//                        }
//                ToolbarItem(placement: .principal) {
//                    VStack {
//                        Text("MEMOBICOM")
//                            .font(.custom("Copperplate", size: 30))
//                            .padding()
//                            .frame(width: 500, height: 0.0)
//                    }
//                } // "MEMOBICOM" 제목 설정
                ToolbarItem(placement: .principal) {
                    VStack {
                        Image("MEMObicom")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 80)
                            .offset(x: 0, y: -19)
                    }
                }
                }
                .sheet(isPresented: $showComposer) {
                    ComposeView()
                } // 메모 작성 시트 보여주는 속성
                .searchable(text: $keyword, prompt: "Search") // 검색 속성1
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
                } // 검색 속성2
                .onChange(of: sortByDateDesc) { desc in
                    if desc {
                        memoList.sortDescriptors = [
                            SortDescriptor(\.insertDate, order: .reverse)
                        ]
                    } else {
                        memoList.sortDescriptors = [
                            SortDescriptor(\.insertDate, order: .forward)]
                    }
                } // 정렬 속성
            
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
            } // iPad에서 나오는 두번째 뷰
        }
        #if os(iOS) // macOS에선 작동하지 않도록 설정
        .id(navigationState.listId)
        // 뷰에 아이디를 추가, 아이디가 바뀌면 뷰 전체를 다시 그림
        #endif
        }
    
    func delete(set: IndexSet){
        for index in set {
            manager.delete(memo: memoList[index])
        }
    } // 메모 삭제
}

struct MainListView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainListView(showComposer: .constant(false), showMenu: .constant(true), sortByDateDesc: .constant(false))
            .environmentObject(CoreDataManager.shared)
            .environment(\.managedObjectContext,
                          CoreDataManager.shared.mainContext)
            .environmentObject(NavigationState())
            .previewInterfaceOrientation(.portrait)
    }
}
