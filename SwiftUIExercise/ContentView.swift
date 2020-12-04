//
//  ContentView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/6/28.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI



struct ContentView: View {
    /// 添加计数状态属性， counter值改变会使view重新调用 body，“并使用 counter 的新值来生成 view 的新描述”

    @State var counter = 0
    var body: some View {
    
        
        VStack {
            Button(action: {self.counter += 1}, label:{
                Text("tap me11233445!")
                .padding(10)
                .background(Color(.blue))
                .cornerRadius(5)
            })
            if counter > 0 {
                Text("You've tapped \(counter) times")
            } else {
                Text("You've not yet tapped")
            }

            HStack {
                Text("Hello")
                if true {
                    Text("圆")
                    Divider()
                } else {
                    Text("方")
                }
                Button(action: {}) { () -> Text in
                    return Text("Hi")
                }

            }


            Image("0")
                .resizable()

        }.debug_des()
        
        
    }
}

extension View {
    func debug_des() -> Self {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
