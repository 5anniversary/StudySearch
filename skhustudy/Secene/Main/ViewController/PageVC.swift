//
//  PageVC.swift
//  SKHUStudy
//
//  Created by Junhyeon on 2020/04/21.
//  Copyright © 2020 anniversary. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController {
    // 뭐 아래 둘다 해봤는데 둘중 뭐가 되는지는 잘 모르겠다 일단 너놈 아니구
    
    var pageDelegate: PageIndexDelegate?
    var pendingPage: Int?
    let identifiers: NSArray = ["AllVC", "HashOneVC", "HashTwoVC", "HashThreeVC"]
    
    lazy var VCArray: [UIViewController] = {
        return [self.VCInstance(name: "AllVC"),
                self.VCInstance(name: "HashOneVC"),
                self.VCInstance(name: "HashTwoVC"),
                self.VCInstance(name: "HashThreeVC"),]
    }()
        
    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
    }
    
    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = VCArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print("pendingViewController")
        pendingPage = self.identifiers.index(of: pendingViewControllers[0].restorationIdentifier ?? 0)
        
        // 이런 구조가 어떻게 실행이 되지;; 아무리 실행 순서가 그렇게 보장된다고해도 얘는 좀 꺼림찍하다
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        print("didfinishAnimation")
        
        if completed {
            var index: Int
            index = pendingPage ?? 0
            pageDelegate?.SelectMenuItem(pageIndex: index)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        
        if previousIndex < 0 {
            return VCArray.last
        } else {
            return VCArray[previousIndex]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        
        if nextIndex >= VCArray.count {
            return VCArray.first
        } else {
            return VCArray[nextIndex]
        }
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArray.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        guard let firstViewController = viewControllers?.first else { return 0 }
        guard let firstViewControllerIndex = VCArray.firstIndex(of: firstViewController) else { return 0 }
        
        return firstViewControllerIndex
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> UIViewController? {
        //        NSLog("ViewController getViewControllerAtIndex index: %d", index)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if index == 0 {
            let AllVC = storyboard.instantiateViewController(withIdentifier: "AllVC") as! AllVC
            return AllVC
            
        } else if index == 1 {
            let HashOneVC = storyboard.instantiateViewController(withIdentifier: "HashOneVC") as! HashOneVC
            return HashOneVC
            
        } else if index == 2 {
            let HashTwoVC = storyboard.instantiateViewController(withIdentifier: "HashTwoVC") as! HashTwoVC
            return HashTwoVC
            
        } else if index == 3 {
            let HashThreeVC = storyboard.instantiateViewController(withIdentifier: "HashThreeVC") as! HashThreeVC
            return HashThreeVC
            
        } else {
            return nil
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
}
extension PageVC : UIPageViewControllerDelegate { }

extension PageVC : UIPageViewControllerDataSource {
    
}
