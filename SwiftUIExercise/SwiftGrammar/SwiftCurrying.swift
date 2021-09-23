//
//  SwiftCurrying.swift
//  SwiftUIExercise
//
//  Created by ydd on 2021/9/22.
//  Copyright © 2021 ydd. All rights reserved.
//

import SwiftUI

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>: TargetAction {
    weak var target: T?
    
    let action: (T) -> () -> ()
    
    func performAction() {
        if let t = target {
            action(t)()
        }
    }
}

enum ControlEvent {
    case TouchUpInside
}

class Control {
    var actions = [ControlEvent: TargetAction]()
    func setTarget<T: AnyObject>(target: T, action: @escaping (T) -> () -> (), controlEvent: ControlEvent) {
        actions[controlEvent] = TargetActionWrapper(target: target, action: action)
    }
    func removeTargetForControllEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }
    
    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}


struct SwiftCurrying: View {
    var body: some View {
        Text("Currying 柯里化，将相同的操作作为一个闭包返回").onTapGesture {
            addFunc()
        }
        Text("实现两个数相加的一类函数")
    }
    
    func addFunc() {
        let addTree = addTo(3)
        debug("加三：\(addTree(1)), \(addTree(2))")
    }
    
    /// 将相同的操作作为一个闭包返回，
    func addTo(_ a: Int) -> (Int)->Int {
        return { item in
            return item + a
        }
    }
    /// 返回与a比较大小的函数
    func greaterThan(_ a: Int) -> (Int)->Bool {
        return { item in
            return item > a
        }
    }
    
    
    
    
}

struct SwiftCurrying_Previews: PreviewProvider {
    static var previews: some View {
        SwiftCurrying()
    }
}
