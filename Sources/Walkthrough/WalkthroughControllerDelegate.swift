//
//  WalkthroughControllerDelegate.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import UIKit

public protocol WalkthroughControllerDelegate: AnyObject {
    
    func walkthroughController(_ walkthroughController: WalkthroughController,
                               shouldShowPopUpAt index: Int) -> Bool

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               willLayoutPopUpAt index: Int,
                               inside containerView: UIView,
                               forPunchIn bounds: CGRect,
                               position: WalkthroughPopUp.BodyViewPosition)

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               willShowPopUpAt index: Int)
    
    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didShowPopUpAt index: Int)
    
    func walkthroughController(_ walkthroughController: WalkthroughController,
                               willHidePopUpAt index: Int)
    
    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didHidePopUpAt index: Int)
    
    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didTapInsidePunchForPopUpAt index: Int)

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didLongPressInsidePunchForPopUpAt index: Int)
    
    func walkthroughControllerDidFinishFlow(_ walkthroughController: WalkthroughController,
                                            forceStop: Bool)
}

// MARK: Default implementation
public extension WalkthroughControllerDelegate {
    
    func walkthroughController(_ walkthroughController: WalkthroughController,
                               shouldShowPopUpAt index: Int) -> Bool { true }

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               willLayoutPopUpAt index: Int,
                               inside containerView: UIView,
                               forPunchIn bounds: CGRect,
                               position: WalkthroughPopUp.BodyViewPosition) {}

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               willShowPopUpAt index: Int) {}
    
    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didShowPopUpAt index: Int) {}
    
    func walkthroughController(_ walkthroughController: WalkthroughController,
                               willHidePopUpAt index: Int) {}
    
    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didHidePopUpAt index: Int) {}
    
    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didTapInsidePunchForPopUpAt index: Int) {}

    func walkthroughController(_ walkthroughController: WalkthroughController,
                               didLongPressInsidePunchForPopUpAt index: Int) {}
    
    func walkthroughControllerDidFinishFlow(_ walkthroughController: WalkthroughController,
                                            forceStop: Bool) {}
}
