////
////  HomeTabBarController.swift
////  SwiftHub
////
////  Created by Khoren Markosyan on 1/5/18.
////  Copyright © 2018 Khoren Markosyan. All rights reserved.
////
//
//import UIKit
//import RAMAnimatedTabBarController
//import Localize_Swift
//import RxSwift
//
//enum HomeTabBarItem: Int {
//    case home
//
//    private func controller(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
//        switch self {
//        case .home:
//            let vc = HomeViewController(viewModel: viewModel, navigator: navigator)
//            return NavigationController(rootViewController: vc)
//        }
//    }
//
//    var image: UIImage? {
//        switch self {
//        case .home: return UIImage.init(named: "")
//        }
//    }
//
//    var title: String {
//        switch self {
//        case .home: return "Home"
//        }
//    }
//
//    var animation: RAMItemAnimation {
//        var animation: RAMItemAnimation
//        switch self {
//        case .home: animation = RAMFlipLeftTransitionItemAnimations()
//        }
//        _ = themeService.rx
//            .bind({ $0.secondary }, to: animation.rx.iconSelectedColor)
//            .bind({ $0.secondary }, to: animation.rx.textSelectedColor)
//        return animation
//    }
//
//    func getController(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
//        let vc = controller(with: viewModel, navigator: navigator)
//        let item = RAMAnimatedTabBarItem(title: title, image: image, tag: rawValue)
//        item.animation = animation
//        _ = themeService.rx
//            .bind({ $0.text }, to: item.rx.iconColor)
//            .bind({ $0.text }, to: item.rx.textColor)
//
//        item.yOffSet = -1
//        vc.tabBarItem = item
//        return vc
//    }
//}
//
//class HomeTabBarController: RAMAnimatedTabBarController, Navigatable {
//
//    var viewModel: HomeTabBarViewModel?
//    var navigator: Navigator!
//
//    init(viewModel: ViewModel?, navigator: Navigator) {
//        self.viewModel = viewModel as? HomeTabBarViewModel
//        self.navigator = navigator
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    let tabTapped = PublishSubject<UIGestureRecognizer>()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//        makeUI()
//        bindViewModel()
//    }
//
//    func makeUI() {
//        // Configure tab bar
//        hero.isEnabled = true
//        tabBar.hero.id = "TabBarID"
//        tabBar.isTranslucent = false
//
//        // Fixed an issue when TabBar is switched quickly, the selected item is abnormal
//        tabTapped.throttle(DispatchTimeInterval.milliseconds(1000), scheduler: MainScheduler.asyncInstance)
//            .subscribe(onNext: { [weak self] (gesture) in
//                self?.tabTapped(gesture)
//            }).disposed(by: rx.disposeBag)
//
//        NotificationCenter.default
//            .rx.notification(NSNotification.Name(LCLLanguageChangeNotification))
//            .subscribe { [weak self] (event) in
//                self?.animatedItems.forEach({ (item) in
//                    item.title = HomeTabBarItem(rawValue: item.tag)?.title
//                })
//                self?.setViewControllers(self?.viewControllers, animated: false)
//                self?.setSelectIndex(from: 0, to: self?.selectedIndex ?? 0)
//            }.disposed(by: rx.disposeBag)
//
//        themeService.rx
//            .bind({ $0.primaryDark }, to: tabBar.rx.barTintColor)
//            .disposed(by: rx.disposeBag)
//
//        themeService.typeStream.delay(DispatchTimeInterval.milliseconds(700), scheduler: MainScheduler.instance).subscribe(onNext: { (theme) in
//            switch theme {
//            case .light(let color), .dark(let color):
//                self.changeSelectedColor(color.color, iconSelectedColor: color.color)
//            }
//        }).disposed(by: rx.disposeBag)
//    }
//
//    func bindViewModel() {
//        guard let viewModel = viewModel else { return }
//
//        let input = HomeTabBarViewModel.Input(whatsNewTrigger: rx.viewDidAppear.mapToVoid())
//        let output = viewModel.transform(input: input)
//
//        output.tabBarItems.drive(onNext: { [weak self] (tabBarItems) in
//            if let strongSelf = self {
//                let controllers = tabBarItems.map { $0.getController(with: viewModel.viewModel(for: $0), navigator: strongSelf.navigator) }
//                strongSelf.setViewControllers(controllers, animated: false)
//            }
//        }).disposed(by: rx.disposeBag)
//
//        output.openWhatsNew.drive(onNext: { [weak self] (block) in
//            if Configs.Network.useStaging == false {
//                self?.navigator.show(segue: .whatsNew(block: block), sender: self, transition: .modal)
//            }
//        }).disposed(by: rx.disposeBag)
//    }
//
//    override func tapHandler(_ gesture: UIGestureRecognizer) {
//        tabTapped.onNext(gesture)
//    }
//
//    func tabTapped(_ gesture: UIGestureRecognizer) {
//        super.tapHandler(gesture)
//    }
//}
