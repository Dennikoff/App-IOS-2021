//
//  StartCongratulationsPresenter.swift
//  SnoKE
//
//  Created by Ilya Buldin on 17.11.2021.
//

import UIKit


protocol StartCongratulationsPresenterProtocol {
    func showMainFlow()
}


final class StartCongratulationsPresenter: StartCongratulationsPresenterProtocol {
    func showMainFlow() {
        AuthManager.shared.finishAuth()
    }
}
