//
//  WalkthroughControllerDataSource.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import Foundation

protocol WalkthroughControllerDataSource: NSObjectProtocol {
    
    func numberOfWalkthroughPopups(for walkthroughController: WalkthroughController) -> Int
    func walkthroughPopup(for walkthroughController: WalkthroughController, at index: Int) -> WalkthroughPopup
}
