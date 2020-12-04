//
//  ViewLayout.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/10/27.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

struct MeasureBehavior<Content: View>: View {
    @State private var width: CGFloat = 100
    @State private var height: CGFloat = 100
    
    var content: Content
    
    var body: some View {
        VStack {
            content
                .background(Color.gray)
                .border(Color.gray)
                .frame(width: width, height: height, alignment: .topLeading)
                .border(Color.black)
                .background(Color.red)
            Slider(value: $width, in: 0...200)
            Slider(value: $height, in: 0...200)
        }
    }
    
}

struct ViewLayout: View {
    var body: some View {
        MeasureBehavior(content: Text("ViewLayout"))
    }
}

struct ViewLayout_Previews: PreviewProvider {
    static var previews: some View {
        ViewLayout()
    }
}
