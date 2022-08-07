//
//  TimerTableViewCell.swift
//  LoAssistant
//
//  Created by shkim on 2022/08/05.
//

import UIKit
import Foundation

class TimerTableViewCell: UITableViewCell {
    
    var secondsLeft: Int = 0
    var reduction: Double = 0
    var timer: Timer?
    var expectedTime: Date?
    
    @IBOutlet weak var interTimerButton: UIButton!
    @IBOutlet weak var advTimerButton: UIButton!
    
    @IBAction func interTimerTapped(_ sender: Any) {
        if interTimerButton.isSelected == false {
            interTimerButton.isSelected = true
            advTimerButton.isEnabled = false
            interTimerButton.setTitle("알림 재설정", for: .normal)
            UserDefaults.standard.set(true, forKey: "isSettedTimer")
            
            setTimer(item: "inter")
            startTiemr(item: "inter")
            authorizeTimer(item: "inter")
            
        } else {
            interTimerButton.isSelected = false
            advTimerButton.isEnabled = true
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UserDefaults.standard.set(false, forKey: "isSettedTimer")
            timer?.invalidate()
            interTimerButton.setTitle("중급 제작 시작", for: .normal)
            advTimerButton.setTitle("상급 제작 시작", for: .normal)
            
        }
    }
    @IBAction func advTimerTapped(_ sender: Any) {
        if advTimerButton.isSelected == false {
            advTimerButton.isSelected = true
            interTimerButton.isEnabled = false
            advTimerButton.setTitle("알림 재설정", for: .normal)
            UserDefaults.standard.set(true, forKey: "isSettedTimer")
            
            setTimer(item: "adv")
            startTiemr(item: "adv")
            authorizeTimer(item: "adv")
            
        } else {
            advTimerButton.isSelected = false
            interTimerButton.isEnabled = true
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UserDefaults.standard.set(false, forKey: "isSettedTimer")
            timer?.invalidate()
            advTimerButton.setTitle("상급 제작 시작", for: .normal)
            interTimerButton.setTitle("중급 제작 시작", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        interTimerButton.setTitle("중급 제작 시작", for: .normal)
        advTimerButton.setTitle("상급 제작 시작", for: .normal)
        
        // 여기서부터 앱 재부팅 후 타이머 출력 구현
//        if UserDefaults.standard.bool(forKey: "isSettedTimer") == true {
//
//        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension TimerTableViewCell {
    func authorizeTimer(item: String) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
                        
            if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                /*
                 로컬 알림을 발송할 수 있는 상태이면
                 - 유저의 동의를 구한다.
                 */
                let calendar = Calendar.current
                let date = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.expectedTime!)
                let nContent = UNMutableNotificationContent() // 로컬알림에 대한 속성 설정 가능
                if item == "inter" {
                    nContent.title = "제작 완료"
                    nContent.subtitle = "중급 오레하 융화 재료"
//
//                    date.hour = 17
//                    date.minute = 24
                } else if item == "adv" {
                    nContent.title = "제작 완료"
                    nContent.subtitle = "상급 오레하 융화 재료"
                    
//                    date.hour = 17
//                    date.minute = 24
                }
                nContent.sound = UNNotificationSound.default
                
                // 알림 발송 조건 객체
                let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
                // 알림 요청 객체
                let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                // NotificationCenter에 추가
                UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            } else {
                NSLog("User not agree")
            }
        }
    }
    
    func startTiemr(item: String) {
        let currentDate = Date()
        secondsLeft = Int((expectedTime?.timeIntervalSince(currentDate))!)
        //1초마다 타이머 반복 실행
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
            //남은 시간(초)에서 1초 빼기
            self.secondsLeft -= 1
            //남은 분
            let minutes = self.secondsLeft / 60
            //그러고도 남은 초
            let seconds = self.secondsLeft % 60

            //남은 시간(초)가 0보다 크면
            if self.secondsLeft > 0 {
                if item == "inter" {
                    self.advTimerButton.setTitle("남은 시간: \(minutes):\(seconds)", for: .normal)
                } else if item == "adv" {
                    self.interTimerButton.setTitle("남은 시간: \(minutes):\(seconds)", for: .normal)
                }
            } else {
                if item == "inter" {
                    self.advTimerButton.setTitle("중급 제작 완료", for: .normal)
                } else if item == "adv" {
                    self.interTimerButton.setTitle("상급 제작 완료", for: .normal)
                }
            }
        })
    }
    
    func setTimer(item: String) {
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "노동요") as NSNumber)
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "손놀림") as NSNumber)
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "자동기계") as NSNumber)
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "제작설계도") as NSNumber)
        let 제작공방 = Double(UserDefaults.standard.integer(forKey: "제작공방")/2)
        reduction += 제작공방 * 0.5
        
        if item == "inter" {
            let inter_time = Int(45 * 60 * (100-reduction) / 100)
            expectedTime = Date(timeIntervalSinceNow: TimeInterval(inter_time))
            UserDefaults.standard.set(expectedTime, forKey: "제작완료시간")
        } else if item == "adv" {
            let adv_time = Int(60 * 60 * (100-reduction) / 100)
            expectedTime = Date(timeIntervalSinceNow: TimeInterval(adv_time))
            UserDefaults.standard.set(expectedTime, forKey: "제작완료시간")
        }
        
        
    }
}
