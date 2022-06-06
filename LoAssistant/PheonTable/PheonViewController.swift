//
//  PheonViewController.swift
//  LoAssistant
//
//  Created by 김승헌 on 2022/06/05.
//

import UIKit

class PheonViewController: UIViewController {

    @IBOutlet weak var pheonAmount: UITextField!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button30: UIButton!
    @IBOutlet weak var button100: UIButton!
    
    @IBOutlet weak var calculate: UIButton!
    
    @IBOutlet weak var goldPerPheon: UILabel!
    @IBOutlet weak var result: UILabel!
    
    
    var pheonCount: Int = 0
    var crystal: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(crystal
        )
        pheonAmount.keyboardType = .numberPad
        pheonAmount.endEditing(true)
        
        button1.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button30.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button100.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        calculate.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func priceButton(_ sender: UIButton) {
        
        pheonAmount.endEditing(true)
        
        button1.isSelected = false
        button30.isSelected = false
        button100.isSelected = false
        
        // 선택된 sender만 true로 바뀜
        sender.isSelected = true
    }
    @IBAction func calculate(_ sender: Any) {
        pheonAmount.endEditing(true)
        
        let pheon = pheonAmount.text!
        // bill이 empty가 아니라면 실행
        if pheon != "" {
            if button1.isSelected {
                pheonCount = Int(pheon)!
                
                goldPerPheon.text = String(pheonCount) + " 페온당"
                let gold = crystal / 19 * 2
                result.text = String(Int(gold)*pheonCount) + " G"
            }
            else if button30.isSelected {
                pheonCount = Int(pheon)!
                
                goldPerPheon.text = String(pheonCount) + " 페온당"
                let gold = crystal / 19 * 54 / 30
                result.text = String(Int(gold)*pheonCount) + " G"
            }
            else if button100.isSelected {
                pheonCount = Int(pheon)!
                
                goldPerPheon.text = String(pheonCount) + " 페온당"
                let gold = crystal / 19 * 170 / 100
                result.text = String(Int(gold)*pheonCount) + " G"

            }
            //String타입의 bill을 Double타입으로 변경
            
            
//            5크리스탈 당 골드
//            -> 골드 / 19 * 170 = 100페온당 골드 / 100 -> 1페온당 골드
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
