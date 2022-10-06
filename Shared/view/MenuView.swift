//
//  MenuView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/09/19.
//
import SwiftUI

struct MenuView: View {
    
    @Binding var showMenu: Bool
    @Binding var showComposer: Bool
    @Binding var sortByDateDesc: Bool
    
    var body: some View {
        
        NavigationView{
            ZStack{ // 배경색 만드는 용도로 남겨둠
                
                VStack {
                    HStack {
                        Button{
                            showComposer = true
                            showMenu = false
                        }label: {
                            Image(systemName: "square.and.pencil")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding(.top, 30)
                    HStack {
                        Button(action: {
                            print("Hello")
                        }, label: {
                            Text("gil")
                        })
                    }
                    .padding(.top, 30)
                    HStack {
                        Button(action: {
                            print("Hello")
                        }, label: {
                            Text("gil")
                        })
                    }
                    .padding(.top, 30)
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .bottomBar) {
                        Button(action: {
                            withAnimation(.spring()) {
                                self.showMenu = false
                            }
                        }, label: {
                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                .resizable()
                                .foregroundColor(.black)
                                .frame(width: 30, height: 30)
                        })
                        .position(x: 100, y: 7)
                    }
                }
            }
        }
    }
}
struct MenuView_Previews: PreviewProvider {
    
    static var previews: some View {
        MenuView(showMenu: .constant(true), showComposer: .constant(true), sortByDateDesc: .constant(true))
    }
}
