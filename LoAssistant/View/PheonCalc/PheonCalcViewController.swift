//
//  PheonViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/06/05.
//

import UIKit
import ReactorKit
import RxCocoa
import RxSwift

class PheonCalcViewController: UIViewController, StoryboardView {
    
    var disposeBag = DisposeBag()
    
    @IBOutlet weak var pheonAmount: UITextField!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button30: UIButton!
    @IBOutlet weak var button100: UIButton!
    
    @IBOutlet weak var calculate: UIButton!
    
    @IBOutlet weak var goldPerPheon: UILabel!
    @IBOutlet weak var result: UILabel!

    let crystalURL = "https://lostarkapi.ga/crystal/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pheonAmount.keyboardType = .numberPad
        pheonAmount.endEditing(true)
    }

    func bind(reactor: PheonCalcReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: PheonCalcReactor) {
        button1.rx.tap
            .map { Reactor.Action.didTapButton_1 }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        button30.rx.tap
            .map { Reactor.Action.didTapButton_30 }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)

        button100.rx.tap
            .map { Reactor.Action.didTapButton_100}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        pheonAmount.rx.text
            .map { Reactor.Action.typeNumOfPheon($0 ?? "") }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        calculate.rx.tap
            .map { Reactor.Action.didTapCalcButton }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: PheonCalcReactor) {
        reactor.state.map { $0.constant }
          .distinctUntilChanged()
          .bind(onNext: setButtonSelection)
          .disposed(by: disposeBag)
        
        reactor.state.map { $0.isCalculable }
          .distinctUntilChanged()
          .bind(to: calculate.rx.isEnabled)
          .disposed(by: disposeBag)
        
        reactor.state.map { $0.numOfPheon }
          .map { "\($0) 페온당" }
          .distinctUntilChanged()
          .bind(to: goldPerPheon.rx.text)
          .disposed(by: disposeBag)
        
        reactor.state.map { $0.goldPerCrystal }
          .distinctUntilChanged()
          .bind(to: result.rx.text)
          .disposed(by: disposeBag)
    }
    
    private func setButtonSelection(constant: BundleConstant) {
        pheonAmount.endEditing(true)
        
        button1.isSelected = false
        button30.isSelected = false
        button100.isSelected = false
        
        switch constant {
        case .bundleOf1:
            button1.isSelected = true
        case .bundleOf30:
            button30.isSelected = true
        case .bundleOf100:
            button100.isSelected = true
        }
    }
}
