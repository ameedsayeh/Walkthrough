//
//  WalkthroughControllerDataSource.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import Foundation

protocol WalkthroughControllerDataSource: NSObjectProtocol {
    
    func numberOfWalkthroughPopups(for walkthroughController: WalkthroughController) -> Int
    func walkthroughController(_ walkthroughController: WalkthroughController, walkthroughPopupAt index: Int) -> WalkthroughPopup
    func walkthroughPopups(at index: Int) -> WalkthroughPopup
    func numberOfWalkthroughPopups() -> Int
}
