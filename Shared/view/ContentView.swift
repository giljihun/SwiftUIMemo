//
//  ContentView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/09/19.
//
import SwiftUI

struct ContentView: View {
    
    @State var showMenu = false
    @Binding var showComposer: Bool
    @Binding var sortByDateDesc : Bool
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation(.spring()) {
                        self.showMenu = false
                    }
                }
            }
        return
            GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                MainListView(showComposer: self.$showComposer, showMenu: self.$showMenu, sortByDateDesc: self.$sortByDateDesc)
                                    .frame(width: geometry.size.width, height: geometry.size.height)
                                    .offset(x: self.showMenu ? geometry.size.width/2.6 : 0)
                                    .disabled(self.showMenu ? true : false)
                                    
                                    

                                if self.showMenu {
                                    MenuView(showMenu: self.$showMenu, showComposer: self.$showComposer, sortByDateDesc: self.$sortByDateDesc)
                                        .frame(width: geometry.size.width/2.6)
                                    
                                }
                            }
                            .gesture(drag)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement:.navigationBarLeading) {
                        Button(action: {
                            withAnimation {
                                self.showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                    }
                }
            }
        }
    }

