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
            // Action.didSelect에서 IndexPath를 받아 switch 문으로 section을 구분한다.
            switch indexPath.section {
            case 0:
                // section에 따라서 nextView에 얼마를 더해줄지 상수가 결정한다. -> 추후에 자동 Counting 구현 필요
                let nextView: ViewList = ViewList(rawValue: indexPath.row + 1) ?? .mainView
                // 어느 View를 push할지를 Mutation.pushView로 넘겨준다.
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
            // mutate()에서 받은 ViewList 인자를 state에 저장한다.
            state.nextView = view
        }
        return state
    }
}
