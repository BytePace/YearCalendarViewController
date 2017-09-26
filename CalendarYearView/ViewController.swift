//
//  ViewController.swift
//  CalendarYearView
//
//  Created by Ruslan Musagitov on 20/09/2017.
//  Copyright © 2017 BytePace. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView : UICollectionView!
    
    var year = 2017
    var month = 1
    
    var dateComponent : DateComponents!
    var daysOfWeek = [[Int]]()
    var tempDaysOfWeek = [[Int]]()
    var dates = [[Date]]()
    var tempDates = [[Date]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var dateComp = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: year)
        for i in 1 ... 12 {
            dateComp.month = i
            dateComp.day = 1
            guard let date = dateComp.date else { return }
            print(date.numberOfDaysInMonth())
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
            print(arr)
            print("")
            dates.append(datesArray)
            daysOfWeek.append(arr)
            collectionView.reloadData()
        }
        dateComp.month = 2
        self.dateComponent = dateComp
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        tempDaysOfWeek = daysOfWeek
        tempDates = dates
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YearCalendarDayCellIdentifier, for: indexPath) as! YearCalendarDayCell
        let rawDay = indexPath.item + 1
        if var array = tempDaysOfWeek.first, var datesArray = tempDates.first {
            if array.first == rawDay {
                _ = array.removeFirst()
                cell.date = datesArray.removeFirst()
                tempDates[0] = datesArray
                tempDaysOfWeek[0] = array
            } else {
                cell.dayLabel.text = ""
            }
        } else {
               cell.dayLabel.text = ""
        }
//        dateComponent.weekOfMonth = indexPath.section
//        dateComponent.weekday
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
 
