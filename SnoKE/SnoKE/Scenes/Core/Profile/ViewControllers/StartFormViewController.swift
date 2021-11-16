//
//  HzViewController.swift
//  SnoKE
//
//  Created by Денис Харке on 14.11.2021.
//

import UIKit

class StartFormViewController: UIViewController {
    
    let startFormView = StartFormView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(startFormView)
        startFormView.frame = view.frame
    }
}
