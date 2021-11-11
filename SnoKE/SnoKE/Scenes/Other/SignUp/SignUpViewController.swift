//
//  SignUpViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit
import SwiftUI

class SignUpViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        view = SignUpView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

struct SignUpViewController_Previews: PreviewProvider {
     static var previews: some View {
         ViewControllerPreview {
             SignUpViewController()
         }
     }
 }
