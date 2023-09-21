//
//  ViewController.swift
//  Boxing Time
//
//  Created by Min Hu on 2023/9/1.
//

import UIKit
// 添加音樂需要先導入負責影音的 AVFoundation
import AVFoundation


class ViewController: UIViewController {
    // 增加 AVAudioPlayer 的 instance 負責播放音樂
    var player = AVPlayer()
    // punchThingSegmentedControl 是上方的沙袋or垃圾桶選項
    @IBOutlet weak var punchThingSegmentedControl: UISegmentedControl!
    // 出拳次數下方的 Label，負責顯示統計點擊的數字
    @IBOutlet weak var punchCountLabel: UILabel!
    // +1 圖片 Image View
    @IBOutlet weak var plusOneImageView: UIImageView!
    // 中央放沙袋與垃圾桶的 Image View
    @IBOutlet weak var sandBagImageView: UIImageView!
    // 右上角放女拳擊手跟男拳擊手的 Image View
    @IBOutlet weak var boxerImageView: UIImageView!
    
    // 預設 segmentedPage 在第一個頁籤，因為第一個的 index 是 0，所以 = 0 。
    var segmentedPageIndex = 0
    // 因為兩個物品的點擊數量要分開儲存，所以各設定一個變數。
    var sandBagPunchCount = 0 // 沙袋點擊數
    var trashCanPunchCount = 0 // 垃圾桶點擊數
    func changeBoxerImage(){
        if boxerImageView.image == UIImage(named: "sports_boxing_woman"){
            boxerImageView.image = UIImage(named: "sports_boxing_corner_woman")
        } else{
                boxerImageView.image = UIImage(named: "sports_boxing_corner_man")
        }
    }
    
