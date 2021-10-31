//
//  ChildCoordinatorProtocol.swift
//  SnoKE
//
//  Created by Ilya Buldin on 28.10.2021.
//

import UIKit


protocol ChildCoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}
