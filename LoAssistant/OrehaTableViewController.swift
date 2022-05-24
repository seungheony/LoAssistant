//
//  OrehaTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/03/27.
//

import UIKit

class OrehaTableViewController: UITableViewController {
    var ancient: [Pricechart] = []
    var rare: [Pricechart] = []
    var oreha: [Pricechart] = []
    
    var ancientAve = 0
    var rareAve = 0
    var orehaAve = 0
    
    var model = MarketModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self
        model.getMarkets(urlString: "http://152.70.248.4:5000/trade/6882701")
        model.getMarkets(urlString: "http://152.70.248.4:5000/trade/6882704")
        model.getMarkets(urlString: "http://152.70.248.4:5000/trade/6885708")
        let price: Int = Int(ancient[0].price) ?? 0
        let amount: Int = Int(ancient[0].amount) ?? 0
        print(price)
        print(amount)
//        print(ancientAve)
//        print(rareAve)
//        print(orehaAve)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){
            return 0
        }
        else if(section == 1){
            return 3
        }
        else if(section == 2){
            return 2
        }
        else {
            return 2
        }
    }
}

extension OrehaTableViewController:MarketModelProtocol {
    
    func ancientRetrieved(ancient: [Pricechart]) {
        for i in 0...2 {
            self.ancient = ancient
            print(i)
            print(ancient[i].self)
        }
    }
    
    func rareRetrieved(rare: [Pricechart]) {
        for i in 0...1 {
            let price: Int = Int(rare[i].price) ?? 0
            let amount: Int = Int(rare[i].amount) ?? 0
            self.rareAve+=price*(amount/100)
        }
//        self.rareAve/=2
//        print(self.rareAve)
    }
    
    func orehaRetrieved(oreha: [Pricechart]) {
        
        for i in 0...1 {
            let price: Int = Int(oreha[i].price) ?? 0
            let amount: Int = Int(oreha[i].amount) ?? 0
            self.orehaAve+=price*(amount/100)
        }
//        self.orehaAve/=2
//        print(self.orehaAve)
    }
}
