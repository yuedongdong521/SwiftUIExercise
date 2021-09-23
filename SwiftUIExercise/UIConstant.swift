//
//  UIConstant.swift
//  SwiftUIExercise
//
//  Created by ydd on 2021/9/15.
//  Copyright © 2021 ydd. All rights reserved.
//

import Foundation
import SwiftUI

let ScreenWidth = UIScreen.main.bounds.width

let ScreenHeight = UIScreen.main.bounds.height

let SafeAreaTop = UIApplication.shared.windows[0].safeAreaInsets.top
let SafeAreaBottom = UIApplication.shared.windows[0].safeAreaInsets.bottom

let NavBarHeight = 44 + SafeAreaTop

func RelativeWidth(_ width: CGFloat) -> CGFloat {
    
    return ScreenWidth / 375 * width
}

func RelativeHeight(_ height: CGFloat) -> CGFloat {
    return ScreenHeight / 667 * height
}
