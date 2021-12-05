//
//  WalkthroughControllerDelegate.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import Foundation

protocol WalkthroughControllerDelegate: AnyObject {

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               shouldShowPopUpAt index: Int) -> Bool

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               willShowPopUpAt index: Int)

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didShowPopUpAt index: Int)

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               willHidePopUpAt index: Int)

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didHidePopUpAt index: Int)

    func walkthroughControllerDidFinishFlow(_ walkthroughController: WalkthroughController,
                                            forceStop: Bool)
}

// MARK: Default implementation
extension WalkthroughControllerDelegate {

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               shouldShowPopUpAt index: Int) -> Bool { true }

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               willShowPopUpAt index: Int) {}

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didShowPopUpAt index: Int) {}

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               willHidePopUpAt index: Int) {}

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didHidePopUpAt index: Int) {}

    func walkthroughControllerDidFinishFlow(_ walkthroughController: WalkthroughController,
                                            forceStop: Bool) {}
}
