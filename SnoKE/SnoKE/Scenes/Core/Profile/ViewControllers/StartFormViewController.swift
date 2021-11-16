//
//  HzViewController.swift
//  SnoKE
//
//  Created by Денис Харке on 14.11.2021.
//

import UIKit

class StartFormViewController: UIViewController {
    
    private var startFormView = StartFormView()
    
    override func loadView() {
        super.loadView()
        view = startFormView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}
