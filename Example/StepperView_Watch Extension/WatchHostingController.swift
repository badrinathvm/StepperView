//
//  InterfaceController.swift
//  StepperView_Watch Extension
//
//  Created by Venkatnarayansetty, Badarinath on 5/9/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import WatchKit
import Foundation
import StepperView
import SwiftUI

/// Hosting Controller to embed SwiftUI view
class WatchHostingController: WKHostingController<AnyView> {
    
    override var body: AnyView {
        /// Vertical StepperView
        return WatchExampleView1().eraseToAnyView()
        
        // Horizontal StepperView
        //return WatchExampleView2().eraseToAnyView()
        
        // Icon vertical StepperView
        //return WatchExampleView3().eraseToAnyView()
        
        // Pitstop StepperView
        //return WatchExampleView4().eraseToAnyView()
        
        // animated step indicator stepper view
        //return WatchExampleView5().eraseToAnyView()
    }
}
