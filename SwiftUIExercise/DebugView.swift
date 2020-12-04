//
//  DebugView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/9/25.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

extension View {
    
    func debug_des(_ msg: String = "", fileName file: String = #file, fucName fuc: String = #function, lineNum line: Int = #line) -> Self {
        let date = Date()
        let fileNames = file.components(separatedBy: CharacterSet.init(charactersIn: "/"))
        let fileStr = fileNames.last ?? file
        let str = "\(date) " + fileStr + " " +  fuc + " \(line) :" + msg + "\n des: \(self)"
        print(str)
        return self
    }
    
    func debug(_ msg: String = "", fileName file: String = #file, fucName fuc: String = #function, lineNum line: Int = #line) -> Self {
        let date = Date()
        let fileNames = file.components(separatedBy: CharacterSet.init(charactersIn: "/"))
        let fileStr = fileNames.last ?? file
        let str = "\(date) " + fileStr + " " +  fuc + " \(line) :\n    " + msg
        print(str)
        return self
    }
}


