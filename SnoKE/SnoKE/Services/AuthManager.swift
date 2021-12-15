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
    case achievements
}

enum UserInfo: String {
    case id
    case email
    case cigarettesPerDay
    case cigarettesInPack
    case packPrice
    case finishSmokingDate
}

struct AppUser {
    let id: String
    let email: String
    let numberPerDay: String
    let numberInPack: String
    let packPrice: String
    let finishSmokingDate: String
    
    init(data: [String:Any]) {
        self.id = data["id"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.numberPerDay = data["numberPerDay"] as? String ?? ""
        self.numberInPack = data["numberInPack"] as? String ?? ""
        self.packPrice = data["packPrice"] as? String ?? ""
        self.finishSmokingDate = data["finishSmokingDate"] as? String ?? ""
    }
    
    
    func setUserDefaultFields() {
        
        UserDefaults.standard.set(email, forKey: "com.SnoKEapp.SnoKE.email.\(id)")
        UserDefaults.standard.set(numberPerDay, forKey: "com.SnoKEapp.SnoKE.numberPerDay.\(id)")
        UserDefaults.standard.set(numberInPack, forKey: "com.SnoKEapp.SnoKE.numberInPack.\(id)")
        UserDefaults.standard.set(packPrice, forKey: "com.SnoKEapp.SnoKE.packPrice.\(id)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let date = dateFormatter.date(from: finishSmokingDate)!
        print(date)
        print(Date())
        UserDefaults.standard.setValue(date, forKey: "com.SnoKEapp.SnoKE.finishSmokingDate.\(id)")
        
    }
}

final class AuthManager {
    
    static let shared = AuthManager()
    
    private let database = Firestore.firestore()
    
    var currentUserID: String = ""
    
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
                self.currentUserID = id
                self.database
                    .collection(FirestoreCollection.users.rawValue)
                    .document(result.user.uid)
                    .setData([UserInfo.email.rawValue : email,
                              UserInfo.id.rawValue : id])
                completion()
                
            }
        }
    }
    
    func fillAdditionalUserInfo(to user: User, cigarettesPerDay: String, cigarettesInPack: String, packPrice: String) {
        self.database
            .collection(FirestoreCollection.users.rawValue)
            .document(user.uid)
            .updateData([UserInfo.cigarettesPerDay.rawValue : cigarettesPerDay,
                         UserInfo.cigarettesInPack.rawValue : cigarettesInPack,
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
                self.updateUserDefaultsForUser()
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
    
    func updateUserDefaultsForUser() {
        guard let id = Auth.auth().currentUser?.uid else {
            print("[DEBUG] got something wrong in updating UserDefaults")
            return
        }
        currentUserID = id
        let docRef = database.collection(FirestoreCollection.users.rawValue).document(currentUserID)
        
        docRef.getDocument { (document, error) in
            
            if let document = document, document.exists {
                let dataDescription = document.data()
                guard let dataDescription = dataDescription else {
                    return
                }
                let userInfo = AppUser(data: dataDescription)
                userInfo.setUserDefaultFields()
                print("Document data: \(String(describing: dataDescription))")
                
            } else {
                print("Document does not exist")
            }
            
        }
        
        
        
        
    }
    
}

