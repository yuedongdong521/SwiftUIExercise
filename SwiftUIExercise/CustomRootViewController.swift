//
//  CustomRootViewController.swift
//  SwiftUIExercise
//
//  Created by ydd on 2021/9/15.
//  Copyright © 2021 ydd. All rights reserved.
//

import Foundation
import SwiftUI

class CustomRootViewController: UIHostingController<AnyView> {
    
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    @objc override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
}
