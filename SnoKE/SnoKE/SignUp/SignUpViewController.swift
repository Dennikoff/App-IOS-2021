//
//  SignUpViewController.swift
//  SnoKE
//
//  Created by Kristina Shlyapkina on 23.10.2021.
//

import UIKit
import SwiftUI

class SignUpViewController: UIViewController {

    let content = SighUpView()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        view.addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        content.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        content.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        content.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        content.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}


struct SignUpViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            SignUpViewController()
        }
    }
}
