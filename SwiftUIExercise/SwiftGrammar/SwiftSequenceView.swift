//
//  SwiftSequenceView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2021/9/22.
//  Copyright © 2021 ydd. All rights reserved.
//

import SwiftUI

class Reverselterator<T>: IteratorProtocol {
    
    typealias Element = T
    var array: [Element]
    var currentIndex = 0
    init(array: [Element]) {
        self.array = array
        currentIndex = array.count - 1
    }
    
    func next() -> Element? {
        if currentIndex < 0 {
            return nil
        } else {
            let element = array[currentIndex]
            currentIndex -= 1
            return element
        }
    }
    
}

struct ReverseSequence<T>: Sequence {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    typealias Iterator = Reverselterator<T>
    
    func makeIterator() -> Reverselterator<T> {
        return Reverselterator(array: self.array)
    }
}

extension Sequence {
    
}


struct SwiftSequenceView: View {
    var body: some View {
        Text("Sequence 倒序遍历").onTapGesture {
            reverseSquenceArr()
            makeIteratorArr()
        }
    }
    
    func reverseSquenceArr() {
        let arr = [0, 1, 2, 3, 4, 5, 6]
        for i in ReverseSequence(array: arr) {
            debug("Index \(i) is \(arr[i])")
        }
    }
    
    func makeIteratorArr() {
        let arr = [0, 1, 2, 3, 4, 5, 6]

        var iterator = arr.makeIterator()
        while let obj = iterator.next() {
            debug("obj : \(obj)")
        }
    }
}

struct SwiftSequenceView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftSequenceView()
    }
}
