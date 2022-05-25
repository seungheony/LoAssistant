//
//  OrehaTableViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/03/27.
//

import UIKit

class OrehaTableViewController: UITableViewController {

    var ancient = [Pricechart]()
    var rare = [Pricechart]()
    var oreha = [Pricechart]()
    
    var intermediate_oreha = [Pricechart]()
    var advanced_oreha = [Pricechart]()
    
    var model = MarketModel()
    
    let marketURL: [String] = [ "http://152.70.248.4:5000/trade/6882701", "http://152.70.248.4:5000/trade/6882704",
                                "http://152.70.248.4:5000/trade/6885708", "http://152.70.248.4:5000/trade/6861008",
                                "http://152.70.248.4:5000/trade/6861009" ]
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            
        }
        self.model.delegate = self
        
//        for i in 0...4 {
//            self.model.getMarkets(urlString: marketURL[i])
//        }
        self.model.getMarkets(urlString: marketURL[0])
//        self.model.getMarkets(urlString: marketURL[1])
//        self.model.getMarkets(urlString: marketURL[2])
//
//        self.model.getMarkets(urlString: marketURL[3])
//        self.model.getMarkets(urlString: marketURL[4])
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
        print("ancientRetieved: ")
        for i in 0...ancient.count-1 {
            print(self.ancient[i].self)
        }
        self.model.getMarkets(urlString: marketURL[1])
    }
    
    func rareRetrieved(rare: [Pricechart]) {
        self.rare = rare
        print("rareRetrieved")
        for i in 0...rare.count-1 {
            print(self.rare[i].self)
        }
        self.model.getMarkets(urlString: marketURL[2])
    }
    
    func orehaRetrieved(oreha: [Pricechart]) {
        self.oreha = oreha
        print("orehaRetrieved")
        for i in 0...oreha.count-1 {
            print(self.oreha[i].self)
        }
        self.model.getMarkets(urlString: self.marketURL[3])
    }
    
    func intermediateRetrieved(intermediate: [Pricechart]) {
        self.intermediate_oreha = intermediate
        print("intermediateRetrieved: ")
        for i in 0...intermediate.count-1 {
            print(self.intermediate_oreha[i].self)
        }
        self.model.getMarkets(urlString: self.marketURL[4])
    }
    
    func advancedRetrieved(advanced: [Pricechart]) {
        self.advanced_oreha = advanced
        print("advancedRetrieved: ")
        for i in 0...advanced.count-1 {
            print(self.advanced_oreha[i].self)
        }
    }
}
