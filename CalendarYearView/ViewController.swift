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
    
    var currentPageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...2 {
            vcs.append(UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: YearCalendarViewControllerIdentifier) as! YearCalendarViewController)
        }
        setViewControllers(vcs.first, direction: .forward, animated: false, completion: nil)
    }
}

extension ViewController : UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var vc = vcs.removeFirst()

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
    }
}
