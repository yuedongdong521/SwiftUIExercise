//
//  ViewLayoutGroup.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/11/2.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

/// 使用扩展组织布局代码
extension View {
    func circle(foreground: Color = .white, background: Color = .blue) -> some View {
        Circle()
            .fill(background)
            .overlay(Circle().strokeBorder(foreground).padding(3))
            .overlay(self.foregroundColor(foreground))
            .frame(width: 100, height: 100, alignment: .center)
    }
}

/// 使用 ViewBuilder 分装View泛型布局
struct CireleWrapper<Content: View>: View {
    var foreground, background: Color
    var content: Content
    init(foreground: Color = .white, background: Color = .blue, @ViewBuilder content: () -> Content) {
        self.foreground = foreground
        self.background = background
        self.content = content()
    }
    
    var body: some View {
        Circle()
            .fill(background)
            .overlay(Circle().strokeBorder(foreground).padding(3))
            .overlay(content.foregroundColor(foreground))
            .frame(width: 100, height: 100, alignment: .center)
    }
}

struct CircleModifier: ViewModifier {
    var foreground = Color.white
    var background = Color.blue
    
    func body(content: Content) -> some View {
        Circle()
            .fill(background)
            .overlay(Circle().strokeBorder(foreground).padding(3))
            .overlay(content.foregroundColor(foreground))
            .frame(width: 100, height: 100, alignment: .center)
    }
    
}

struct CircleStyle: ButtonStyle {
    var foreground = Color.white
    var background = Color.blue
    
    
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        Circle()
            .fill(background.opacity(configuration.isPressed ? 0.8 : 1))
            .overlay(Circle().strokeBorder(foreground).padding(3))
            .overlay(configuration.label.foregroundColor(foreground))
            .frame(width: 100, height: 100, alignment: .center)
    }
}

struct ViewLayoutGroup: View {
 
    @State var isFold = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("extension 布局")
                    .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                    .circle()

                CireleWrapper.init {
                    Text("ViewBuilder 布局")
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                }
                
                Text("ViewModifier 布局")
                    .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .modifier(CircleModifier.init())
            }
            
            
            Button.init("ButtonStyle 布局", action: { print("ButtonStyle 布局") })
                .buttonStyle(CircleStyle())
                
            NavigationLink.init(destination: FoldHStackView(), isActive: $isFold) {
                Spacer().frame(height: 0)
            }
//            NavigationLink.init("", destination: FoldHStackView(), isActive: $isFold)
            
            NavigationLink.init(destination: GeometryLayout()) {
                Text("自定义布局-几何读取器");
            }
            
            HStack {
                Button("one", action: {
                    self.isFold = self.isFold ? false : true
                })
                Button("Two", action: {})
                Button("three", action: {})
            }.buttonStyle(CircleStyle())
            
            
        }
    }
}

struct ViewLayoutGroup_Previews: PreviewProvider {
    static var previews: some View {
        ViewLayoutGroup()
    }
}
