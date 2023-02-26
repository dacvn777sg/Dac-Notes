//
//  AppRouter.swift
//  Dac-Notes
//
//  Created by Dac Vu on 24/02/2023.
//

import SwiftUI

class AppRouter: ObservableObject {
    @Published var state: AppState = .inputName
    
    init() {
        let userId = UserDefaults.standard.string(forKey: "USER_ID") ?? ""
        self.state = userId.isEmpty ? .inputName : .tabbar
    }
}
enum AppState {
    case inputName
    case tabbar
}
