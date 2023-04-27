//
//  DaysViewController.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-24.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
class DaysViewController: UIViewController{
    
    var daysCollection = [Plank]()
    var selectedIndex:Int?
    
    //save
    func saveCoreData() {
        do{
            try context.save()
            dayCollectionView?.reloadData()
        }catch {
            print("Error Occur while Save data , \(error)")
        }
    }
    //load
    func loadCoreData() {
        
        let request = NSFetchRequest<Plank>(entityName: "Plank")
        
        do{
            daysCollection = try context.fetch(request)
            dayCollectionView?.reloadData()
        }catch{
            print("Error occur while Load Data , \(error)")
        }
    }
    
    func createNextDay(day:Int,second:Int) {
        
        loadCoreData()
        daysCollection[daysCollection.count - 1].isDone = true
        saveCoreData()
        
        //create new day
        let nextPlank = Plank(context: context)
        nextPlank.day = Int16(day + 1)
        nextPlank.isDone = false
        nextPlank.incrementSecond = daysCollection[daysCollection.count - 1].incrementSecond
        nextPlank.initSecond = Int64(second + Int(nextPlank.incrementSecond))
        
        daysCollection.append(nextPlank)
        dayCollectionView?.reloadData()
        print("created next Day \(daysCollection.count)")
        saveCoreData()
    }
    
    var dayCollectionView:UICollectionView?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        dayCollectionView?.dataSource = self
        dayCollectionView?.delegate = self
        dayCollectionView?.alwaysBounceVertical = true
        dayCollectionView?.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: "daysCollection")
        
        
        loadCoreData()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor(red:0.0, green:0.50 ,blue:0.47 , alpha:0.47)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        loadCoreData()
        
        if daysCollection.isEmpty {
            var userInfoScreen = UserInfoViewController()
            navigationController?.pushViewController(userInfoScreen, animated: false)
        }
        
    }
    
    override func loadView() {
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        layout.itemSize = CGSize(width: 99, height: 103)
        layout.scrollDirection = .vertical
        
        dayCollectionView = UICollectionView(frame: .zero,collectionViewLayout: layout)
        self.view = dayCollectionView
    }
}

//MARK: - UICollectionView DataSource
@available(iOS 13.0, *)
extension DaysViewController :UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("coun t= \(daysCollection.count)")
        return daysCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daysCollection", for: indexPath) as! DayCollectionViewCell
        selectedIndex = indexPath.item
        cell.setupDayLabel(labelText: String(daysCollection[indexPath.row].day))
        cell.plankComplete(isComplete: daysCollection[indexPath.row].isDone)
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
