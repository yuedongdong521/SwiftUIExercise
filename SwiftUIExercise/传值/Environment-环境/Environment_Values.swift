//
//  Environment_test.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/10/26.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

struct KnobShape: Shape {
    
    var pointerSize: CGFloat = 0.1
    var pointerWidth: CGFloat = 0.1
    
    var colorValue: CGFloat = 1
    
    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        return Path.init { (p) in
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - pointerWidth / 2, y: 2, width: pointerWidth, height: pointerHeight + 2))
        }
    }
    
    
}

fileprivate struct PointerSizeKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.1
}

fileprivate struct ColorKey: EnvironmentKey {
    static let defaultValue: Color? = nil
}

extension EnvironmentValues {
    var knobPointerSize: CGFloat {
        get {
            self[PointerSizeKey.self]
            
        }
        set {
            self[PointerSizeKey.self] = newValue
            
        }
    }
    
    var knobColor: Color? {
        get {
            self[ColorKey.self]
        }
        set {
            self[ColorKey.self] = newValue
        }
    }
    
    
    
}

extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        self.environment(\.knobPointerSize, size)
    }
    
    func knobColor(_ color: Color?) -> some View {
        self.environment(\.knobColor, color)
    }
}

struct Knob: View {
    @Binding var value: Double
    var pointerSize: CGFloat? = nil
    @Environment(\.knobPointerSize) var envPointerSize
    @Environment(\.knobColor) var envColor
    @Environment(\.colorScheme) var colorScheme
    
    private var fillColor: Color {
        envColor ?? (colorScheme == .dark ? Color.white : Color.black)
    }
    
    var body: some View {
        KnobShape.init(pointerSize: pointerSize ?? envPointerSize)
            .fill(fillColor)
            .rotationEffect(Angle(degrees: value * 330))
            .onTapGesture {
                withAnimation(.default) {
                    self.value = self.value < 0.5 ? 1 : 0
                }
            }
    }
}

struct Environment_Values: View {
    @State var value: Double = 0.5
    @State var knobSize: CGFloat = 0.1
    @State var userDefaultColor = true
    @State var hue: Double = 0
    
    private func coverNum<T: CVarArg>(_ num: T) -> String {
      
        return String(format: "%.2f", num)
    }
    
    var body: some View {
        VStack {
            Text("VStack<Text>调用debug函数")
                .debug_des("Text 测试")
                .transformEnvironment(\.font) { dump($0) }
            Text("VStack<Text>测试环境变量")
                .environment(\.font, Font.headline)
            VStack {
                Text("Text 1")
                HStack {
                    Text("Text 2")
                    Text("Text 3")
                }.font(.largeTitle)
            }
            
            Knob(value: $value)
                .frame(width: 100, height: 100, alignment: .center)
                .knobPointerSize(knobSize)
                .knobColor(userDefaultColor ? nil : Color(hue: hue, saturation: 1, brightness: 1, opacity: 1))
            
            HStack {
                Spacer()
                Text("Value")
                Slider(value: $value, in: 0...1)
                Text("\(self.coverNum(self.value))")
                Spacer()
                
            }
            
            HStack {
                Spacer()
                Text("Knob Size")
                Slider(value: $knobSize, in: 0...0.4)
                Text("\(self.coverNum(self.knobSize))")
                Spacer()
            }
            
            HStack {
                Spacer()
                Toggle(isOn: $userDefaultColor) {
                    Text("knob Color")
                }
                if userDefaultColor == false {
                    Slider(value: $hue, in: 0...1)
                    Text("\(self.coverNum(self.hue))")
                }
                Spacer()
            }.frame(alignment: Alignment.leading)
            
            Button {
                withAnimation(.default) {
                    self.value = self.value == 0 ? 1 : 0
                    self.knobSize = self.knobSize == 0 ? 0.4 : 0;
                }
            } label: { Text("Toggle") }

            
        }
        .debug_des("VStack 测试")
        
    }
}

struct Environment_Values_Previews: PreviewProvider {
    static var previews: some View {
        Environment_Values()
    }
}
