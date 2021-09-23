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
        
        func navigaTitle() -> String {
            switch self {
            case .main:
                return "我的"
            case .home:
                return "home"
            case .message:
                return "消息"
            case .setting:
                return "设置"
            }
        }
         
        func hiddenNaviga() -> Bool {
            return true
        }
        
        
    }
    
    @State var selectIndex = TabIndex.main
    
    var body: some View {
        NavigationView {
            TabView.init(selection: $selectIndex) {
                MainView.init()
                    .tabItem {
                        Image(TabIndex.main.tabImage())
                        Text(TabIndex.main.navigaTitle())
                    }.tag(TabIndex.main).debug(TabIndex.main.tabImage())
                
                HomeView.init()
                    .tabItem {
                        Image(TabIndex.home.tabImage())
                        Text(TabIndex.home.navigaTitle())
                    }.tag(TabIndex.home)
                MessageView.init()
                    .tabItem {
                        Image(TabIndex.message.tabImage())
                        Text(TabIndex.message.navigaTitle())
                    }.tag(TabIndex.message)
                
                SettingView.init()
                    .tabItem {
                        Image(TabIndex.setting.tabImage())
                        Text(TabIndex.setting.navigaTitle())
                    }.tag(TabIndex.setting)
                
            }
//            .navigationBarTitle(Text(""), displayMode: .inline)
//            .navigationBarHidden(selectIndex.hiddenNaviga())
            
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
