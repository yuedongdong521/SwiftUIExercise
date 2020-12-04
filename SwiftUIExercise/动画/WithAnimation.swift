//
//  WithAnimation.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/11/5.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

struct Bounce: AnimatableModifier {
    ///
    var times: CGFloat = 0
    var amplitude: CGFloat = 10
    
    var animatableData: CGFloat {
        get { times }
        set { times = newValue }
    }
    
    func body(content: Content) -> some View {
        print("times : \(times)")
        return content.offset(y: abs(sin(times * .pi * 2)) * amplitude)
    }
    
}

extension View {
    func Bound(times: CGFloat, amplitude: CGFloat) -> some View {
        return modifier(Bounce(times: times, amplitude: amplitude))
    }
}

/// 显示动画
struct ShowLoadingIndicator: View {
    @State var appeared = false
    
    let animation = Animation.linear(duration: 2)
        .repeatForever(autoreverses: false)
    
    
    var body: some View {
        Circle()
            .fill(Color.accentColor)
            .frame(width: 5, height: 5, alignment: .center)
            .offset(y: -20)
            .rotationEffect(appeared ? Angle.degrees(360) : .zero)
            .onAppear {
                withAnimation(self.animation) {
                    self.appeared = true
                }
            }
    }
}



struct WithAnimation: View {
    
    @State var times: Int = 0
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        
        ShowLoadingIndicator()
        
        Spacer().frame(height: 50, alignment: Alignment.center)
        
        VStack(spacing: 0) {
            RoundedRectangle.init(cornerRadius: 2)
                .fill(Color.gray)
                .frame(height: 4, alignment: .center)
                
            Button.init {
                withAnimation(Animation.linear(duration: 1)) {
                    /// 在动画时间内 times 增加2
                    self.times += 2
                
                    print("反弹动画：\(self.times)")
                }
            } label: {
                RoundedRectangle.init(cornerRadius: 10)
                    .fill(Color.green)
                    .frame(width: 100, height: 100, alignment: .center)
                    .Bound(times: CGFloat(times), amplitude: 50)
            }

        }
        
        
    }
}

struct WithAnimation_Previews: PreviewProvider {
    static var previews: some View {
        WithAnimation()
    }
}
