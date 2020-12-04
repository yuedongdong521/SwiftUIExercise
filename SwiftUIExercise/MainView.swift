//
//  MainView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/9/25.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    var title = ""
    var des = ""
    var tapAction: (() -> Void)?
    
    var body: some View {
        HStack(alignment: .center , spacing: 10, content: {
            Text(title)
            Text(des)
            Spacer()
        }).onTapGesture {
            print("123444")
            if let tap = self.tapAction {
                tap()
            }
        }
    }
}


struct MineModel {
    var title = ""
    var content = ""
    var des = ""
    var type:ItemEnum = .def
    
    func itemView() -> ItemView {
        return ItemView(title: title, des: des, tapAction: nil)
    }
}

enum ItemEnum: Int {
    case def, ContentView, ListView, JumpView, RefreshView, CustomObservedObject, PhototsObservedObj, Environment_Values, Environment_Object, Preferences_Test, ViewLayout, Path_ShapeLayout, Stack_Layout, ViewLayoutGroup, AnimationView, WithAnimation
    
    func mineModel() -> MineModel {
        switch self {
        case .ContentView:
            return MineModel(title: "添加计数状态", content: "技术属性", des: "", type: self)
        case .ListView:
            return MineModel(title: "列表View", content: "listView", des: "", type: self)
        case .JumpView:
            return MineModel(title: "跳转方法", content: "跳转方法", des: "", type: self)
        case .RefreshView:
            return MineModel(title: "更新View", content: "state", des: "", type: self)
        case .CustomObservedObject:
            return MineModel(title: "自定义模型对象", content: "CustomObservedObject", des: "", type: self)
        case .PhototsObservedObj:
            return MineModel(title: "PhototsObservedObj", content: "图片加载展示", des: "", type: self)
        case .Environment_Values:
            return MineModel(title: "Environment_Values", content: "环境变量", des: "", type: self)
        case .Environment_Object:
            return MineModel(title: "Environment_Object", content: "环境变量依赖", des: "", type: self)
        case .Preferences_Test:
            return MineModel(title: "Preferences_Test", content: "子视图向父视图数传值", des: "", type: self)
        case .ViewLayout:
            return MineModel(title: "ViewLayout", content: "view布局", des: "", type: self)
        case .Path_ShapeLayout:
            return MineModel(title: "Path_ShapeLayout", content: "Path——Shape布局", des: "", type: self)
        case .Stack_Layout:
            return MineModel(title: "Stack_Layout", content: "Stack布局", des: "", type: self)
        case .ViewLayoutGroup:
            return MineModel(title: "ViewLayoutGroup", content: "View组织布局代码", des: "", type: self)
        case .AnimationView:
            return MineModel(title: "AnimationView", content: "View隐式动画", des: "", type: self)
        case .WithAnimation:
            return MineModel(title: "WithAnimation", content: "View显示动画", des: "", type: self)
        default:
            return MineModel()
        }
    }
}

struct MainView: View {
    
    @State var items:[ItemEnum] = [.ContentView, .ListView, .JumpView, .RefreshView, .CustomObservedObject, .PhototsObservedObj, .Environment_Values, .Environment_Object, .Preferences_Test, .ViewLayout, .Path_ShapeLayout, .Stack_Layout, .ViewLayoutGroup, .AnimationView, .WithAnimation]
    
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach.init(items, id: \.self) { item in
                    let model = item.mineModel()
                    cellForItem(model: model)
                }
                
            }.background(Color.gray)
            .listStyle(GroupedListStyle())
            .navigationBarTitle("main", displayMode: .automatic)
            
        }.background(Color.black)
        
    }
    
    func cellForItem(model: MineModel) -> some View {
        
        Section.init(header: Text(model.title)) {
            NavigationLink.init(destination: createItemView(model: model)) {
                model.itemView()
            }
        }
        
    }
    
    func createItemView(model: MineModel) -> AnyView {
        switch model.type {
        case .ContentView:
            return AnyView(ContentView())
        case .ListView:
            return AnyView(ListView(rows: createDate(20)))
        case .JumpView:
            return AnyView(JumpView())
        case .RefreshView:
            return AnyView(RefreshView())
        case .CustomObservedObject:
            return AnyView(CustomObservedObject())
        case .PhototsObservedObj:
            return AnyView(PhototsObservedObj())
        case .Environment_Values:
            return AnyView(Environment_Values())
        case .Environment_Object:
            return AnyView(Environment_Object())
        case .Preferences_Test:
            return AnyView(Preferences_Test())
        case .ViewLayout:
            return AnyView(ViewLayout())
        case .Path_ShapeLayout:
            return AnyView(Path_ShapeLayout())
        case .Stack_Layout:
            return AnyView(Stack_Layout())
        case .ViewLayoutGroup:
            return AnyView(ViewLayoutGroup())
        case .AnimationView:
            return AnyView(AnimationView())
        case .WithAnimation:
            return AnyView(WithAnimation())
        default:
            return AnyView(Text("default"))
        }
    }

   
    
    func testKeySome() -> some View {
        /// 关键在some修饰不透明类型View， 例如：返回类型可以是Text / Image/ List/...
        return Text("some")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
