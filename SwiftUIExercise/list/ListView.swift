//
//  ListView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/9/25.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

struct SubView : View {
    var content = ""
    var body: some View {
        if #available(iOS 14.0, *) {
            Text(content)
                .navigationBarTitle(content, displayMode: .inline)
        } else {
            // Fallback on earlier versions
            Text(content)
                .navigationBarTitle(content)
                
        }
    }
}

struct ItemModel : Identifiable, Hashable {
    let id = UUID()
    var name:String
}

struct RowView : View {
    var item :ItemModel
    var body: some View {
        Text(item.name)
    }
}

func createDate(_ count:Int) -> [ItemModel] {
    var arr :[ItemModel] = []
    for i in 0..<count {
        arr.append(ItemModel.init(name: "测试：\(i)"))
    }
    return arr
}


struct ListView: View {
    /// @State 修饰可变状态量，当数据改变是刷新UI
    
    @State var rows :[ItemModel] = []
    
    var body: some View {
        List.init() {
            ForEach.init(rows, id: \.self) { (item)  in
                NavigationLink.init(destination: SubView(content: item.name)) {
                    RowView.init(item: item)
                }.statusBar(hidden: true)
                
            }.onDelete(perform: deletedRow(at:))
        }
        .navigationBarItems(trailing: Button(action: {
            insertRow(at: 2)
            
        }, label: {
            Text("add")
        }))
        .navigationBarTitle("list 测试", displayMode: .inline)
        
        
    }
    
    func deletedRow(at index: IndexSet) {
        rows.remove(atOffsets: index)
    }
    
    func insertRow(at index:Int) {
        rows.insert(ItemModel.init(name: "插入测试 ： \(index)"), at: index)
    }
    
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(rows: [ItemModel(name: "测试")])
    }
}


