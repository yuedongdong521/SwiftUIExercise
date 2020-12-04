//
//  AnimationView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/11/3.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI


/// 自定义动画  {
struct Shake: AnimatableModifier {
    
    var times: CGFloat = 0
    let amplitude: CGFloat = 10
    var animatableData: CGFloat {
        get { times }
        set {
            times = newValue
            
        }
    }
    
    func body(content: Content) -> some View {
        return content.offset(x: sin(times * .pi * 2) * amplitude)
    }
}

extension View {
    func shake(times: Int) -> some View {
        return modifier(Shake(times: CGFloat(times)))
    }
}

struct Blur: ViewModifier {
    var active: Bool
    
    func body(content: Content) -> some View {
        return content.blur(radius: active ? 50 : 0)
            .opacity(active ? 0 : 1)
    }
}

extension AnyTransition {
    static var blur: AnyTransition {
        .modifier(active: Blur(active: true), identity: Blur(active: false))
    }
}

/// }

/// animation ：隐式动画 {
struct RepeatAnimation: View {
    @State var start: Bool = false
    
    var body: some View {
        Button.init {
            self.start.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red)
                .frame(width: 40, height: 20, alignment: .center)
                .rotationEffect(Angle.degrees(start ? 45 : 0), anchor: UnitPoint.init(x: 0.5, y: 0.5))
                .animation(Animation.default.repeatCount(3, autoreverses: false))
        }
    }
}

struct SpringAnimation: View {
    @State var start: Bool = false
    var body: some View {
        Button.init {
            self.start.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.red)
                .frame(width: 30, height: 30, alignment: .center)
                .offset(x: 0, y: start ? 30 : 0)
                .animation(Animation.interpolatingSpring(stiffness: 0.5, damping: 0.5))
        }

    }
}

struct TapAnimation: View {
    @State var selected: Bool
    var body: some View {
        Button.init {
            self.selected.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(selected ? Color.red : .green)
                .frame(width: 100, height: 20, alignment: .center)
                .rotationEffect(Angle.degrees(selected ? 45 : 0), anchor: UnitPoint.init(x: 0, y: 0))
        }.animation(.linear(duration: 1))
    }
}

/// 过度动画
struct TranstionAnimationView: View {
    @State var visible = false
    var body: some View {
        VStack {
            Button("Toggle"){ self.visible.toggle() }
            if visible {
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100, alignment: .center)
                    .transition(.slide)
                    .animation(.default)
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100, alignment: .center)
                    .transition(.blur)
                    .animation(.easeOut(duration: 1))
                
                
            }
        }
    }
}

struct LoadingIndicator: View {
    
    @State private var animating = false
    
    var body: some View {
        Image("0")
            .resizable().aspectRatio(contentMode: .fill)
            .rotationEffect(animating ? Angle.degrees(360) : .zero)
            .animation(Animation.linear(duration: 2)
                        .repeatForever(autoreverses: false)
            )
            .onAppear {
                self.animating = true
            }
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(50)
    }
}




struct ChangeColorView: View {
    @State var selected: Bool = false
    
    @State var isAppear: Bool = false
    
    var body: some View {
        Button.init {
            self.selected.toggle()
        } label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(selected ? Color.red : Color.green)
                .frame(width: selected ? 100 : 50, height: selected ? 100 : 50, alignment: .center)
                .animation(self.isAppear ? .linear(duration: 5) : nil)
                .onAppear() {
                    self.isAppear.toggle()
                }
                .onDisappear() {
                    self.isAppear.toggle()
                }
        }
    }
}
/// }

struct AnimationView: View {
    
    @State private var taps: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack (spacing: 20) {
                ChangeColorView()
                
                TapAnimation(selected: false)
                
                SpringAnimation()
                
                RepeatAnimation()
            }
            
            HStack (spacing: 20) {
                NavigationLink.init(destination: LoadingIndicator()) {
                    Text("旋转动画")
                }
                
                NavigationLink.init(destination: TranstionAnimationView()) {
                    Text("过度动画")
                }
                
                Button("HELLO") {
                    withAnimation(.linear(duration: 0.5)) {
                        self.taps += 1
                    }
                }
                .shake(times: taps * 3)
                
            }
            
            ShowLoadingIndicator()
        }
        
    }
}

struct AnimationView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationView()
    }
}
