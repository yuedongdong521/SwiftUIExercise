//
//  SwiftGrammarView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2021/9/22.
//  Copyright © 2021 ydd. All rights reserved.
//

import SwiftUI

enum GrammarEnum {
    case Currying, Sequence
    
    func des() -> String {
        switch self {
        case .Currying:
            return "柯里化"
        case .Sequence:
            return "序列"
        }
    }
    
    func subView() -> AnyView {
        switch self {
        case .Currying:
            return AnyView(SwiftCurrying())
        case .Sequence:
            return AnyView(SwiftSequenceView())
        }
    }
}

struct SwiftGrammarView: View {
    
    @State var items: [GrammarEnum] = [.Currying, .Sequence]
    
    var body: some View {
        List() {
            ForEach.init(items, id: \.self) { (item) in
                
                NavigationLink.init(destination: item.subView()) {
                    Text(item.des())
                }
            }
        }
        Text("hello world")

    }
}

struct SwiftGrammarView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftGrammarView()
    }
}

