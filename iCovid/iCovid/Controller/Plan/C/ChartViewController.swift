//
//  ChartViewController.swift
//  iCovid
//
//  Created by Mac on 28/07/2021.
//

import UIKit
import Charts
import Lottie

class ChartViewController: UIViewController {
    
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var viewLotties: UIView!
    
    var animationView: AnimationView!
    
    var planDetail = PlanDetailModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPieChart()
        
        setViewLottie()
    }
    
    func setViewLottie(){
        //MARK: - Animation Lottie
        
        animationView = .init(name: "tiem")
        animationView.frame = viewLotties.bounds
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        
        animationView.play()
        viewLotties.addSubview(animationView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if self.animationView?.isAnimationPlaying == false {
           self.animationView?.play()
        }
    }
    
    func setupPieChart(){
        
        nameLabel.text = planDetail.name
        rateLabel.text = "\(planDetail.rate ?? 0)" + "%"
        
        chartView.chartDescription?.enabled = false
        chartView.drawHoleEnabled = false
        chartView.rotationAngle = 0
        chartView.rotationEnabled = false
        chartView.isUserInteractionEnabled = false
        
        let planned = Double(planDetail.planned ?? 0)
        let realistic = Double(planDetail.realistic ?? 0)
//        let moderna = Double(vaccines.moderna ?? 0)
        
        let sum = planned + realistic
        
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: planned/(sum) * 100, label: "Kế hoạch"))
        entries.append(PieChartDataEntry(value: realistic/(sum) * 100, label: "Thực tế"))
        
        let dataSet = PieChartDataSet(entries)
        
        let c1 = NSUIColor(hex: 0x577D92)
        let c2 = NSUIColor(hex: 0x6F5187)

        dataSet.colors = [c1, c2]
        dataSet.drawValuesEnabled = false
        
        chartView.data = PieChartData(dataSet: dataSet)
    }
    @IBAction func didTapBackButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}
