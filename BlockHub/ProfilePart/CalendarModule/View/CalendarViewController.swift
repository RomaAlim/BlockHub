//
//  CalendarViewController.swift
//  BlockHub
//
//  Created by Ramazan Kalabay on 05.06.2024.
//

import UIKit

class CalendarViewController:  UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var week1: UILabel!
    @IBOutlet weak var week2: UILabel!
    @IBOutlet weak var week3: UILabel!
    @IBOutlet weak var week4: UILabel!
    @IBOutlet weak var week5: UILabel!
    @IBOutlet weak var week6: UILabel!
    @IBOutlet weak var week7: UILabel!
    
    var selectedDate = Date()
        var totalSquares = [String]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            collectionView.dataSource = self
            collectionView.delegate = self
            setCellsView()
            setMonthView()
            updateLocalize()
            NotificationCenter.default.addObserver(self, selector: #selector(reloadCalendar), name: NSNotification.Name("reloadCalendar"), object: nil)
            
        }
        
    func setCellsView() {
            let width = (collectionView.frame.size.width - 2) / 8
            let height = (collectionView.frame.size.height - 2) / 8
            
            let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            flowLayout.itemSize = CGSize(width: width, height: height)
        }
        
        func setMonthView() {
            totalSquares.removeAll()
            
            let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
            let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
            let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
            
            var count: Int = 1
            
            while(count <= 42) {
                if(count <= startingSpaces || count - startingSpaces > daysInMonth) {
                    totalSquares.append("")
                } else {
                    totalSquares.append(String(count - startingSpaces))
                }
                count += 1
            }
            
            monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
            collectionView.reloadData()
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return totalSquares.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        let day = totalSquares[indexPath.item]
        cell.dayOfMonth.text = day
        
        let calendar = Calendar.current
        let cellDateComponents = DateComponents(year: calendar.component(.year, from: selectedDate),
                                                month: calendar.component(.month, from: selectedDate),
                                                day: Int(day) ?? 0)
        
        if let cellDate = calendar.date(from: cellDateComponents) {
            let currentDate = Date()
            
            if calendar.isDate(cellDate, equalTo: currentDate, toGranularity: .day) {
                cell.backgroundColor = UIColor.blue
                cell.dayOfMonth.textColor = UIColor.white
            } else {
                cell.backgroundColor = UIColor.clear
                cell.dayOfMonth.textColor = UIColor.black
            }
            
            let registrations = CourseManager.shared.loadRegistrations()
            for registration in registrations {
                if calendar.isDate(cellDate, equalTo: registration.registrationDate, toGranularity: .day) {
                    cell.backgroundColor = UIColor.green
                    cell.dayOfMonth.textColor = UIColor.white
                } else if calendar.isDate(cellDate, equalTo: registration.deadlineDate, toGranularity: .day) {
                    cell.backgroundColor = UIColor.orange
                    cell.dayOfMonth.textColor = UIColor.white
                } else if let completionDate = registration.completionDate,
                          calendar.isDate(cellDate, equalTo: completionDate, toGranularity: .day) {
                    cell.backgroundColor = UIColor.red
                    cell.dayOfMonth.textColor = UIColor.white
                } else if cellDate > registration.registrationDate && cellDate < registration.deadlineDate {
                    cell.backgroundColor = UIColor.systemGray5
                    cell.dayOfMonth.textColor = UIColor.white
                } else if let completionDate = registration.completionDate,
                          cellDate > registration.deadlineDate && cellDate < completionDate {
                    cell.backgroundColor = UIColor.systemGray5
                    cell.dayOfMonth.textColor = UIColor.black
                }
            }
        }
        
        // Сделать фон ячейки круглым
        cell.layer.cornerRadius = cell.frame.size.width / 2
        cell.layer.masksToBounds = true
        
        return cell
    }




    
    @IBAction func previousMonth(_ sender: Any){
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any){
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool{
        return false
    }
    
    @objc func reloadCalendar() {
        setMonthView()
    }
    func updateLocalize(){
        week1.text = "sun".localized
        week2.text = "mon".localized
        week3.text = "tue".localized
        week4.text = "wed".localized
        week5.text = "thu".localized
        week6.text = "fri".localized
        week7.text = "sat".localized
    }
}
