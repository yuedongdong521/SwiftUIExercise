//
//  Stack_Layout.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/10/30.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

private func GetAlignment(_ a: VerticalAlignment) -> VerticalAlignment {
    switch a {
    case .center:
        return .bottom
    case .bottom:
        return .top
    case .top:
        return .firstTextBaseline
    case .firstTextBaseline:
        return .lastTextBaseline
    case .lastTextBaseline:
        return .myCenter
    default:
        return .center
    }
}

private func GetAlignmentName(_ a: VerticalAlignment) -> String {
    switch a {
    case .center:
        return "center"
    case .bottom:
        return "bottom"
    case .top:
        return "top"
    case .firstTextBaseline:
        return "firstTextBaseline"
    case .lastTextBaseline:
        return "lastTextBaseline"
    case .myCenter:
        return "myCenter"
    default:
        return "default"
    }
}

/// 自定义对齐方式
enum MyCenterID: AlignmentID {
    static func defaultValue(in context: ViewDimensions) -> CGFloat {
        return context.height / 3
    }
}

extension VerticalAlignment {
    static let myCenter: VerticalAlignment = VerticalAlignment.init(MyCenterID.self)
}

struct AlignmentGuideView: View {
    
    var body: some View {
        HStack(alignment: .myCenter, spacing: 10) {
            Rectangle().fill(Color.red)
                .frame(width: 50, height: 50)
            Rectangle().fill(Color.green)
                .frame(width: 30, height: 30)
            Rectangle().fill(Color.blue)
                .frame(width: 40, height: 40)
                .alignmentGuide(.myCenter) { (dim) -> CGFloat in
                    return dim[.myCenter] - 20
                }
            
        }.border(Color.gray)
    }
}

struct HStackView: View {
    @State var content: String = "HStack"
    @State var width: CGFloat = 0
    var body: some View {
        HStack(spacing:20) {
           Text(content)
            .frame(width: self.width, height: 200, alignment: .center)
            .truncationMode(.middle)
            .layoutPriority(0)
            
            Rectangle().fill(Color.red).frame(maxWidth: 200, maxHeight: 200)
                .layoutPriority(1)
            
            Text("布局优先级：layoutPriority").layoutPriority(10)
            Spacer().frame(width: 20, alignment: .center)
        }
        
        Slider.init(value: $width, in: 100...400) { v in
            let str = String(format: "%.2f", self.width)
            self.content += "HStack : " +  str + " v = \(v)\n"
        }
    }
}

struct HStackAlignment: View {
    @State var alignment: VerticalAlignment = .center
    @State var baseline: VerticalAlignment = .firstTextBaseline
    
    var body: some View {
        VStack {
            HStack (spacing: 20) {
                HStack (alignment: self.alignment, spacing: 10) {
                    Rectangle().fill(Color.red).frame(width: 50, height: 50)
                    Rectangle().fill(Color.green).frame(width: 40, height: 40)
                    Rectangle().fill(Color.blue).frame(width: 30, height: 30)
                }.border(Color.gray)
                
                Button.init {
                    self.alignment = GetAlignment(self.alignment)
                } label: {
                    Text(GetAlignmentName(self.alignment))
                        .foregroundColor(Color.red)
                }
            }
            
            HStack (spacing: 20) {
                HStack(alignment: self.baseline, spacing: 10) {
                    Text("first").font(Font.system(size: 20))
                    Text("midText").font(Font.system(size: 15))
                    Text("midText").font(Font.system(size: 10))
                }.border(Color.gray)
                
                Button.init {
                    self.baseline = GetAlignment(self.baseline)
                } label: {
                    Text(GetAlignmentName(self.baseline))
                        .foregroundColor(Color.yellow)
                }
            }
            
            AlignmentGuideView()
        }
    }
    
    
}




struct Stack_Layout: View {
    var body: some View {
        HStackView()
        
        HStackAlignment()
    }
}

struct Stack_Layout_Previews: PreviewProvider {
    static var previews: some View {
        Stack_Layout()
    }
}
