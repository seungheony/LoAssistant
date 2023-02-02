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
import Alamofire
import SwiftyJSON

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
            // State.nextView의 값이 변경될 때마다 pushNextView룰 살행한다.
            .bind(onNext: pushNextView)
            .disposed(by: disposeBag)
    }
    
    private func pushNextView(nextView: ViewList) {
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
            guard let nextVC = self.storyboard?.instantiateViewController(identifier: "PheonView") as? PheonCalcViewController else {
                return
            }
            self.navigationController?.pushViewController(nextVC, animated: true)
            nextVC.reactor = PheonCalcReactor(initialState: PheonCalcReactor.State(numOfPheon: 0, goldPerCrystal: "", crystalData: JSON(), isCalculable: false, constant: .bundleOf100))
        case .weeklyCheckListView:
            guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "Character Table") else {
                return
            }
//            nextVC.reactor = WeeklyCheckListReactor
            self.navigationController?.pushViewController(uvc, animated: true)
        }
    }
}
