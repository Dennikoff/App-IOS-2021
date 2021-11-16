//
//  StartFormPresenter.swift
//  SnoKE
//
//  Created by Ilya Buldin on 17.11.2021.
//

import UIKit

protocol StartFormPresenterProtocol {
    func showStartCongratulationsScreen(_ vc: UIViewController)
    func showNotAllFormsFilledAlert(_ vc: UIViewController)
}


final class StartFormPresenter: StartFormPresenterProtocol {
    
    func showStartCongratulationsScreen(_ vc: UIViewController) {
        let startCongratsPresenter = StartCongratulationsPresenter()
        let startCongratsVC = StartCongratulationsViewController(presenter: startCongratsPresenter)
        startCongratsVC.modalPresentationStyle = .fullScreen
        vc.present(startCongratsVC, animated: false)
    }
    
    func showNotAllFormsFilledAlert(_ vc: UIViewController) {
        let alert = UIAlertController(title: "Что-то пошло не так...",
                                      message: "Не все поля заполнены, пожалуйста, потрудитесь и проставьте три числа 👻",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        vc.present(alert, animated: true)
    }
}



