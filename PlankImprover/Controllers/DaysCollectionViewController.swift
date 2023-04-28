//
//  DaysViewController.swift
//  PlankImprover
//
//  Created by kangajan kuganathan on 2023-04-24.
//

import UIKit

@available(iOS 13.0, *)
class DaysViewController: UIViewController{
    
    //define properties
    var daysCollection = [Plank]()
    var selectedIndex:Int?
    
    func createNextDay(day:Int,second:Int) {
        
        loadCoreData()
        daysCollection[daysCollection.count - 1].isDone = true
        saveCoreData()
        
        //create new day
        let nextPlank = Plank(context: context)
        nextPlank.keepDayCount = daysCollection[daysCollection.count - 1].keepDayCount - 1
        nextPlank.day = Int16(day + 1)
        nextPlank.keepDay = daysCollection[daysCollection.count - 1].keepDay
        nextPlank.isDone = false
        nextPlank.incrementSecond = daysCollection[daysCollection.count - 1].incrementSecond
        if nextPlank.keepDayCount == 0 {
            nextPlank.incrementSecond = daysCollection[daysCollection.count - 1].incrementSecond
            nextPlank.initSecond = Int64(second + Int(nextPlank.incrementSecond))
            nextPlank.keepDayCount = nextPlank.keepDay
        } else {
            nextPlank.initSecond = Int64(second)
        }
        daysCollection.append(nextPlank)
        dayCollectionView?.reloadData()
        saveCoreData()
    }
    
    var dayCollectionView:UICollectionView?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        
        dayCollectionView?.dataSource = self
        dayCollectionView?.delegate = self
        dayCollectionView?.alwaysBounceVertical = true
        dayCollectionView?.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: "daysCollection")
        
        loadCoreData()
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadCoreData()
        
        if daysCollection.isEmpty {
            let userInfoScreen = UserInfoViewController()
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
