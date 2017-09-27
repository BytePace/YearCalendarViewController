//
//  ViewController.swift
//  CalendarYearView
//
//  Created by Ruslan Musagitov on 20/09/2017.
//  Copyright © 2017 BytePace. All rights reserved.
//

import UIKit

let YearCalendarViewControllerIdentifier = "YearCalendarViewController"

class YearCalendarViewController: UIViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var yearLabel : UILabel!
    
    var year = 2017 {
        didSet {
            loadViewIfNeeded()
            generateDates()
        }
    }
    
    var month = 1
    
    var dateComponent : DateComponents!
    var daysOfWeek = [[Int]]()
    var tempDaysOfWeek = [[Int]]()
    var dates = [[Date]]()
    var tempDates = [[Date]]()
    
    @IBOutlet var collectionViews : [UICollectionView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for cv in collectionViews {
            cv.register(UINib(nibName: "YearCalendarDayCell", bundle: nil), forCellWithReuseIdentifier: YearCalendarDayCellIdentifier)
        }
        generateDates()
    }
    
    func generateDates() {
        daysOfWeek.removeAll()
        dates.removeAll()
        
        var dateComp = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: year)
        for i in 1 ... 12 {
            dateComp.month = i
            dateComp.day = 1
            guard let date = dateComp.date else { return }
            var arr = [Int]()
            var datesArray = [Date]()
            for i in 1...date.numberOfDaysInMonth() {
                dateComp.day = i
                var weekday = Calendar.current.component(.weekday, from: dateComp.date!)
                if weekday == 1 {
                    weekday = 7
                } else {
                    weekday -= 1
                }
                datesArray.append(dateComp.date!)
                arr.append(weekday)
            }
            dates.append(datesArray)
            daysOfWeek.append(arr)
            for cv in collectionViews {
                cv.reloadData()
            }
        }
        dateComp.month = 2
        self.dateComponent = dateComp
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        yearLabel.text = "\(year)"
    }
}

extension YearCalendarViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        tempDaysOfWeek = daysOfWeek
        tempDates = dates
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let monthIndex = collectionViews.index(of: collectionView)!
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YearCalendarDayCellIdentifier, for: indexPath) as! YearCalendarDayCell
        let rawDay = indexPath.item + 1
        
        var array = tempDaysOfWeek[monthIndex]
        var datesArray = tempDates[monthIndex]
        
        if array.count > 0 && datesArray.count > 0 {
            if array.first == rawDay {
                _ = array.removeFirst()
                cell.date = datesArray.removeFirst()
                tempDates[monthIndex] = datesArray
                tempDaysOfWeek[monthIndex] = array
            } else {
                cell.dayLabel.text = ""
            }
        } else {
               cell.dayLabel.text = ""
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.scale
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.scale
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxLength = Int(min(collectionView.frame.width, collectionView.frame.height) / 7)
        return CGSize(width: maxLength, height: maxLength)
    }
}

let YearCalendarDayCellIdentifier = "YearCalendarDayCell"
class YearCalendarDayCell : UICollectionViewCell {
    @IBOutlet weak var dayLabel : UILabel!
    
    var date : Date! {
        didSet {
            let day = Calendar.current.component(.day, from: date)
            dayLabel.text = "\(day)"
        }
    }
}
 
