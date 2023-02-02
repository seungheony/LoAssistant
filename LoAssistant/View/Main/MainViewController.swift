//
//  MainTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/03/25.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

final class MainViewController: UITableViewController, StoryboardView {
    
    typealias Reactor = MainViewReactor
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func bind(reactor: MainViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: MainViewReactor) {
        tableView.rx.itemSelected
            .map(Reactor.Action.didSelect)
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: MainViewReactor) {
        reactor.state
            .map { $0.nextView }
            .distinctUntilChanged()
            .bind(onNext: { self.pushNextViewController(nextView: $0) })
            .disposed(by: disposeBag)
    }
    
    private func pushNextViewController(nextView: ViewList) {
        switch nextView {
        case .mainView:
            print("push main view")
        case .orehaCalcView:
            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "OrehaTable") else {
                return
            }
//            nextVC.reactor = OrehaCalcReactor
            self.navigationController?.pushViewController(nextVC, animated: true)
        case .pheonCalcView:
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PheonView") as? PheonViewController else {
                return
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
//            nextVC.reactor = PheonCalcReactor
        case .weeklyCheckListView:
            guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "Character Table") else {
                return
            }
//            nextVC.reactor = WeeklyCheckListReactor
            self.navigationController?.pushViewController(uvc, animated: true)
        }
    }
}
