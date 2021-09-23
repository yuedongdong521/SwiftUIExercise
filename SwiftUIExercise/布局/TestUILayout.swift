//
//  TestUILayout.swift
//  SwiftUIExercise
//
//  Created by ydd on 2021/9/14.
//  Copyright © 2021 ydd. All rights reserved.
//

import SwiftUI

struct CallBtn: View {
    var icon = ""
    var title = ""
    var body: some View {
        VStack {
            Spacer()
            Image(icon)
            Spacer(minLength: 8)
            Text(title)
                .multilineTextAlignment(.center)
                .font(Font.system(size: 14))
                .foregroundColor(.green)
            Spacer()
        }
    }
}


struct TestUILayout: View {
    
    @Environment(\.presentationMode) var mode
    
    var userName: String = "景甜"
    @State var connected: Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Spacer(minLength: RelativeHeight(120))
            
            VStack {
                HStack {
                    Spacer()
                    Image("0")
                        .resizable()
                        .frame(width: 110, height: 110, alignment: .center)
                        .cornerRadius(55)
                        .aspectRatio(contentMode: .fill)
                    Spacer()
                }
                Spacer(minLength: 12)
                Text(userName)
                    .font(Font.system(size: 18))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer(minLength: 6)
                Text(connectTipStr())
                    .font(Font.system(size: 14))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }.frame(width: ScreenWidth, height: 173, alignment: .top)
            
            Spacer()
            HStack {
                Spacer()
                CallBtn(icon: "chat_call_small_icon_gauduan", title: "挂断")
                    .frame(width: 80, height: 82, alignment: .center)
                    .onTapGesture {
                        print("挂断")
                        self.mode.wrappedValue.dismiss()
                    }
                Spacer()
                CallBtn(icon: "chat_call_small_icon_jieting", title: "接听")
                    .frame(width: 80, height: 82, alignment: .center)
                    .onTapGesture {
                        print("接听")
                        self.connected = !self.connected
                    }
                Spacer()
            }
            Spacer(minLength: 40 + SafeAreaBottom)
            
            
        }.background(Color(red: 21.0 / 255, green: 20.0 / 255, blue: 22.0 / 255), alignment: .center)
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            guard let rootVC = UIApplication.shared.windows[0].rootViewController as? CustomRootViewController else {
                return
            }
            rootVC.statusBarStyle = .lightContent
            
        }
        .onDisappear {
            guard let rootVC = UIApplication.shared.windows[0].rootViewController as? CustomRootViewController else {
                return
            }
            rootVC.statusBarStyle = .default
            
        }
    }
    
    private func connectTipStr() -> String {
        return connected ? "已接听" : "正在等待对方接听…"
    }
    
}

struct TestUILayout_Previews: PreviewProvider {
    static var previews: some View {
        TestUILayout()
    }
}
