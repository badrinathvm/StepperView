//
//  ViewController.swift
//  StepperView
//
//  Created by badrinathvm on 04/04/2020.
//  Copyright (c) 2020 badrinathvm. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 13.0, *) {
            let stepperView = UIHostingController(rootView: ExampleView())
            stepperView.view.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(stepperView.view)
            
            NSLayoutConstraint.activate([
                stepperView.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
                stepperView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                stepperView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                stepperView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        } else {
            // Fallback on earlier versions
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
