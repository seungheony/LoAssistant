//
//  PheonCalcReactor.swift
//  LoAssistant
//
//  Created by 김승헌 on 2023/02/02.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class PheonCalcReactor: Reactor {
    
    let crystalUrl: String = "https://lostarkapi.ga/crystal/"
    
    enum Action {
        case typeNumOfPheon(String)
        case didTapButton_1
        case didTapButton_30
        case didTapButton_100
        case didTapCalcButton
    }
    
    enum Mutation {
        case setButtonSelection(BundleConstant)
        case setNumOfPheon(String)
        case allowCalculation
        case setJSON(JSON)
        case parseCrystalData
        case calculate
    }
    
    struct State {
        var numOfPheon: Int
        var goldPerCrystal: String
        var crystalData: JSON
        var isCalculable: Bool
        var constant: BundleConstant   // 2, 1.8, 1.7
    }
    
    let initialState: State
    
    init(initialState: State) {
        self.initialState = initialState
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        var newMutation: Observable<Mutation>
        switch action {
        case .didTapButton_1:
            newMutation = Observable.just(.setButtonSelection(.bundleOf1))
        case .didTapButton_30:
            newMutation = Observable.just(.setButtonSelection(.bundleOf30))
        case .didTapButton_100:
            newMutation = Observable.just(.setButtonSelection(.bundleOf100))
        case .typeNumOfPheon(let numOfPheon):
            newMutation = Observable.concat([
                Observable.just(.setNumOfPheon(numOfPheon)),
                Observable.just(.allowCalculation)
            ])
        case .didTapCalcButton:
            return Observable.concat([
                parseCrystalData(crystalUrl).map{ .setJSON($0) },
                Observable.just(.calculate)
            ])
        }
        return newMutation
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setButtonSelection(let constant):
            newState.constant = constant
        case .setJSON(let json):
            newState.crystalData = json
        case .setNumOfPheon(let numOfPheon):
            newState.numOfPheon = Int(numOfPheon) ?? 0
        case .allowCalculation:
            if newState.numOfPheon != 0 {
                newState.isCalculable = true
            } else {
                newState.isCalculable = false
            }
        case .parseCrystalData:
            let request = AF.request(crystalUrl)
            request.responseJSON { response in
                switch response.result {
                case .success(let value):
                    newState.crystalData = JSON(value)
                    if newState.crystalData["Result"].stringValue == "Failed" {
                        // API 오류
                        newState.goldPerCrystal = "API 오류"
                    } else {
                        let crystalPrice = Double(newState.crystalData["Buy"].stringValue) ?? 0.0
                        let gold = crystalPrice / 19 * newState.constant.rawValue
                        newState.goldPerCrystal = "\(Int(gold)*newState.numOfPheon) G"
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case .calculate:
            if newState.crystalData["Result"].stringValue == "Failed" {
                // API 오류
                newState.goldPerCrystal = "API 오류"
            } else {
                let crystalPrice = Double(newState.crystalData["Buy"].stringValue) ?? 0.0
                let gold = crystalPrice / 19 * newState.constant.rawValue
                newState.goldPerCrystal = "\(Int(gold)*newState.numOfPheon) G"
            }
        }
        return newState
    }
    
    private func parseCrystalData(_ url: String) -> Observable<JSON> {
        
        return Observable.create() { emitter in
            let headers: HTTPHeaders = [
                "Accept": "application/json"
            ]
            AF.request(url,
                       method: .get,
                       encoding: URLEncoding.default,
                       headers: headers
            )
            .validate(statusCode:200..<300)
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .failure(let error):
                    emitter.onError(error)
                case .success(let value):
                    emitter.onNext(JSON(value))
                    emitter.onCompleted()
                }
            })
            
            return Disposables.create()
        }
    }
}
