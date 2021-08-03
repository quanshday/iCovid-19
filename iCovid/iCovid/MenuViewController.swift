//
//  ViewController.swift
//  iCovid
//
//  Created by Mac on 26/07/2021.
//

import UIKit
import Lottie
import Reachability
import CLTypingLabel

class MenuViewController: UIViewController {
    
//    @IBOutlet weak var myTypeWriterLabel: CLTypingLabel!
    @IBOutlet weak var covidLabel: UILabel!
    @IBOutlet weak var viewLotties: UIView!
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    let reviewService = ReviewService.shared

    var str = covid
    let reachability = try! Reachability()
    var iconArr = ["icon_update", "icon_map", "icon_plan", "icon_covid", "icon_doctor", "icon_rating"]
    var titleArr = ["Cập nhật dịch bệnh", "Bản đồ dịch bệnh", "Kế hoạch", "Chi tiết dịch bệnh", "Bác sĩ tư vấn", "Đánh giá chúng tôi"]
    
    var animationView: AnimationView!

    override func viewDidLoad() {
        super.viewDidLoad()

        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.register(MenuCell.nib(), forCellWithReuseIdentifier: MenuCell.identifier)
        
        menuCollectionView.layer.cornerRadius = 30
        menuCollectionView.clipsToBounds = true
        
        //MARK: - Animation Lottie
        viewLotties.layer.cornerRadius = viewLotties.frame.size.width / 2
        viewLotties.clipsToBounds = true
        
        animationView = .init(name: "covid")
        animationView.frame = viewLotties.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        animationView.play()
        viewLotties.addSubview(animationView)
        
//        changeLanguage(str: "vi")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        covidLabel.text = ""
        covidLabel.animation(typing: covid, duration: 0.1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        viewLotties.center.x = view.center.x - 30
//        viewLotties.center.x -= view.bounds.width - 30
//        UIView.animate(withDuration: 2, delay: 0, options: [.curveEaseOut], animations: {
//            self.viewLotties.center.x += self.view.bounds.width - 50
//              self.view.layoutIfNeeded()
//        }, completion: nil)

        if self.animationView?.isAnimationPlaying == false {
           self.animationView?.play()
        }
        
        DispatchQueue.main.async {
        
            self.reachability.whenReachable = { reachability in
                if reachability.connection == .wifi{
                    print("Ok wifi babe")
                }
                else{
                    print("No wifi babe")
                }
                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
            }
                self.reachability.whenUnreachable = { _ in
                    print("No reachable")
                    if let vc = self.storyboard?.instantiateViewController(withIdentifier: "NetworkErrorViewController") as? NetworkErrorViewController{
                        self.present(vc, animated: true, completion: nil)
                    }
                    
                }
                
                do{
                    try self.reachability.startNotifier()
                   
                }catch{
                    print("Unable to start notifier")
                }
            }
    }
    
    deinit{
        reachability.stopNotifier()
    }

//    @IBAction func didTapChangeEnglish(_ sender: Any) {
//
//        changeLanguage(str: "en")
//    }
//
//    @IBAction func didTapChangeVietnam(_ sender: Any) {
//
//        changeLanguage(str: "vi")
//    }
//
//    func changeLanguage(str: String){
//
//        covidLabel.text = covid.addLocalizableString(str: str)
//    }
    
}

extension MenuViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iconArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell
        
        cell.iconImageView.image = UIImage(named: iconArr[indexPath.row])
        cell.titleLabel.text = titleArr[indexPath.row]
        
        return cell
    }
    
    
}

extension MenuViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "UpdateViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
            
        case 1:
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "MapViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
            
        case 2:
            let navigationVC = self.storyboard!.instantiateViewController(withIdentifier: "VaccinesViewController") as! UINavigationController
            self.present(navigationVC, animated: true, completion: nil)
        case 3:
            let vc = storyboard?.instantiateViewController(withIdentifier: "DailyCovidViewController") as! DailyCovidViewController
            present(vc, animated: true, completion: nil)
        case 4:
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorChatbotViewController") as! DoctorChatbotViewController
            self.present(vc, animated: true, completion: nil)
            
        default:
            let activityIndicatorView = UIActivityIndicatorView(style: .large)
            activityIndicatorView.color = UIColor.white
            self.view.addSubview(activityIndicatorView)
            activityIndicatorView.frame = self.view.frame
            activityIndicatorView.center = self.view.center
            activityIndicatorView.startAnimating()
            
            DispatchQueue.main.async {
                let deadline = DispatchTime.now() + .seconds(2)
                DispatchQueue.main.asyncAfter(deadline: deadline) { [weak self] in
                    self?.reviewService.requestReview()
                    activityIndicatorView.stopAnimating()
                }
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.menuCollectionView.frame.width/3-10
        return CGSize(width: width, height: width*1.2)
    }
    
    
}

extension String{
    
    func addLocalizableString(str: String) -> String{
        let path = Bundle.main.path(forResource: str, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

extension UILabel {
    func animation(typing value: String, duration: Double){
        for char in value {
            self.text?.append(char)
            RunLoop.current.run(until: Date() + duration)
        }
    }
}
