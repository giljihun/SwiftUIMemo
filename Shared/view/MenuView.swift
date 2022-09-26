//
//  MenuView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/09/19.
//
import SwiftUI

struct MenuView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        
        NavigationView{
            ZStack{ // 배경색 만드는 용도로 남겨둠
               
            VStack {
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Profile")
                        .foregroundColor(.gray)
                        .font(.headline)
                    }
                .padding(.top, 30)
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Messages")
                        .foregroundColor(.gray)
                        .font(.headline)
                    }
                .padding(.top, 30)
                HStack {
                    Image(systemName: "gear")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Settings")
                        .foregroundColor(.gray)
                        .font(.headline)
                    }
                .padding(.top, 30)
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        withAnimation {
                            self.showMenu = false
                        }
                    }, label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                            .resizable()
                            .foregroundColor(/*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/)
                            .frame(width: 30, height: 30)
                    })
                    .position(x: 152, y: 5)
                }
            }
        }
      }
    }
}
struct MenuView_Previews: PreviewProvider {
    
    static var previews: some View {
        MenuView(showMenu: .constant(true))
    }
}
