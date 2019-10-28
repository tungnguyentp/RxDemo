////
////  HomeTabBarViewModel.swift
////  SwiftHub
////
////  Created by Khoren Markosyan on 7/11/18.
////  Copyright © 2018 Khoren Markosyan. All rights reserved.
////
//
//import Foundation
//import RxCocoa
//import RxSwift
//
//class HomeTabBarViewModel: ViewModel, ViewModelType {
//
//    struct Input {
//        
//    }
//
//    struct Output {
//        let tabBarItems: Driver<[HomeTabBarItem]>
//        
//    }
//
//
//    func transform(input: Input) -> Output {
//
//        let tabBarItems = return [.news, .search, .notifications, .settings]
//
//        return Output(tabBarItems: tabBarItems)
//    }
//
//    func viewModel(for tabBarItem: HomeTabBarItem) -> ViewModel {
//        switch tabBarItem {
//        case .home:
//            let viewModel = SearchViewModel(provider: provider)
//            return viewModel
//       
//        }
//    }
//}
