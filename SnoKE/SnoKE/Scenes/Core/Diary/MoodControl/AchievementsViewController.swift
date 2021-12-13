//
//  AchievementsViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 13.12.2021.
//

import UIKit


class AchievementsViewController: UIViewController {
    private var achievements: [AchievementModel] = [
        AchievementModel(date: "15.01.2021", chapter: "Глава 5: Продвинутый", description: "Вероятность рака легких понизилась на:", achievementText: "13%", type: .health),
        AchievementModel(date: "01.01.2021", chapter: "Глава 5: Продвинутый", description: "Если выстроить сигареты в ряд получится:", achievementText: "Длина границы Казахстана", type: .scope),
        
        AchievementModel(date: "18.01.2021", chapter: "Глава 5: Продвинутый", description: "Воды сэкономлено:", achievementText: "10 000 л", type: .ecology),
        AchievementModel(date: "21.01.2021", chapter: "Глава 5: Продвинутый", description: "Вы сэкономили:", achievementText: "25 000 RUB", type: .scope),
        
        AchievementModel(date: "01.01.2021", chapter: "Глава 5: Продвинутый", description: "Если выстроить сигареты в ряд получится:", achievementText: "Длина границы Казахстана", type: .scope),
        AchievementModel(date: "15.01.2021", chapter: "Глава 5: Продвинутый", description: "Вероятность рака легких понизилась на:", achievementText: "13%", type: .health),
        AchievementModel(date: "18.01.2021", chapter: "Глава 5: Продвинутый", description: "Воды сэкономлено:", achievementText: "10 000 л", type: .ecology),
        AchievementModel(date: "21.01.2021", chapter: "Глава 5: Продвинутый", description: "Вы сэкономили:", achievementText: "25 000 RUB", type: .scope)
    ]
    
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
//        fetchData()
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
