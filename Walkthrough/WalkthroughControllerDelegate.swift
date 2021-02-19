//
//  WalkthroughControllerDelegate.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import Foundation

protocol WalkthroughControllerDelegate: NSObjectProtocol {
    
    func walkthroughController(for walkthroughController: WalkthroughController, shouldShow popup: WalkthroughPopup, at index: Int) -> Bool
    func walkthroughController(for walkthroughController: WalkthroughController, willShow popup: WalkthroughPopup, at index: Int) -> Void
    func walkthroughController(for walkthroughController: WalkthroughController, didShow popup: WalkthroughPopup, at index: Int) -> Void
    func walkthroughController(for walkthroughController: WalkthroughController, didSkip popup: WalkthroughPopup, at index: Int) -> Void
    func walkthroughController(for walkthroughController: WalkthroughController, didContinue popup: WalkthroughPopup, at index: Int) -> Void
    func didFinishWalkthrough(for walkthroughController: WalkthroughController, skipped: Bool) -> Void
}

extension WalkthroughControllerDelegate {
    
    func walkthroughController(for walkthroughController: WalkthroughController, shouldShow popup: WalkthroughPopup, at index: Int) -> Bool {
        return true
    }
    
    func walkthroughController(for walkthroughController: WalkthroughController, willShow popup: WalkthroughPopup, at index: Int) -> Void {
        return
    }
    
    func walkthroughController(for walkthroughController: WalkthroughController, didShow popup: WalkthroughPopup, at index: Int) -> Void {
        return
    }
    
    func walkthroughController(for walkthroughController: WalkthroughController, didSkip popup: WalkthroughPopup, at index: Int) -> Void {
        return
    }
    
    func walkthroughController(for walkthroughController: WalkthroughController, didContinue popup: WalkthroughPopup, at index: Int) -> Void {
        return
    }
    
    func didFinishWalkthrough(for walkthroughController: WalkthroughController, skipped: Bool) -> Void {
        return
    }
}
