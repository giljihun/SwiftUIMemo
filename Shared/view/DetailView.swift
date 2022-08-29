//
//  DetailView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/07/09.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: MemoEntity
    
    @EnvironmentObject var manager: CoreDataManager
    @EnvironmentObject var navigationState: NavigationState
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @State private var showComposer = false
    @State private var showDeleteAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    var placement: ToolbarItemPlacement {
        if horizontalSizeClass == .regular {
            return .primaryAction
        } else {
            return .bottomBar
        }
    }
    
    var body: some View {
        VStack{
            ScrollView {
                VStack{
                    HStack {
                        Text(memo.content ?? "")
                            .padding()
                        
                        Spacer(minLength: 0)
                    }
                    
                    HStack {
                        Text(memo.insertDate ?? .now, style: .date)
                            .font(.footnote)
                        .foregroundColor(.secondary)
                        Text(memo.insertDate ?? .now, style: .time)
                            .font(.footnote)
                        .foregroundColor(.secondary)
                    }
                    
                }
            }
        }
        .navigationTitle("Look")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: placement) {
                
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .foregroundColor(.red)
                .alert("Warning", isPresented: $showDeleteAlert) {
                    Button(role: .destructive) {
                        manager.delete(memo: memo)
                        dismiss()
                        
                        if horizontalSizeClass == .regular {
                            navigationState.listId = UUID()
                        } else {
                            dismiss()
                        }
                    } label: {
                        Text("Delete")
                    }

                } message: {
                    Text("걍 삭제해버릴까요?")
                }

                
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showComposer) {
            ComposeView(memo: memo)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            DetailView(memo: MemoEntity(context:
                CoreDataManager.shared.mainContext))
            .environmentObject(CoreDataManager.shared)
        }
    }
}
