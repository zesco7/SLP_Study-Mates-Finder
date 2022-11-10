//
//  IntroPageViewController.swift
//  SLP_Study Mates Finder
//
//  Created by Mac Pro 15 on 2022/11/10.
//

import UIKit

// example Page View Controller
class IntroPageViewController: UIPageViewController {
    var mainView = IntroPageView()
    let proxy = UIPageControl.appearance()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(mainView.pageViewController)
        mainView.pageViewController.dataSource = self
        mainView.pageViewController.delegate = self
        
        //PageViewController Indicator 색상 변경: let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = UIColor.gray
        proxy.currentPageIndicatorTintColor = UIColor.black
        
        if let firstVC = mainView.dataViewControllers.first {
            mainView.pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        print(#function)
        let vc = PhoneNumberCheckViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// typical Page View Controller Data Source
extension IntroPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = mainView.dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return mainView.dataViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = mainView.dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == mainView.dataViewControllers.count {
            return nil
        }
        return mainView.dataViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return mainView.dataViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = mainView.dataViewControllers.firstIndex(of: first) else { return 0 }
        return index
    }
}
