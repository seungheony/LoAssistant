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
    
    var intermediate_oreha: [Pricechart] = []
    var advanced_oreha: [Pricechart] = []
    
    var ancientAve = 0
    var rareAve = 0
    var orehaAve = 0
    
    var model = MarketModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.model.delegate = self
            self.model.getMarkets(urlString: "http://152.70.248.4:5000/trade/6882701")
            self.model.getMarkets(urlString: "http://152.70.248.4:5000/trade/6882704")
            self.model.getMarkets(urlString: "http://152.70.248.4:5000/trade/6885708")
            
            self.model.getMarkets(urlString: "http://152.70.248.4:5000/trade/6861008")
            self.model.getMarkets(urlString: "http://152.70.248.4:5000/trade/6861009")
        }
//        let price: Int = Int(ancient[0].price) ?? 0
//        let amount: Int = Int(ancient[0].amount) ?? 0
//        print(price)
//        print(amount)

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
        self.ancient = ancient
//        print("ancientRetieved: ")
//        for i in 0...2 {
//            print(self.ancient[i].self)
//        }
    }
    
    func rareRetrieved(rare: [Pricechart]) {
        self.rare = rare
//        print("rareRetrieved")
//        for i in 0...1 {
//            print(self.rare[i].self)
//        }
    }
    
    func orehaRetrieved(oreha: [Pricechart]) {
        self.oreha = oreha
//        print("orehaRetrieved")
//        for i in 0...1 {
//            print(self.oreha[i].self)
//        }
    }
    
    func intermediateRetrieved(intermediate: [Pricechart]) {
        self.intermediate_oreha = intermediate
//        print("intermediateRetrieved: ")
//        for i in 0...2 {
//            print(self.ancient[i].self)
//        }
    }
    
    func advancedRetrieved(advanced: [Pricechart]) {
        self.advanced_oreha = advanced
//        print("advancedRetrieved: ")
//        for i in 0...2 {
//            print(self.ancient[i].self)
//        }
    }
}
