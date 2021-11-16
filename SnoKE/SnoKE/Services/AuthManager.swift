//
//  AuthManager.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()
    
    var userID: String?
    
    private init() {
        
    }
    
    func signUpUser(_ vc: SignUpViewControllerProtocol, email: String, password: String, completion: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    print("🐣 [DEBUG] AuthErrorCode: .operationNotAllowed")
                    vc.showSignUpErrorAlert(with: "У нас технические неполадки, попробуйте снова позже, только не обижайтесь")
                    
                    break
                // Error: The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section.
                case .emailAlreadyInUse:
                    print("🐣 [DEBUG] AuthErrorCode: .emailAlreadyInUse")
                    vc.showSignUpErrorAlert(with: "Птичка нашептала, что кто-то с такой почтой уже зарегистрирован")
                    break
                // Error: The email address is already in use by another account.
                case .invalidEmail:
                    print("🐣 [DEBUG] AuthErrorCode: .invalidEmail")
                    vc.showSignUpErrorAlert(with: "Почта что вы написали...\n Как бы вам сказать...\n Проверьте ее снова - формат неправильный")
                    break
                // Error: The email address is badly formatted.
                case .weakPassword:
                    print("🐣 [DEBUG] AuthErrorCode: .weakPassword")
                    vc.showSignUpErrorAlert(with: "Пароль слабоват, дружище!\n Он должен содержать как минимум 6 символов, дерзай!")
                    break
                // Error: The password must be 6 characters long or more.
                default:
                    print("Error: \(error.localizedDescription)")
                }
            } else {
                print("✅🐣✅ User signs up successfully")
                guard let id = Auth.auth().currentUser else {
                    return
                }
                self.userID = id.uid
                completion()
            }
        }
    }
    
    func finishAuth() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(to: .mainState)
    }
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser != nil
    }
    
    func logout(completion: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
            print("❎ [DEBUG] Sign out success")
            completion()
        } catch {
            print("❌ [DEBUG] Sign out error")
        }
    }
}
