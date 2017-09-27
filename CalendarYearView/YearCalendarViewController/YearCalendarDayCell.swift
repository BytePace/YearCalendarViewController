//
//  YearCalendarDayCell.swift
//  CalendarYearView
//
//  Created by Ruslan Musagitov on 27/09/2017.
//  Copyright © 2017 BytePace. All rights reserved.
//

import UIKit

let YearCalendarDayCellIdentifier = "YearCalendarDayCell"

class YearCalendarDayCell : UICollectionViewCell {
    @IBOutlet weak var dayLabel : UILabel!
    
    var date : Date! {
        didSet {
            let day = Calendar.current.component(.day, from: date)
            dayLabel.text = "\(day)"
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dayLabel.textColor = UIColor.lightGray
        dayLabel.backgroundColor = UIColor.clear
        dayLabel.text = ""
    }
    
}

