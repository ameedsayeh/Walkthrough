//
//  TestViewController.swift
//  Walkthrough
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    let tourController = WalkthroughController(with: WalkthroughConfigurations(forwardTouchEvents: true))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tourController.delegate = self
        self.tourController.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tourController.start(on: UIApplication.shared.windows.first!)
    }
}

extension TestViewController: WalkthroughControllerDelegate, WalkthroughControllerDataSource {
    
    func walkthroughPopup(for walkthroughController: WalkthroughController, at index: Int) -> WalkthroughPopup {
        
        return WalkthroughPopup(targetComponent: self.button, cornerRounding: .fullyRounded)
    }
    
    func numberOfWalkthroughPopups(for walkthroughController: WalkthroughController) -> Int {
        return 1
    }
}
