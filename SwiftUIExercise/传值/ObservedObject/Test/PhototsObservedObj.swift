//
//  PhototsObservedObj.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/10/22.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI
import Combine

struct LoadingError: Error {
    
}

struct Photo: Codable, Identifiable {
    var id: String = ""
    var author = ""
    var width:Int = 0
    var height:Int = 0
    var url = ""
    var download_url: URL {
        get {
            return URL.init(string: "http://img.17kuxiu.com/livingImg/defult_liveimg.png")!
        }
    }
    
    
}

/// final 可以修饰class、function、 var， 表示修饰的类不能被集成、重载
final class Remote<A>: ObservableObject {
    @Published var result: Result<A, Error>? = nil
    var value: A? {
        try? result?.get()
    }
    
    let url:URL
    let transform: (Data)->A?
    
    init(url: URL, transform: @escaping (Data)->A?) {
        self.url = url
        self.transform = transform
    }
    
    func load() {
        
        if let data = self.readData() {
            if let v = self.transform(data) {
                self.result = .success(v)
                return
            }
        }
        
        URLSession.shared.dataTask(with: URLRequest.init(url: self.url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 300)) { (data, _, _) in
            DispatchQueue.main.async {
                if let d = data, let v = self.transform(d) {
                    self.result = .success(v)
                    _ = self.cacheData(d)
                } else {
                    self.result = .failure(LoadingError())
                }
            }
        }.resume()
    }
    
    private func cacheData(_ data: Data) -> Bool {
        guard let cachePath = getCachePath() else {
            return false
        }
        let url = URL.init(fileURLWithPath: cachePath)
        do {
            try data.write(to: url)
            return true
        } catch {
            print("缓存数据失败:\(cachePath) \n \(url)")
            return false
        }
    }
    
    private func readData() -> Data? {
        guard let cachePath = getCachePath(), let url = URL.init(string: cachePath) else {
            return nil
        }
        do {
            return try Data(contentsOf: url)
        } catch {
            return nil
        }
        
    }
    
    private func getCachePath() -> String? {
        let direPath = NSTemporaryDirectory() + "/URLCache";
        var isDire = ObjCBool.init(false)
        let isExis = FileManager.default.fileExists(atPath: direPath, isDirectory: &isDire)
        if !isDire.boolValue || !isExis  {
            do {
                try FileManager.default.createDirectory(atPath: direPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("URLCache缓存文件夹创建失败")
                return nil
            }
        }
        return direPath + "/\(self.url.hashValue)"
    }
    
}

struct PhotoView: View {
    @ObservedObject var image: Remote<UIImage>
    @State var isLoading: Bool = false
    
    init(_ url: URL) {
        image = Remote(url: url, transform: { UIImage(data: $0)})
    }
    
    var body: some View {
        Group {
            if image.value == nil {
                LoadingView(isLoading: $isLoading)
                    .onAppear {
                        self.isLoading = true
                        self.image.load()
                    }
            } else {
                Image(uiImage: image.value!)
                    .resizable()
                    .aspectRatio(image.value!.size, contentMode: .fit)
                
            }
        }
    }
    
}

struct PhotoItemView: View {
    var photo:Photo
    var body: some View {
        HStack {
            PhotoView.init(photo.download_url)
            Text(photo.author)
        }
    }
}




struct PhototsObservedObj: View {
    @State var isLoading: Bool = true
    
    @ObservedObject var itemss = Remote(url: URL.init(string: "https://picsum.photos/v2/list")!, transform: {try? JSONDecoder().decode([Photo].self, from: $0)})
    @ObservedObject var items = Remote.init(url: URL.init(string: "https://picsum.photos/v2/list")!) { (data) -> [Photo]? in
//        return try? JSONDecoder().decode([Photo].self, from: data)
        print("数据加载完成 ： \(String(describing: String(data: data, encoding: .utf8)))")
        do {
            let photo = try JSONDecoder().decode([Photo].self, from: data)
            return photo
        } catch {
            print("photo 解析失败")
            return nil
        }
    }
    
    
    
    var body: some View {
        
        if items.value == nil {
            LoadingView(isLoading: $isLoading)
                .onAppear {
                    self.isLoading = true
                    self.items.load()
                }.onDisappear {
                    self.isLoading = false
                }
            
        } else {
            
            List {
                ForEach(items.value!) { photo in
                    NavigationLink(destination: PhotoView(photo.download_url)) {
                        PhotoItemView(photo: photo)
                            .frame(height: 60, alignment: .center)
                    }
                }
            }.listStyle(PlainListStyle())
            .navigationBarTitle("Loading Photo", displayMode: .inline)
        }
    }
}

struct PhototsObservedObj_Previews: PreviewProvider {
    static var previews: some View {
        PhototsObservedObj()
    }
}
