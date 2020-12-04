//
//  CustomObservedObject.swift
//  SwiftUIExercise
//
//  Created by ydd on 2020/10/21.
//  Copyright © 2020 ydd. All rights reserved.
//

import SwiftUI
import Combine

final class CurrentTime: ObservableObject {
    @Published var now: Date = Date()
    let interval: TimeInterval = 1
    private var timer: Timer? = nil
    
    func start() {
        guard timer == nil else {
            return
        }
        now = Date()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { [weak self] _ in
            self?.now = Date()
        })
    }
    
    func stop() {
        guard timer != nil else {
            return
        }
        timer?.invalidate()
        timer = nil
    }
    
    deinit {
        print("CurrentTime deinit")
    }
}

struct TimerView: View {
    @ObservedObject var date = CurrentTime()
    
    var body: some View {
        Text("\(date.now)")
            .onAppear{
                self.date.start()
            }
            .onDisappear {
                self.date.stop()
            }
            
    }
}


struct CustomObservedObject: View {
    var body: some View {
        TimerView()
    }
}

struct CustomObservedObject_Previews: PreviewProvider {
    static var previews: some View {
        CustomObservedObject()
    }
}
