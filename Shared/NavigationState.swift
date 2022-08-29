//
//  NavigationState.swift
//  SwiftUIMemo
//
//  Created by mobicom on 2022/08/29.
//

import Foundation
import SwiftUI

class NavigationState: ObservableObject {
    @Published var listId = UUID()
}
