//
//  WalkthroughControllerDataSource.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import Foundation

public protocol WalkthroughControllerDataSource: AnyObject {
    
    func numberOfWalkthroughPopups(for walkthroughController: WalkthroughController) -> Int

    func walkthroughPopUp(for walkthroughController: WalkthroughController,
                          at index: Int) -> WalkthroughPopUp?
}