    //這裡是 View Controller 一開始必執行的地方，因為剛進入頁面的時候，還沒點擊 segmentedControl，所以沙袋頁沒辦法運作，點了也不會有反應。一定要看到沙袋的 Image View 與沙袋點擊數才會運作。
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 顯示沙袋圖
        sandBagImageView.image = UIImage(named: "boxing_sandbag")
        // +1 圖片先隱藏著
        plusOneImageView.isHidden = true
        // 取得沙袋音效檔案的 url，forResource 傳入檔案名稱，withExtension 傳入附檔名
        let boxingBellUrl = Bundle.main.url(forResource: "boxing-bell", withExtension: "mp3")!
        // 創建 AVPlayerItem，使用 sandBagUrl 作為初始化參數，以準備播放 "punchShort.mp3"
        let boxingBellPlayerItem = AVPlayerItem(url: boxingBellUrl)
        player.replaceCurrentItem(with: boxingBellPlayerItem)
                player.play()
        
    }

    // 在 segmentedControl 點選沙袋或垃圾桶的函數
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        // selectedSegmentIndex 讀取我們點擊了 segmentedControl 中的第幾個頁籤
        segmentedPageIndex = punchThingSegmentedControl.selectedSegmentIndex
        //如果讀取第一個頁籤 沙袋，並且沙袋已被點擊 30 次
        if segmentedPageIndex == 0 && sandBagPunchCount >= 30{
            // 呼叫角落休息的女拳擊手
            boxerImageView.image = UIImage(named: "sports_boxing_corner_woman")
            // 正中央擺沙袋圖
            sandBagImageView.image = UIImage(named: "boxing_sandbag")
            // 出拳次數下方的數字使用沙袋被點擊的記數
            punchCountLabel.text = "\(sandBagPunchCount)"
        } //如果讀取第一個頁籤是沙袋
        else if segmentedPageIndex == 0 {
            // 呼叫女拳擊手圖片
            boxerImageView.image = UIImage(named: "sports_boxing_woman")
            // 正中央擺沙袋圖
            sandBagImageView.image = UIImage(named: "boxing_sandbag")
            // 出拳次數下方的數字使用沙袋被點擊的記數
            punchCountLabel.text = "\(sandBagPunchCount)"
            // 如果讀取第二個頁籤是垃圾桶，並且垃圾桶已被點擊 30 次
        }else if segmentedPageIndex == 1 && trashCanPunchCount >= 30{
            boxerImageView.image = UIImage(named: "sports_boxing_corner_man")
            // 正中央擺垃圾桶圖
            sandBagImageView.image = UIImage(named: "gomi_poribaketsu_close")
            // 出拳次數下方的數字使用沙袋被點擊的記數
            punchCountLabel.text = "\(trashCanPunchCount)"
        } else { //第四選項 如果讀取第二個頁籤是垃圾桶
            // 呼叫男拳擊手圖片
            boxerImageView.image = UIImage(named: "sports_boxing_man")
            // 正中央擺垃圾桶圖
            sandBagImageView.image = UIImage(named: "gomi_poribaketsu_close")
            // 出拳次數下方的數字使用沙袋被點擊的記數
            punchCountLabel.text = "\(trashCanPunchCount)"
        }
        
    }
    
    // 正中央隱形的 Button，被點擊後的動作
    @IBAction func punchCountButton(_ sender: Any) {
        // 取得沙袋音效檔案的 url，forResource 傳入檔案名稱，withExtension 傳入附檔名
        let sandBagUrl = Bundle.main.url(forResource: "punchShort", withExtension: "mp3")!
        // 創建 AVPlayerItem，使用 sandBagUrl 作為初始化參數，以準備播放 "punchShort.mp3"
        let sandBagPlayerItem = AVPlayerItem(url: sandBagUrl)
        // 取得垃圾桶音效檔案的 url
        let trashCanUrl = Bundle.main.url(forResource: "hit-sometingShort", withExtension: "mp3")!
        // 創建 AVPlayerItem，使用 trashCanUrl 作為初始化參數，以準備播放 "hit-sometingShort.mp3"
        let trashCanPlayerItem = AVPlayerItem(url: trashCanUrl)
        // 顯示 +1 圖片
        plusOneImageView.isHidden = false
        // 創建 UIViewPropertyAnimator
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .linear) {
            // 在這裡設定 plusOneImageView 向上移動 5 點
            self.plusOneImageView.frame.origin.y -= 5
        }
                
            // 動畫完成後的處理（這裡隱藏 plusOneImageView 並移回原始位置）
            animator.addCompletion { (position) in
                if position == .end {
                    self.plusOneImageView.isHidden = true
                    self.plusOneImageView.frame.origin.y += 5
                }
            }
                // 開始動畫
                animator.startAnimation()
        
        // 如果被點擊的當下是沙袋圖，並且沙袋已被點擊 30 次
        if sandBagImageView.image == UIImage(named: "boxing_sandbag") && sandBagPunchCount >= 30{
            // 則沙袋被點擊數量 + 1
            sandBagPunchCount += 1
            // +1 後的數字更新到顯示數量的 punchCountLabel 中
            punchCountLabel.text = "\(sandBagPunchCount)"
            // 出現角落休息的女拳擊手
            boxerImageView.image = UIImage(named: "sports_boxing_corner_woman")
            player.replaceCurrentItem(with: sandBagPlayerItem)
                    player.play()
        }
            // 如果被點擊的當下是沙袋圖，
        else if sandBagImageView.image == UIImage(named: "boxing_sandbag"){
            // 則沙袋被點擊數量 + 1
            sandBagPunchCount += 1
            // +1 後的數字更新到顯示數量的 punchCountLabel 中
            punchCountLabel.text = "\(sandBagPunchCount)"
            player.replaceCurrentItem(with: sandBagPlayerItem)
                    player.play()
            // 如果被點擊的當下是垃圾桶圖，並且垃圾桶已被點擊 30 次
        }else if sandBagImageView.image == UIImage(named: "gomi_poribaketsu_close") && trashCanPunchCount >= 30{
            // 則垃圾桶被點擊數量 + 1
            trashCanPunchCount += 1
            // +1 後的數字更新到顯示數量的 punchCountLabel 中
            punchCountLabel.text = "\(trashCanPunchCount)"
            // 出現角落休息的男拳擊手
            boxerImageView.image = UIImage(named: "sports_boxing_corner_man")
            player.replaceCurrentItem(with: trashCanPlayerItem)
                    player.play()
            // 如果被點擊的當下是垃圾桶圖，
        }else if sandBagImageView.image == UIImage(named: "gomi_poribaketsu_close"){
            // 則垃圾桶被點擊數量 + 1
            trashCanPunchCount += 1
            // +1 後的數字更新到顯示數量的 punchCountLabel 中
            punchCountLabel.text = "\(trashCanPunchCount)"
            player.replaceCurrentItem(with: trashCanPlayerItem)
                    player.play()
        }
        
    }
    // 點擊重新來過 Button 的動作
    @IBAction func playAgainButton(_ sender: Any) {
        // 如果被點擊的當下是沙袋圖，
        if sandBagImageView.image == UIImage(named: "boxing_sandbag"){
            // 則沙袋被點擊數量歸 0
            sandBagPunchCount = 0
            // 歸 0 後的數字更新到顯示數量的 punchCountLabel 中
            punchCountLabel.text = "\(sandBagPunchCount)"
            boxerImageView.image = UIImage(named: "sports_boxing_woman")
            // 如果被點擊的當下是垃圾桶圖，
        }else if sandBagImageView.image == UIImage(named: "gomi_poribaketsu_close"){
            // 則垃圾桶被點擊數量歸 0
            trashCanPunchCount = 0
            // 歸 0 後的數字更新到顯示數量的 punchCountLabel 中
            punchCountLabel.text = "\(trashCanPunchCount)"
            boxerImageView.image = UIImage(named: "sports_boxing_man")
        }
        
            
        }

}


















