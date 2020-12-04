//
//  JumpView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/9/27.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

struct TargetView: View {
    /// 通过NavigationLink跳转到子级页面的视图可以通过回退按钮返回父视图，Sheet窗口可以通过下滑实现返回父视图
    /// 除此以外还可通过环境变量presentationMode来手动返回父页面，对于NavigationLink和Sheet都适用
    @Environment(\.presentationMode) var mode
    
    var des = ""
    var body: some View {
        VStack {
            Text(des)
            Button.init {
                self.mode.wrappedValue.dismiss()
            } label: {
                Text("退出")
            }

        }
        
    }
}

struct JumpView: View {
    /// 使用 NavigationLink isActive 跳转
    @State var isActive = false
    @State var isModal = false
    @State var isPopOver = false
    
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 20, content: {
            NavigationLink.init(destination: TargetView(des: "NavigationLink")) {
                Text("NavigationLink 跳转")
            }.navigationBarTitle("跳转方法测试", displayMode: .large)
            
            NavigationLink.init(destination: TargetView(des: "NavigationLink isActive"), isActive: $isActive) {
                Text("跳转")
            }
            
            Button.init("自动跳转") {
                self.isActive = !self.isActive
                print("isActive: \(self.isActive)")
            }
            
            Button("Modal 跳转") {
                self.isModal = !self.isModal
                print("isModal: \(self.isModal)")
            }
            .sheet(isPresented: $isModal) {
                print("isPresented: \(self.isModal)")
            } content: {
                TargetView(des: "Modal 跳转")
            }

            
            Button("PopOver 跳转") {
            
                self.isPopOver = !self.isPopOver
                print("isPopOver: \(self.isPopOver)")
            }
            .popover(isPresented: $isPopOver, content: {
                TargetView.init(des: "PopOver 跳转")
            })
            
            Spacer()
        })
    }
}

struct JumpView_Previews: PreviewProvider {
    static var previews: some View {
        JumpView()
    }
}
