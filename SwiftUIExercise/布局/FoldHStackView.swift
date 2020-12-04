//
//  FoldHStackView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/11/2.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

extension View {
    
    func addBadge(count: Int) -> some View {
        
        overlay(
            ZStack {
                if count != 0 {
                    Circle()
                        .fill(Color.red)
                    Text("\(count)")
                        .foregroundColor(.white)
                        .font(.caption)
                }
            }.offset(x: 25, y: -12)
            .frame(width: 24, height: 24, alignment: .topTrailing)
        )
    }
    
}

struct Collapsible<Element, Content: View>: View {
    
    var data: [Element]
    
    var expanded: Bool = false
    var spacing: CGFloat? = 8
    var alignment: VerticalAlignment = .center
    var collapsedWidth: CGFloat = 20
    var content: (Element) -> Content
    
    func child(at index: Int) -> some View {
        let showExpanded = expanded || index == self.data.endIndex - 1
        return content(data[index])
            .frame(width: showExpanded ? nil : collapsedWidth, alignment: Alignment(horizontal: .leading, vertical: alignment))
    }
    
    var body: some View {
        HStack(alignment: alignment, spacing: expanded ? spacing : 0) {
            ForEach(data.indices, content: {self.child(at: $0)})
        }
    }
}

struct FoldHStackView: View {
    let colors: [(Color, CGFloat)] = [(.init(white: 0.3), 50), (.init(white: 0.8), 30), (.init(white: 0.5), 75)]
    @State var expanded: Bool = true
    var body: some View {
        VStack(spacing: 30) {
            HStack {
                Collapsible(data: colors, expanded: expanded) { (item: (Color, CGFloat)) in
                    Rectangle()
                        .fill(item.0)
                        .frame(width: item.1, height: item.1, alignment: .center)
                        
                }.border(Color.gray)
            }
            Button {
                withAnimation(.default) { self.expanded.toggle() }
            } label: {
                Text(self.expanded ? "Collapse" : "Expand")
            }
            
            Text("Hello").addBadge(count: 5)
                .background(Color.gray)
            
            GeometryReader { proxy in
                Rectangle()
                    .fill(Color.red)
                    .frame(width: proxy.size.width / 3, height: proxy.size.height / 3)
                
            }
        }
    }
}

struct FoldHStackView_Previews: PreviewProvider {
    static var previews: some View {
        FoldHStackView()
    }
}
