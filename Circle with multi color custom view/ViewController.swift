//
//  ViewController.swift
//  Circle with multi color custom view
//
//  Created by Pooyan J on 2/9/1403 AP.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var circleView: MultiCircularProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progresses = [
            MultiCircularProgressView.Config.Progress(total: 60, remain: 45, color: .systemPink),  // internal internet
            MultiCircularProgressView.Config.Progress(total: 30, remain: 10, color: .systemMint), // normal internet
            MultiCircularProgressView.Config.Progress(total: 15, remain: 5, color: .orange)  // internal internet
        ]
        let config = MultiCircularProgressView.Config(progresses: progresses)
        circleView.setup(config: config)
    }
}
