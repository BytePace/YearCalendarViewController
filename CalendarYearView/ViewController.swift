//
//  ViewController.swift
//  CalendarYearView
//
//  Created by Ruslan Musagitov on 26/09/2017.
//  Copyright © 2017 BytePace. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController {
    var vcs = [YearCalendarViewController]()
    
    var currentYear = 2017
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0...5 {
            vcs.append(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: YearCalendarViewControllerIdentifier) as! YearCalendarViewController)
        }
        
        let vc = getYearViewController()
        vc.year = currentYear
        
        setViewControllers([vc], direction: .forward, animated: false, completion: nil)
        didEndPageScrolling()
        dataSource = self
        delegate = self
    }
    

}

extension ViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentYear <= 0 {
            return nil
        }
        let vc = getYearViewController()
        vc.year = currentYear + 1
        print("")
        print("currentYear \(currentYear)")
        print("after vc year \(vc.year)")
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let vc = getYearViewController()
        vc.year = currentYear - 1
        print("")
        print("currentYear \(currentYear)")
        print("before vc year \(vc.year)")
        return vc
    }
    
    func getYearViewController() -> YearCalendarViewController {
        let vc = vcs.removeFirst()
        vcs.append(vc)
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        didEndPageScrolling()
    }
    
    fileprivate func didEndPageScrolling() {
        guard let vc = viewControllers?.first as? YearCalendarViewController else { return }
        currentYear = vc.year
    }
}
