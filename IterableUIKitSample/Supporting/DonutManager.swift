//
//  DonutManager.swift
//  IterableUIKitSample
//
//  Created by Christina Schell on 7/8/21.
//

import UIKit

enum DonutType: String {
    //https://schellyapps.com/products/[donut].html
    case oldfashioned, glazed, icedsprinkles, maplebar, jelly, applefritter, all
    
    init(from url: URL) {
        switch true {
        case url.absoluteString.contains("oldfashioned"):
            self = .oldfashioned
        case url.absoluteString.contains("glazed"):
            self = .glazed
        case url.absoluteString.contains("icedsprinkles"):
            self = .icedsprinkles
        case url.absoluteString.contains("maplebar"):
            self = .maplebar
        case url.absoluteString.contains("jelly"):
            self = .jelly
        case url.absoluteString.contains("applefritter"):
            self = .applefritter
        default:
            self = .all
        }
    }
    
}

struct DonutManager {
    
    static var donuts: [Donut] {
        Bundle.main.decode([Donut].self, from: "donuts.json")
    }
    
    @discardableResult
    static func handle(_ url: URL) -> Bool {
        show(detail: DonutType(from: url))
        return true
    }
    
    private static func show(detail: DonutType) {
        
        guard detail != .all else {
            let donutListViewController = DonutListViewController()
            if let rootNav = UIApplication.shared.delegate?.window??.rootViewController as? UINavigationController {
                rootNav.popToRootViewController(animated: false)
                rootNav.pushViewController(donutListViewController, animated: true)
            }
            return
        }
        
        guard let delegate = UIApplication.shared.delegate,
           let window = delegate.window,
           let tabBarController = window?.rootViewController as? UITabBarController,
           var rootNav = tabBarController.viewControllers?.first as? UINavigationController else {
            return
        }
        
        if let inAppNav = tabBarController.viewControllers?.last as? MobileInboxViewController {
            rootNav = inAppNav
        }
        
        if let donutViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "DonutDetailViewController") as? DonutDetailViewController {
            donutViewController.donut = donuts.first { $0.image == detail.rawValue }
            rootNav.popToRootViewController(animated: false)
            rootNav.pushViewController(donutViewController, animated: true)
        }

    }
    
    
}

