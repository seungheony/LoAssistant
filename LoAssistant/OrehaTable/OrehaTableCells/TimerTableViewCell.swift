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
    
    var item: String?
    var expectedTimeStr: String?
    
    @IBOutlet weak var timeStateLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var remainedTimeLabel: UILabel!
    
    @IBAction func timerButtonTapped(_ sender: Any) {
        timerButton.isSelected = !timerButton.isSelected
        timerButton.setTitle("타이머 초기화", for: .normal)
        guard let itemStr = item else {
            return
        }
        if timerButton.isSelected == true {
            UserDefaults.standard.set(true, forKey: itemStr + "타이머")
            remainedTimeLabel.textColor = UIColor.label
            self.setTimer(item: itemStr)
            self.startTiemr(item: itemStr)
            self.authorizeTimer(item: itemStr)
            
        }
        else {
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            timer?.invalidate()
            
            UserDefaults.standard.set(false, forKey: itemStr + "타이머")
            remainedTimeLabel.textColor = UIColor.secondaryLabel
            timerButton.setTitle(itemStr + " 제작 시작", for: .normal)
            remainedTimeLabel.text = expectedTimeStr
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 여기서부터 앱 재부팅 후 타이머 출력 구현
//        if UserDefaults.standard.string(forKey: "isSettedTimer") == "inter" {
//            expectedTime = UserDefaults.standard.object(forKey: "제작완료시간") as! Date
//            timerButton.isSelected = true
//            timerButton.setTitle("타이머 재설정", for: .normal)
//            startTiemr(item: "inter")
//        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension TimerTableViewCell {
    func authorizeTimer(item: String) {
        let calendar = Calendar.current
        let date = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.expectedTime!)
        
        let nContent = UNMutableNotificationContent() // 로컬알림에 대한 속성 설정 가능
        nContent.title = "제작 완료"
        nContent.subtitle = item + " 오레하 융화 재료"
        nContent.sound = UNNotificationSound.default

        // 알림 발송 조건 객체
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        // 알림 요청 객체
        let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
        // NotificationCenter에 추가
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    func startTiemr(item: String) {
        let currentDate = Date()
        secondsLeft = Int((expectedTime?.timeIntervalSince(currentDate))!)
        //1초마다 타이머 반복 실행
        timer = Timer.init(timeInterval: 1, repeats: true, block: { (t) in
            //남은 시간(초)에서 1초 빼기
            self.secondsLeft -= 1
            // 남은 시간
            let hours = self.secondsLeft / 60 / 60
            //남은 분
            let minutes = self.secondsLeft / 60 % 60
            //그러고도 남은 초
            let seconds = self.secondsLeft % 60 % 60

            //남은 시간(초)가 0보다 크면
            if self.secondsLeft > 0 {
                self.remainedTimeLabel.text = "\(hours)시간 \(minutes)분  \(seconds)초"
                self.timeStateLabel.text = "남은 시간"
                
            } else {
                self.remainedTimeLabel.text = "제작 완료"
            }
        })
        RunLoop.current.add(timer!, forMode: .common)
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
//            //남은 시간(초)에서 1초 빼기
//            self.secondsLeft -= 1
//            // 남은 시간
//            let hours = self.secondsLeft / 60 / 60
//            //남은 분
//            let minutes = self.secondsLeft / 60 % 60
//            //그러고도 남은 초
//            let seconds = self.secondsLeft % 60 % 60
//
//            //남은 시간(초)가 0보다 크면
//            if self.secondsLeft > 0 {
//                self.remainedTimeLabel.text = "\(hours)시간 \(minutes)분  \(seconds)초"
//                self.timeStateLabel.text = "남은 시간"
//                
//            } else {
//                self.remainedTimeLabel.text = "제작 완료"
//            }
//        })
    }
    
    func setTimer(item: String) {
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "노동요") as NSNumber)
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "손놀림") as NSNumber)
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "자동기계") as NSNumber)
        reduction += Double(truncating: UserDefaults.standard.bool(forKey: "제작설계도") as NSNumber)
        let 제작공방 = Double(UserDefaults.standard.integer(forKey: "제작공방")/2)
        reduction += 제작공방 * 0.5
        
        if item == "중급" {
            let inter_time = Int(45 * 60 * (100-reduction) / 100) * 10
            expectedTime = Date(timeIntervalSinceNow: TimeInterval(inter_time))
        } else if item == "상급" {
            let adv_time = Int(60 * 60 * (100-reduction) / 100) * 10
            expectedTime = Date(timeIntervalSinceNow: TimeInterval(adv_time))
        } else if item == "최상급" {
            let adv_time = Int(75 * 60 * (100-reduction) / 100) * 10
            expectedTime = Date(timeIntervalSinceNow: TimeInterval(adv_time))
        }
        UserDefaults.standard.set(expectedTime, forKey: item + "제작완료시간")
        reduction = 0
    }
}
