//
//  DailyCovidViewController.swift
//  iCovid
//
//  Created by Mac on 30/07/2021.
//

import UIKit
import Lottie

class DailyCovidViewController: UIViewController {
    
    @IBOutlet weak var viewLotties: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var covidLabel: UILabel!
    
    var dailyCovid = [DailyCovidModel]()
    
    var animationView : AnimationView!
    
    var aView: UIView?
    var timer : Timer?
    var currentIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.layer.cornerRadius = 10
        collectionView.clipsToBounds = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CovidCollectionViewCell.nib(), forCellWithReuseIdentifier: CovidCollectionViewCell.identifier)
        
        dailyCovidAPI()
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.changCell), userInfo: nil, repeats: true)
        }
        
        animationView = .init(name: "poster")
        animationView.frame = viewLotties.bounds
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        
        animationView.play()
        viewLotties.addSubview(animationView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        covidLabel.text = ""
        covidLabel.animation(typing: covid, duration: 0.1)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.animationView.isAnimationPlaying == false{
            self.animationView.play()
        }
        
    }
    
    @objc func changCell(){
        
        if currentIndex < dailyCovid.count - 1{
            currentIndex = currentIndex + 1
        }
        else {
            currentIndex = 0
        }
        
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .right, animated: true)
    }
    
    func dailyCovidAPI(){
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor.white
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.frame = self.view.frame
        activityIndicatorView.center = self.view.center
        activityIndicatorView.startAnimating()
        
        DispatchQueue.main.async {
            APIManager.shared.dailyCovidAPI {(daily) in
                self.dailyCovid = daily.sorted(by: { (model1, model2) in
                    return model1.date ?? "" > model2.date ?? ""
                })
                self.collectionView.reloadData()
                activityIndicatorView.stopAnimating()
            }
        }
        
        
    }

    @IBAction func didTapBackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension DailyCovidViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyCovid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CovidCollectionViewCell.identifier, for: indexPath) as! CovidCollectionViewCell
        cell.setCovid(covid: dailyCovid[indexPath.row])
        return cell
    }
    
    
}

extension DailyCovidViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 330, height: 240)
    }
}

//extension DailyCovidViewController{
//
//    func showSpinner(){
//        aView = UIView(frame: self.view.bounds)
//        aView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
//
//        let ai = UIActivityIndicatorView(style: .whiteLarge)
//        ai.center = aView!.center
//        ai.startAnimating()
//        aView?.addSubview(aView!)
//    }
//}


