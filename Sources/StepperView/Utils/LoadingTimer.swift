//
//  LoadingTimer.swift
//  Pods
//
//  Created by Venkatnarayansetty, Badarinath on 5/11/20.
//

import Foundation
import Combine

/// creates a publisher for loading time
class LoadingTimer {
    
    /// create a publisher
    var publisher:Timer.TimerPublisher?
    
    /// option to cancel varoable any time
    private var cancellable: Cancellable?
    
    ///initilazes `text` ,  `width`, `color` , `delay` and  `triggerAnimation`
    init(value: Double) {
        publisher = Timer.publish(every: value, on: .main, in: .default)
    }

    /// start the publisher
    func start() {
        self.cancellable = publisher?.connect()
    }

    /// cancel the publisher
    func cancel() {
        self.cancellable?.cancel()
    }
}
