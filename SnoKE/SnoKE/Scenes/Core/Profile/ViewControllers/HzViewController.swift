//
//  HzViewController.swift
//  SnoKE
//
//  Created by Денис Харке on 14.11.2021.
//

import UIKit

class HzViewController: UIViewController {
    
    let hzView = HzView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(hzView)
        hzView.frame = view.frame
    }
}
