//
//  ComposeView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/07/07.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store: MemoStore
    
    @Environment(\.dismiss) var dismiss
    
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $content)
                    .padding()
            }
            .navigationTitle("< NEW Memozzang >")
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
                        store.insert(memo: content)
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
