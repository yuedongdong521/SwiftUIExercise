//
//  GeometryLayout.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/11/2.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

struct BoundsKey: PreferenceKey {
    static var defaultValue: Anchor<CGRect>? = nil
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = value ?? nextValue()
    }
}

struct BoundsContentView: View {
    let tabs: [Text] = [
        Text("World Clock"),
        Text("Alarm"),
        Text("Bedtime")
    ]
    
    @State var selectedTabIndex = 0
    
    var body: some View {
        HStack {
            ForEach(tabs.indices) { tabIndex in
                Button {
                    self.selectedTabIndex = tabIndex
                } label: {
                    self.tabs[tabIndex]
                }
                .anchorPreference(key: BoundsKey.self, value: .bounds) { anchor in
                    self.selectedTabIndex == tabIndex ? anchor : nil
                }
//                .overlayPreferenceValue(BoundsKey.self) { anchor in
//                    GeometryReader { proxy in
//                        Rectangle()
//                            .fill(Color.accentColor)
//                            .frame(width: proxy[anchor!].width, height: 2, alignment: .center)
//                            .offset(x: proxy[anchor!].minX)
//                    }
//                }

            }
        }
    }
}

struct WidthKey: PreferenceKey {
    static let defaultValue: CGFloat? = nil
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = value ?? nextValue()
    }
}

struct TextWithCircle: View {
    @State private var width: CGFloat? = nil
    
    var body: some View {
        Text("Hello, world")
            .background(GeometryReader.init(content: { proxy in
                Color.clear.preference(key: WidthKey.self, value: proxy.size.width)
            }))
            .onPreferenceChange(WidthKey.self) {
                self.width = $0
            }
            .frame(width: width, height: width, alignment: .center)
            .background(Circle().fill(Color.blue))
    }
}


struct GeometryStart: View {
    
    var body: some View {
        VStack {
            Text("Start")
                .foregroundColor(.white)
                .padding(10)
                .background(
                    GeometryReader { reader in
                        Circle()
                            .fill(Color.blue)
                            .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                    })
        }
    }
}

struct CollectSizePreference: PreferenceKey {
    static let defaultValue: [Int: CGSize] = [:]
    static func reduce(value: inout [Int : CGSize], nextValue: () -> [Int : CGSize]) {
        value.merge(nextValue(), uniquingKeysWith: {$1})
    }
    
}

struct CollectSize: ViewModifier {
    var index: Int
    func body(content: Content) -> some View {
        content.background(GeometryReader { proxy in
            Color.clear.preference(key: CollectSizePreference.self, value: [self.index: proxy.size])
        })
    }
}

struct Stack<Element, Content: View>: View {
    var elements: [Element]
    var spacing: CGFloat = 8
    var axis: Axis = .horizontal
    var alignment: Alignment = .topLeading
    var content: (Element) -> Content
    @State private var offsets: [CGPoint] = []
    
    private func computeOffsets(sizes: [Int: CGSize]) {
        guard !sizes.isEmpty else {
            return
        }
        var offsets: [CGPoint] = [.zero]
        for idx in 0..<self.elements.count {
            guard let size = sizes[idx] else {
                fatalError()
            }
            var newPoint = offsets.last!
            newPoint.x += size.width + self.spacing
            newPoint.y += size.height + self.spacing
            offsets.append(newPoint)
        }
        self.offsets = offsets
    }
    
    private func offset(at index: Int) -> CGPoint {
        guard index < offsets.endIndex else {
            return .zero
        }
        return offsets[index]
    }
    
    var body: some View {
        ZStack (alignment: alignment) {
            ForEach.init(elements.indices) { idx in
                self.content(self.elements[idx])
                    .modifier(CollectSize(index: idx))
                    .alignmentGuide(self.alignment.horizontal) {
                        self.axis == .horizontal ? -self.offset(at: idx).x : $0[self.alignment.horizontal]
                    }
                    .alignmentGuide(self.alignment.vertical) {
                        self.axis == .vertical ? -self.offset(at: idx).y : $0[self.alignment.vertical]
                    }
            }
        }.onPreferenceChange(CollectSizePreference.self, perform: self.computeOffsets)
    }
}

struct CustomView: View {
    let colors: [(Color, CGFloat)] = [(.red, 50), (.green, 30), (.blue, 75)]
    @State var horizontal: Bool = true
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.default) {
                    self.horizontal.toggle()
                }
            } label: {
                Text("Toggle axis")
            }
            
            Stack.init(elements: colors, spacing: 8, axis: horizontal ? .horizontal : .vertical, alignment: .topLeading) { item in
                Rectangle()
                    .fill(item.0)
                    .frame(width: item.1, height: item.1)
            }
            .border(Color.black)

        }
    }
}

/// 创建cell key，监听cell宽度
struct CellMaxWidthKey: PreferenceKey {
    static let defaultValue: [Int: CGFloat] = [:]
    static func reduce(value: inout [Int : CGFloat], nextValue: () -> [Int : CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

struct TableView<Cell: View>: View {
    var cells: [[Cell]] = [[]]
    let padding: CGFloat = 5
    
    @State var seletect: (Int, Int)? = nil
    
    @State private var columnWidths: [Int: CGFloat] = [:]
    
    func seletecedBorder(row: Int, column: Int) -> Color {
        guard let s = self.seletect else {
            return .clear
        }
        if s.0 == row && s.1 == column  {
            return .blue
        }
        return .clear
    }
    
    var body: some View {
        VStack {
            ForEach.init(cells.indices) { idx in
                HStack {
                    ForEach.init(self.cells[idx].indices) { index in
                        
                        Button.init {
                            print("cell row : \(idx), column : \(index) ")
                            self.seletect = (idx, index)
                        } label: {
                            self.cells[idx][index]
                                .background(GeometryReader { proxy in
                                    /// 使用几何读取器读取cell size，并通过key传递给父视图
                                    Color.clear.preference(key: CellMaxWidthKey.self, value: [index: proxy.size.width])
                                })
                                .frame(width: columnWidths[index], alignment: .leading)
                                .padding(padding)
                                .border(self.seletecedBorder(row: idx, column: index), width: 3)
                                
                        }
                    }
                }
            }
        }.onPreferenceChange(CellMaxWidthKey.self) {
            /// 监听每个cell的宽度
            self.columnWidths = $0
        }
    }
}

struct CustomTabView: View {
    
    var cells = [[Text(""), Text("Monday").bold(), Text("Tuesday").bold(), Text("Wednesday").bold()],
                 [Text("Berlin").bold(), Text("Cloudy"), Text("Mostly\nSunny"), Text("Sunny")],
                 [Text("London").bold(), Text("Heavy Rain"), Text("Cloudy"), Text("Sunny")]
    ]
    
    var body: some View {
        TableView.init(cells: cells)
    }
}

struct GeometryLayout: View {
    var body: some View {
        CustomTabView()
        CustomView()
        GeometryStart()
            .frame(width: 100, height: 100, alignment: .top)
        TextWithCircle()
        BoundsContentView()
            .border(Color.gray)
    }
}

struct GeometryLayout_Previews: PreviewProvider {
    static var previews: some View {
        GeometryLayout()
    }
}
