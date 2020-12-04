//
//  RefreshView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/10/19.
//  Copyright © 2020 ydd. All rights reserved.
//

import Foundation
import SwiftUI

struct LabelView: View {
    let number: Int
    var body: some View {
        print("LabelView")
        return Group {
            if number > 0 {
                Text("You've tapped \(number) times")
            }
        }
    }
}

struct Label2View: View {
    @State var number = 0
    
    var body: some View {
        return VStack {
            Button("Tap Me（改变子视图计数属性）") {
                self.number += 1
            }
            if (self.number > 0) {
                Text("You've tapped \(self.number) times")
            }
        }
    }
}


struct Label3View: View {
    @Binding var number: Int
    var body: some View {
         Group {
            if number > 0 {
                Text("You've tapped \(number) times")
            }
        }
    }
}

struct LabelEach: View {
    var body: some View {
        VStack {
            VStack {
                ForEach(1...3, id:\.self) { x in
                    Text("Item\(x)")
                }
            }
            
            HStack {
                ForEach(1...3, id:\.self) { x in
                    Text("Item\(x)")
                }
            }
        }
    }
}

struct ViewBody: View {
    @Binding var counter :Int
    
    var body: some View {
        Group {
            /// body 相同属性位置返回的必须是确定的同种类型，要返回不同类型则推荐使用Group
            if counter > 0 {
                Image("0")
            } else {
                
                Text("Text")
            }
        }
    }
}

struct ViewBody2: View {
    @Binding var counter :Int
    
    var body: some View {
        
        /// body 相同属性位置返回的必须是确定的同种类型，要返回不同类型则 推荐使用Group, 这种方法xcode11.3时并不稳定
        if counter > 0 {
            AnyView(Text("Text"))
        } else {
            AnyView(Image("0"))
        }
    }
}


struct RefreshView: View {
    @State var counter = 0
    @State var labelNum = 0
    @State var bodyNum = 0
    @State var bodyNum2 = 0
    
    var body: some View {
         VStack {
        
            Button("Tap Me（直接改变计数属性）") {
                self.counter += 1
            }
            if counter > 0 {
                Text("You've tapped \(counter) times")
            }
            
            Spacer.init().frame(height: 20, alignment: Alignment.center)
            
            Button("label Tap me(计数属性传递给子view)") {
                self.labelNum += 1
            }
            LabelView(number: self.labelNum)
            
            Spacer.init().frame(height: 20, alignment: .center)
            Label2View()
            
            Spacer.init().frame(height: 20, alignment: .center)
 
//            Button("body返回不同类型控件方法一") {
//                self.bodyNum += 1
//            }
//            ViewBody.init(counter: $bodyNum)
//                
//            Spacer.init().frame(height: 20, alignment: .center)
//            Button("body返回不同类型控件方法二") {
//                self.bodyNum2 += 1
//            }
//            ViewBody2.init(counter: $bodyNum2)
            
            Label3View.init(number: $counter)
            
            LabelEach().frame(alignment: .center)
                .background(Color.red)
            
//            Spacer()
        }
    }
    
    
}
