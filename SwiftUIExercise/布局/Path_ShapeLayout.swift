//
//  Path&ShapeLayout.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/10/28.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI


struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        return Path.init { p in
            p.move(to: CGPoint(x: rect.midX, y: rect.midY))
            p.addLines([
                CGPoint(x: rect.maxX, y: rect.maxY),
                CGPoint(x: rect.minY, y: rect.maxY),
                CGPoint(x: rect.midX, y: rect.minY)
            ])
            
        }
    }
}

struct Rectangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path.init { (p) in
            p.addRect(rect)
        }
    }
}

struct TextLayout: View {
    
    var body: some View {
        Text("文本布局:从澳洲到南美洲，从地中海到北美大陆，18个不同气候、不同国家的坚果，因为三只松鼠成为“中国制造”， 凭借着标志性风味与趣味性的惊喜体验，累计超过9亿袋的健康坚果，销往全球167个国家和地区，今天无论你是在法国、澳大利亚还是拥有7500万松鼠粉的中国，都能相遇三只松鼠的主人，不同肤色的他们不同的语言说着“哇哦！”三只松鼠“坚果！”")
            .border(Color.green)
            /// fixedSize()调用则文本内容可以再建议区域外部显示
//            .fixedSize()
            /// 字体
            .font(Font.system(size: 16))
            /// 行数， nil则不限制行数，自动换行
            .lineLimit(nil)
            /// 文字显示不完时截断方式
            .truncationMode(Text.TruncationMode.middle)
            /// 当显示不全时自动缩小字体
            .minimumScaleFactor(0.5)
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
    }
}


struct OffsetLayout: View {
    
    var body: some View {
        HStack {
            Circle().fill(Color.red)
            Circle().fill(Color.green).offset(y:-30)
            Circle().fill(Color.blue)
        }.border(Color.gray)
        .frame(width: 300, height: 100, alignment: .trailing)
    }
}

struct BackgroundLayout: View {
    
    var body: some View {
        Text("Hello")
            .background(
                Capsule()
                    .stroke()
                    .padding(-5)
            )
    }
}

/// Circle
struct CircleLayout: View {
    var body: some View {
        Text("Start")
            .foregroundColor(.white)
            .background(
                Circle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100)
            )
            .frame(width: 100, height: 100, alignment: .center)
    }
}

/// overlay
struct CircleView: View {
    var body: some View {
        Circle()
            .fill(Color.blue)
            .overlay(
                Text("Overlay")
                    .foregroundColor(.white)
            )
            .overlay(Circle().strokeBorder(Color.white).padding(3))
            .frame(width: 100, height: 100, alignment: .center)
    }
}

struct ClippedView: View {
    var body: some View {
        Rectangle()
            .rotation(.degrees(45))
            .fill(Color.red)
            .clipped()
            .frame(width: 100, height: 100, alignment: .center)
    }
}

struct ClipShapeView: View {
    var body: some View {
        Text("ClipShape")
            .background(Color.red)
            .frame(width: 100, height: 100, alignment: .center)
    }
}

/// 修饰器
struct BottomView: View {
    var body: some View {
        VStack(spacing: 30, content: {
            HStack {
                BackgroundLayout()
                    .border(Color.gray)
                CircleLayout()
                    .border(Color.gray)
                CircleView()
                    .border(Color.gray)
            }.frame(height: 100, alignment: .center)
            
            HStack(spacing: 30) {
                Rectangle()
                    .rotation(Angle.degrees(45))
                    .fill(Color.red)
                    .frame(width: 100, height: 100, alignment: .center)
                    .border(Color.gray)
                ClippedView()
                    .border(Color.gray)
            }
            
            ClipShapeView()
                .frame(width: 100, height: 100, alignment: .center)
                .background(Color.gray)
                .clipShape(RoundedRectangle.init(cornerRadius: 15))
                .border(Color.black)
            
        })
        
    }
}

struct Path_ShapeLayout: View {
    var body: some View {
        VStack {
            
            Group {
                Triangle()
                    .fill(Color.yellow)
                    .frame(width: 100, height: 100, alignment: .leading)
                    .background(Color.red)
                
                Spacer().frame(height: 30, alignment: .center)
                
                Rectangle.init()
                    .rotation(.degrees(45))
                    .fill(Color.pink)
                    .frame(width: 100, height: 100, alignment: .center)
                    .border(Color.blue)
                
                Spacer().frame(height: 30, alignment: .center)
                
                let image = Image("runway_party_portrait")
                HStack {
                    image.border(Color.red)
                    image.resizable().border(Color.red)
                    image.resizable().aspectRatio(contentMode: .fit).border(Color.red)
                    image.resizable().aspectRatio(0.5, contentMode: .fit).border(Color.red)
                    image.resizable().aspectRatio(CGSize(width: 0.5, height: 0.5), contentMode: .fit).border(Color.red)
                }.frame(height: 100, alignment: .center)
                
                Spacer().frame(height: 20, alignment: .center)
                
                TextLayout()
                    .frame(width: 300, height: 100, alignment: .center)
                    .border(Color.gray)
                
                Spacer().frame(height: 50, alignment: .center)
                
                OffsetLayout()

            }
            
            Group {
                Spacer().frame(height: 10, alignment: .center)
                NavigationLink.init(destination: BottomView()) {
                    Text("修饰器")
                }
                Spacer()
            }
        }
        .background(Color.init(Color.RGBColorSpace.sRGB, white: 0.5, opacity: 1))
        .navigationBarTitle("Path布局", displayMode: NavigationBarItem.TitleDisplayMode.inline)
    }
}

struct Path_ShapeLayout_Previews: PreviewProvider {
    static var previews: some View {
        Path_ShapeLayout()
    }
}
