//
//  ProfileViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 21.10.2021.
//

import UIKit

import UIKit
import FirebaseAuth


struct Section {
    let title: String
    let options: [Option]
}

struct Option {
    let title: String
    let handler: () -> Void
}



class ProfileViewController: UIViewController {
    // MARK: - Properties
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections: [Section] = []
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        title = "Settings"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    // MARK: - Methods
    private func configureModels() {
        sections.append(Section(title: "Профиль", options: [Option(title: "Посмотреть свой профиль", handler: { [weak self] in
            DispatchQueue.main.async {
                self?.viewProfile()
            }
        })]))
        
        sections.append(Section(title: "Аккаунт", options: [Option(title: "Выйти", handler: {
            DispatchQueue.main.async {
                AuthManager.shared.logout() {
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(to: .signUpState)
                }
            }
        })]))
    }
    
    
    private func viewProfile() {
        // TODO: добавить в юзер дефолтс дату всю инфу после входа в приложение(надо хранить на бэке эту чушь)
        guard let user = Auth.auth().currentUser,
              let finishSmokingDate = UserDefaults.standard.object(forKey: "com.SnoKEapp.SnoKE.finishSmokingDate.\(user.uid)") as? Date else {
                  print("[DEBUG] Got unwrap error with finishSmokingDate")
            return
        }
        let finishSmokingString = finishSmokingDate.getFormattedDate(format: "dd/MM/yyyy")
        
        guard let numPerDay = UserDefaults.standard.string(forKey: "com.SnoKEapp.SnoKE.numberPerDay.\(user.uid)"),
              let packPrice =  UserDefaults.standard.string(forKey: "com.SnoKEapp.SnoKE.packPrice.\(user.uid)"),
              let numberInPack = UserDefaults.standard.string(forKey: "com.SnoKEapp.SnoKE.numberInPack.\(user.uid)")
        else {
            print("[DEBUG] Got unwrap error with numPerDay, packPrice, numberInPack")
            return
        }
        
        let alert = UIAlertController(title: "Информация об аккаунте",
                                      message: "Cигарет в день: \(numPerDay)\nСтоимость пачки: \(packPrice)\nКол-во в пачке: \(numberInPack)\n\nЗакончил курить: \(finishSmokingString)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
}


// MARK: - Delegate and DataSource
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    // DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sections[indexPath.section].options[indexPath.row]
        model.handler()
    }
}
