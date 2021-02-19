//
//  WalkthroughController.swift
//
//  Created by Ameed Sayeh on 19/02/2021.
//

import UIKit

final class WalkthroughController {
    
    weak var delegate: WalkthroughControllerDelegate?
    weak var dataSource: WalkthroughControllerDataSource?
    
    private(set) var configurations: WalkthroughConfigurations
    
    init() {
        self.configurations = WalkthroughConfigurations()
    }
    
    init(with configurations: WalkthroughConfigurations) {
        self.configurations = configurations
    }
    
    public func start(on window: UIWindow) {
    }
    
    public func stop() {
    }
}
