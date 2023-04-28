//
//  DaysCollectionViewController+Extention.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-28.
//

import UIKit
import CoreData


//MARK: - UICollectionView DataSource
@available(iOS 13.0, *)
extension DaysViewController :UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daysCollection", for: indexPath) as! DayCollectionViewCell
        selectedIndex = indexPath.item
        cell.setupDayLabel(labelText: String(daysCollection[indexPath.row].day))
        cell.plankComplete(isComplete: daysCollection[indexPath.row].isDone)
        cell.currentSecond.text = "\(daysCollection[indexPath.row].initSecond) Sec"
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationVc = TimerViewController()
        destinationVc.plankTime = Int(daysCollection[selectedIndex!].initSecond)
        destinationVc.circularViewDuration = TimeInterval(Int(daysCollection[selectedIndex!].initSecond))
        destinationVc.day = Int(daysCollection[selectedIndex!].day)
        
        navigationController?.pushViewController(destinationVc, animated: true)
    }
}

//MARK: - CoreData

@available(iOS 13.0, *)
extension DaysViewController {
    //CoreDataSave
    func saveCoreData() {
        do{
            try context.save()
            dayCollectionView?.reloadData()
        }catch {
            print("Error Occur while Save data , \(error)")
        }
    }
    //CoreDataLoad
    func loadCoreData() {
        
        let request = NSFetchRequest<Plank>(entityName: "Plank")
        
        do{
            daysCollection = try context.fetch(request)
            dayCollectionView?.reloadData()
        }catch{
            print("Error occur while Load Data , \(error)")
        }
    }
}
