//
//  Preferences_Test.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/10/27.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

struct MyNavigationTitleKey: PreferenceKey {
    static var defaultValue: String? = nil
    
    /// “reduce 方法，来对应多个子树都定义了 navigation title 的情况”
    static func reduce(value: inout String?, nextValue: () -> String?) {
        value = value ?? nextValue()
    }
    
}

extension View {
    func myNavigationTitle(_ title: String) -> some View {
        preference(key: MyNavigationTitleKey.self, value: title)
    }
}

struct MyNavigationView<Content>: View where Content: View {
    
    let content: Content
    @State private var title: String? = nil
    
    var body: some View {
        VStack {
            Text(title ?? "")
                .font(Font.largeTitle)
            content.onPreferenceChange(MyNavigationTitleKey.self) { title in
                self.title = title
            }
        }
    }
}

struct TabItemKey: PreferenceKey {
    static let defaultValue: [String] = []
   
    static func reduce(value: inout [String], nextValue: () -> [String]) {
        value.append(contentsOf: nextValue())
    }
}

struct MyTabView: View {
    @State var titles: [String]
    
    var body: some View {
        List {
            ForEach(titles, id: \.self) { item in
                Text("cell : \(item)")
                    .background(Color.red)
                    .foregroundColor(Color.white)
            }
        }
//        .onPreferenceChange(TabItemKey.self) { items in
//            self.titles = items
//        }
    }
}


struct Preferences_Test: View {
    var body: some View {
        
        MyNavigationView(content:
                            VStack {
                                Text("Hello")
                                    .myNavigationTitle("Root View")
                                    .background(Color.gray)
                                MyTabView(titles:  ["item1", "item2", "item3"])
                            })
    }
}

struct Preferences_Test_Previews: PreviewProvider {
    static var previews: some View {
        Preferences_Test()
    }
}
