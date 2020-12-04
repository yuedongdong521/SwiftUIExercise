//
//  LoadingView.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/10/23.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI

struct LoadingView: UIViewRepresentable {
    @Binding var isLoading: Bool
    var style = UIActivityIndicatorView.Style.medium
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityView = UIActivityIndicatorView.init(style: style)
        activityView.hidesWhenStopped = true
        return activityView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        isLoading ? uiView.startAnimating() : uiView.stopAnimating()
    }
    
    typealias UIViewType = UIActivityIndicatorView
    
   
}

struct LoadingView_Previews: PreviewProvider {
    
    static var previews: some View {
        LoadingView(isLoading: .constant(false))
    }
}
