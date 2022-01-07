//
//  ViewController.swift
//  PulseAnimationExample
//
//  Created by Nishant Taneja on 07/01/22.
//

import UIKit
import PulseAnimation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let pulseAnimationView = PulseAnimationView()
        view = pulseAnimationView
    }

}

