//
//  ComposeView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/07/07.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store: MemoStore
    
    var memo: Memo? = nil /* */
    
    @Environment(\.dismiss) var dismiss
    
    @State private var content: String = ""
    @State private var Title: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("   Title . . . ", text: $Title)
                    .onAppear {
                        if let memo = memo {
                            Title = memo.Title
                        }
                    }
                    .padding(10)
                    .background()
                    .cornerRadius(15)
                    .background(.bar)
                    
                TextEditor(text: $content)
                    .onAppear {
                        if let memo = memo {
                            content = memo.content
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
                            store.update(memo: memo, Title: Title, content: content)
                        } else {
                            store.insert(memo: memo, Title: Title, content: content)
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
