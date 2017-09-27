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
    var thisYear = Calendar.current.component(.year, from: Date())
    var currentYear = Calendar.current.component(.year, from: Date())
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var timerEnded = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        if currentYear > thisYear + 10 && timerEnded { return nil }
        timerEnded = false

        let vc = getYearViewController()
        vc.year = self.currentYear + 1
        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if currentYear <= thisYear - 10 && timerEnded { return nil }
        timerEnded = false
        let vc = getYearViewController()
        vc.year = self.currentYear - 1
        return vc
    }
    
    func getYearViewController() -> YearCalendarViewController {
        return mainStoryboard.instantiateViewController(withIdentifier: YearCalendarViewControllerIdentifier) as! YearCalendarViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        didEndPageScrolling()
    }

    fileprivate func didEndPageScrolling() {
        guard let vc = viewControllers?.first as? YearCalendarViewController else { return }
        currentYear = vc.year
    }
}
