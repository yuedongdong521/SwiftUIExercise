//
//  Environment_test2.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/10/26.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI


class DatabaseConnection: ObservableObject {
    var value: Int = 0
    var isConnect = false
}

struct MyView: View {
    
    @Binding var count: Int
    /// 使用环境变量传值
    @EnvironmentObject var connection: DatabaseConnection
    
    var body: some View {
        VStack {
            if count % 2 == 1 {
                Text("Connected")
            } else {
                Text("disconnected")
            }
        }
        .debug("connection : \(connection.isConnect)")
    }
}

struct Environment_Object: View {
    @State var connection = DatabaseConnection()
    
    @State var count: Int = 0
    
    var body: some View {
        NavigationView {
            MyView(count: $count)
                .onTapGesture {
                    self.count += 1
                    if self.count % 2 == 1 {
                        self.connection.isConnect = true
                    } else {
                        self.connection.isConnect = false
                    }
                    
                }
                .background(Color.red)
        }
        .environmentObject(connection)
    }
}

struct Environment_Object_Previews: PreviewProvider {
    static var previews: some View {
        Environment_Object()
    }
}
