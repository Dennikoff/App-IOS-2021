//
//  DiaryViewController.swift
//  SnoKE
//
//  Created by Ilya Buldin on 12.12.2021.
//

import UIKit

class DiaryViewController: UIViewController {
    
    // MARK: - Properties
    var gradient : CAGradientLayer?
    
    let gradientView : UIView = {
        let view = UIView()
        return view
    }()
    
    private let achievementsVC = AchievementsViewController()
    
    private let emotionsVC = EmotionsDiaryViewController()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let toggleView = DiaryToggleView()

    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Library"
//        setupGradient(gradient: &gradient, gradientView: gradientView)
        view.addSubview(toggleView)
        toggleView.delegate = self
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.width * 2, height: scrollView.height)
        view.addSubview(scrollView)
        addChildren()
//        updateBarButtons()
    }
    
    
    // MARK: - Methods
    private func addChildren() {
        addChild(achievementsVC)
        scrollView.addSubview(achievementsVC.view)
        achievementsVC.view.frame = CGRect(x: 0, y: 0, width: scrollView.width, height: scrollView.height)
        achievementsVC.didMove(toParent: self)
        
        addChild(emotionsVC)
        scrollView.addSubview(emotionsVC.view)
        emotionsVC.view.frame = CGRect(x: view.width, y: 0, width: scrollView.width, height: scrollView.height)
        emotionsVC.didMove(toParent: self)
    }

//    private func updateBarButtons() {
//        switch toggleView.state {
//        case .achievements:
//            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
//        case .emotions:
//            navigationItem.rightBarButtonItem = nil
//        }
//    }
    
//    @objc private func didTapAdd() {
//        achievementsVC.showCreatePlaylistAlert()
//    }
//
    // MARK: - Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradient?.frame = CGRect(
            x: 0.0,
            y: 0.0,
            width: getNavBarHeightAndWidth().width,
            height: getNavBarHeightAndWidth().height
        )
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    private func setConstraints() {
        toggleView.translatesAutoresizingMaskIntoConstraints = false
        toggleView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        toggleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        toggleView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        toggleView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65).isActive = true
        scrollView.widthAnchor.constraint(equalToConstant: view.width).isActive = true
        scrollView.heightAnchor.constraint(equalToConstant: view.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 55).isActive = true
    }
}


// MARK: - Delegate
extension DiaryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= (view.width - 100) {
            toggleView.update(for: .emotions)
//            updateBarButtons()
        } else {
            toggleView.update(for: .achievements)
//            updateBarButtons()
        }
    }
}

extension DiaryViewController: DiaryToggleViewDelegate {
    func diaryToggleViewDidTapAchievements(_ toggleView: DiaryToggleView) {
        scrollView.setContentOffset(.zero, animated: true)
//        updateBarButtons()
    }
    
    func diaryToggleViewDidTapEmotions(_ toggleView: DiaryToggleView) {
        scrollView.setContentOffset(CGPoint(x: view.width, y: 0), animated: true)
//        updateBarButtons()
    }
}
