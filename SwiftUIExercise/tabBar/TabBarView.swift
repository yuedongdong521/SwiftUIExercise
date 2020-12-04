//
//  TabBarView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/9/27.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

struct TabBarView: View {
    
    enum TabIndex: Int {
        case main, home, message, setting
        
        func tabImage() -> String {
            
            return String.init(format: "tab_0%d", self.rawValue + 1)
        }
        
        
        
    }
    
    @State var selectIndex = TabIndex.main
    
    var body: some View {
        TabView.init(selection: $selectIndex) {
            MainView.init()
                .tabItem {
                    Image(TabIndex.main.tabImage())
                    Text("main")
                }.tag(TabIndex.main).debug(TabIndex.main.tabImage())
            HomeView.init()
                .tabItem {
                    Image(TabIndex.home.tabImage())
                    Text("home")
                }.tag(TabIndex.home)
            MessageView.init()
                .tabItem {
                    Image(TabIndex.message.tabImage())
                    Text("消息")
                }.tag(TabIndex.message)
            SettingView.init()
                .tabItem {
                    Image(TabIndex.setting.tabImage())
                    Text("设置")
                }.tag(TabIndex.setting)
            
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
