//
//  UIViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 12.12.2021.
//

import UIKit

extension UIViewController {
    public func getNavBarHeightAndWidth() -> (height: CGFloat, width: CGFloat) {
        var width: CGFloat
        var height: CGFloat
        if let navigationBar = navigationController?.navigationBar {
            height = navigationBar.frame.size.height
            width = navigationBar.frame.size.width
        } else {
            width = 414
            height = 90
        }
        
        return (height, width)
    }
}
