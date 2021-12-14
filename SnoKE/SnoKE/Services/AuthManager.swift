//
//  AuthManager.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

enum FirestoreCollection: String {
    case users
}

enum UserInfo: String {
    case id
    case email
    case sigarettesPerDay
    case sigarettesInPacket
    case packPrice
    case finishSmokingDate
}

final class AuthManager {
    
    static let shared = AuthManager()
    
    private let database = Firestore.firestore()
    
    
    private init() {
        
    }
    
    func signUpUser(_ vc: AuthViewControllerProtocol, email: String, password: String, completion: @escaping () -> Void) {
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

                guard let result = authResult else {
                    return
                    // TODO: make error completion
                }
                guard let id = Auth.auth().currentUser?.uid else {
                    return
                }
                self.database
                    .collection(FirestoreCollection.users.rawValue)
                    .document(result.user.uid)
                    .setData([UserInfo.email.rawValue : email,
                              UserInfo.id.rawValue : id])
                completion()

            }
        }
    }
    
    func fillAdditionalUserInfo(to user: User, sigarettesPerDay: Int, sigarettesInPacket: Int, packPrice: Int) {
        self.database
            .collection(FirestoreCollection.users.rawValue)
            .document(user.uid)
            .updateData([UserInfo.sigarettesPerDay.rawValue : sigarettesPerDay,
                      UserInfo.sigarettesInPacket.rawValue : sigarettesInPacket,
                      UserInfo.packPrice.rawValue : packPrice])
    }
    
    func addFinishSmokingDateToUserStorage(user: User, finishDate: String) {
        self.database
            .collection(FirestoreCollection.users.rawValue)
            .document(user.uid)
            .updateData([UserInfo.finishSmokingDate.rawValue : finishDate])
    }
    
    func signIn(_ vc: AuthViewControllerProtocol, email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error as NSError? {
                switch AuthErrorCode(rawValue: error.code) {
                case .operationNotAllowed:
                    // Error: Indicates that email and password accounts are not enabled. Enable them in the Auth section of the Firebase console.
                    print("🐣 [DEBUG] AuthErrorCode: .operationNotAllowed")
                    vc.showSignUpErrorAlert(with: "Вход не может быть произведен...\n Обратитесь к разработчикам - мы нашаманим!")
                case .userDisabled:
                    // Error: The user account has been disabled by an administrator.
                    print("🐣 [DEBUG] AuthErrorCode: .userDisabled")
                    vc.showSignUpErrorAlert(with: "Этот пользователь себя плохо вел - администратор ему выписал бан\n Такова вот жизнь")
                case .wrongPassword:
                    // Error: The password is invalid or the user does not have a password.
                    print("🐣 [DEBUG] AuthErrorCode: .wrongPassword")
                    vc.showSignUpErrorAlert(with: "Пароль неправильный!\n Сделайте правильным\n Ну или не делайте")
                case .invalidEmail:
                    // Error: Indicates the email address is malformed.
                    print("🐣 [DEBUG] AuthErrorCode: .invalidEmail")
                    vc.showSignUpErrorAlert(with: "Какая-то непонятная у вас почта - такие почты только на Марсе\n Пожалуйста, соблюдайте фоормат")
                default:
                    print("🐣 [DEBUG] AuthErrorCode: DEFAULT")
                    print("Error: \(error.localizedDescription)")
                    vc.showSignUpErrorAlert(with: "Сами точно не знаем, но скорее всего пользователя с таким логином не существует либо же он удален")
                }
            } else {
                print("User signs in successfully")
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(to: .mainState)
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

