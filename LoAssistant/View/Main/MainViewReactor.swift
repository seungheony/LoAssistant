//
//  MainViewReactor.swift
//  LoAssistant
//
//  Created by 김승헌 on 2023/02/02.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa

class MainViewReactor: Reactor {
    
    enum Action {
        case didSelect(IndexPath)
    }
    
    enum Mutation {
        case pushView(ViewList)
    }
    
    struct State {
        var nextView: ViewList = ViewList.mainView
    }
    
    let initialState: State
    
    init(initialState: State) {
        self.initialState = initialState
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSelect(let indexPath):
            switch indexPath.section {
            case 0:
                let nextView: ViewList = ViewList(rawValue: indexPath.row + 1) ?? .mainView
                return Observable.just(Mutation.pushView(nextView))
            case 1:
                let nextView: ViewList = ViewList(rawValue: indexPath.row + 3) ?? .mainView
                return Observable.just(Mutation.pushView(nextView))
            default:
                return Observable.just(Mutation.pushView(.mainView))
            }
            
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .pushView(view):
            state.nextView = view
        }
        return state
    }
}
