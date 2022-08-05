//
//  TimerTableViewCell.swift
//  LoAssistant
//
//  Created by shkim on 2022/08/05.
//

import UIKit

class TimerTableViewCell: UITableViewCell {
    
    var item: String = String()
    // 남은 제작 시간
    var totalTimeLeft: Int = 130
    var minutesLeft: Int = 0
    var secondsLeft: Int = 0
    var timer: Timer?
    
    @IBOutlet weak var interTimerButton: UIButton!
    @IBOutlet weak var advTimerButton: UIButton!
    
    
    @IBAction func interTimerTapped(_ sender: Any) {
        if interTimerButton.isSelected == false {
            interTimerButton.isSelected = true
            
        } else {
            interTimerButton.isSelected = false
            
        }
    }
    @IBAction func advTimerTapped(_ sender: Any) {
        if advTimerButton.isSelected == false {
            advTimerButton.isSelected = true
            
        } else {
            advTimerButton.isSelected = false
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        interTimerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        advTimerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TimerTableViewCell {
    func authorizeTimer() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
                        
            if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                /*
                 로컬 알림을 발송할 수 있는 상태이면
                 - 유저의 동의를 구한다.
                 */
                var date = DateComponents()
                let nContent = UNMutableNotificationContent() // 로컬알림에 대한 속성 설정 가능
                if self.item == "inter" {
                    nContent.title = "제작 완료"
                    nContent.subtitle = "중급 오레하 융화 재료"
                    
                    date.hour = 17
                    date.minute = 19
                } else if self.item == "adv" {
                    nContent.title = "제작 완료"
                    nContent.subtitle = "상급 오레하 융화 재료"
                    
                    date.hour = 17
                    date.minute = 19
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
}
