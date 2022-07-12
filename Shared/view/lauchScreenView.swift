//
//  lauchScreenView.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/07/12.
//

import SwiftUI

extension MainListView {
    
    var launchScreenView: some View {
        
        ZStack(alignment: .center) {
            
            LinearGradient(gradient: Gradient(colors: [Color("PrimaryColor"), Color("SubPrimaryColor")]),
                           startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            
            Image("ic")
        }
    }
}
