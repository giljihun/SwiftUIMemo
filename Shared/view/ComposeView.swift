//
//  ComposeView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/07/07.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var manager: CoreDataManager
    
    var memo: MemoEntity? = nil
    
    @Environment(\.dismiss) var dismiss
    
    @State private var content: String = ""
    @State private var title: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("   Title . . . ", text: $title)
                    .onAppear {
                        if let memo = memo?.title {
                            title = memo
                        }
                    }
                    .padding(10)
                    .background()
                    .cornerRadius(15)
                    .background(.bar)
                    
                TextEditor(text: $content)
                    .onAppear {
                        if let memo = memo?.content {
                            content = memo
                        }
                    }
                    .cornerRadius(15)
                    .padding(15)
                    .background(.bar)
                    
                    
            }
            .navigationTitle(memo != nil ? "Editing Memo" : " NEW Memo ")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading)
                {
                    Button {
                        dismiss()
                    } label: {
                        Text("CANCEL")
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing)
                {
                    
                    Button {
                        
                        if let memo = memo {
                            manager.update(memo: memo, content: content, Title: title)
                        } else {
                            manager.addMemo(content: content, Title: title)
                        }
                        
                        dismiss()
                    } label: {
                        Text("SAVE")
                    }
                }
            }
                
        }
    }
}

struct ComposeView_Previews: PreviewProvider {
    static var previews: some View {
        ComposeView()
            .environmentObject(MemoStore())
    }
}
