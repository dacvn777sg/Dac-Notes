//
//  MainTabBarView.swift
//  Dac-Notes
//
//  Created by Dac Vu on 26/02/2023.
//

import SwiftUI

struct MainTabbarView: View {
    
    @State var selectedTab = Tab.home
    
    enum Tab: Int {
        case home, other
    }
    
    func tabbarItem(text: String, image: String) -> some View {
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            Text(text)
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView().tabItem{
                self.tabbarItem(text: "My notes", image: "house.circle")
            }.tag(Tab.home).toolbarBackground(Color("steam_yellow"), for: .tabBar)
            
            OtherUserView().tabItem{
                self.tabbarItem(text: "Other", image: "figure.wave.circle.fill")
            }.tag(Tab.other).toolbarBackground(Color("steam_yellow"), for: .tabBar)
        }.accentColor(.accentColor)
    }
}

struct MainTabbarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabbarView()
    }
}
