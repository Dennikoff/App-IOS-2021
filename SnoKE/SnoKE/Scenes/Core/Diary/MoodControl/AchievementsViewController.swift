//
//  AchievementsViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 13.12.2021.
//

import UIKit
import FirebaseFirestore

class AchievementsViewController: UIViewController {
    private var achievements: [AchievementModel] {
        return modelOutput.reversed()
    }
    
    private var modelOutput: [AchievementModel] = []
    
    let database = Firestore.firestore()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AchievementTableViewCell.self,
                           forCellReuseIdentifier: AchievementTableViewCell.identifier)
        tableView.separatorColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        getAppropriateAchievements()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    

}


extension AchievementsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return achievements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AchievementTableViewCell.identifier,
                                                       for: indexPath) as? AchievementTableViewCell else {
            return UITableViewCell()
        }
        let achievement = achievements[indexPath.row]
        if indexPath.row == 0 {
            cell.configure(isLast: true, model: achievement)
        } else {
            cell.configure(model: achievement)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}


extension AchievementsViewController {
    func getAppropriateAchievements() {
        
        
        guard let daysWithoutCigarettes = HomeService.shared.getDaysWithoutCigarettes() else {
            return
        }
        guard let numberPerDay = UserDefaults.standard.string(forKey: "com.SnoKEapp.SnoKE.numberPerDay.\(AuthManager.shared.currentUserID)") else {
            return
        }
        
        let notSmokedCigarettes = Int(numberPerDay)! * daysWithoutCigarettes
        
      self.database.collection(FirestoreCollection.achievements.rawValue).whereField("numberCigarettes", isLessThan: notSmokedCigarettes)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let docData = document.data()
                        let newElem = AchievementModel(data: docData)
                        self.modelOutput.append(newElem)
                    }
                    self.tableView.reloadData()
                }
            }
        
    }
}
