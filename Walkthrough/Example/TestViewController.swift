//
//  TestViewController.swift
//  Walkthrough
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    
    lazy var tourController = WalkthroughController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tourController.delegate = self
        self.tourController.dataSource = self
    }

    @IBAction func didTapClickMe() {
        self.tourController.start(on: self.view.window!)
    }
}

extension TestViewController: WalkthroughControllerDataSource {

    func numberOfWalkthroughPopups(for walkthroughController: WalkthroughController) -> Int {
        5
    }

    func walkthroughPopUp(for walkthroughController: WalkthroughController, at index: Int) -> WalkthroughPopUp? {

        let view = UIView(frame: self.view.bounds)

        view.backgroundColor = UIColor(red: CGFloat.random(in: 0...1),
                                       green:  CGFloat.random(in: 0...1),
                                       blue:  CGFloat.random(in: 0...1),
                                       alpha: 0.4)

        return WalkthroughPopUp(targetComponent: self.button, bodyView: view, cornerRounding: .fullyRounded)
    }
}

extension TestViewController: WalkthroughControllerDelegate {

    func walkthroughController(_ walkthroughController: WalkthroughController, willShowPopUpAt index: Int) {
        print("Pop up at index \(index) will be shown")
    }

    func walkthroughController(_ walkthroughController: WalkthroughController, didShowPopUpAt index: Int) {
        print("Pop up at index \(index) was shown")
    }

    func walkthroughController(_ walkthroughController: WalkthroughController, willHidePopUpAt index: Int) {
        print("Pop up at index \(index) will be hidden")
    }

    func walkthroughController(_ walkthroughController: WalkthroughController, didHidePopUpAt index: Int) {
        print("Pop up at index \(index) was hidden")
    }

    func walkthroughControllerDidFinishFlow(_ walkthroughController: WalkthroughController, forceStop: Bool) {
        print("Did finish")
    }

    func walkthroughController(_ walkthroughController: WalkthroughController, didTapInsidePunchForPopUpAt index: Int) {
        print("Did tap inside the punch")
    }
}
