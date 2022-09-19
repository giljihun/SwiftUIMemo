//
//  ContentView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/09/19.
//
import SwiftUI

struct ContentView: View {
    
    @State var showMenu = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                MainListView(showMenu: self.$showMenu)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                    .disabled(self.showMenu ? true : false)
                if self.showMenu {
                    MenuView()
                        .frame(width: geometry.size.width/2)
                }
            }
        }
    }
}
