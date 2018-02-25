//
//  SecondViewController.swift
//  SoundMixer
//
//  Created by 利穂 虹希 on 2018/02/13.
//  Copyright © 2018年 EdTechTokushima. All rights reserved.
//

import UIKit
import MediaPlayer
class PlayerViewController: UIViewController, MPMediaPickerControllerDelegate {
  var audioPlayer:AVAudioPlayer?
  var PlayingSong:MPMediaItem!
  var player = MPMusicPlayerController()
  var user:User = User()
  //作り直したストーリーボードではこのボタン関数消して新しいボタン関数でこの中に書いてる関数動かせば大丈夫
  /*
  @IBAction func Play(_ sender: Any) {
    self.playMusic(whitchmusic: 1)
  }
 */
  //これも．こっちは音楽２上野が音楽1に対応してる
  /*
  @IBAction func Play2(_ sender: Any) {
    self.playMusic(whitchmusic: 2)
  }
 */
  func playMusic(whitchmusic: Int){
    var errorMes:String = "音楽１と音楽2に"
    // 選択した曲情報がPlayingSongに入っているので、これをplayerにセット。
    print("play")
    switch whitchmusic {
    case 1:
      self.PlayingSong = self.user.Playing_1
      errorMes = "音楽1に"
    case 2:
      errorMes = "音楽2に"
      self.PlayingSong = self.user.Playing_2
    case 3:
      errorMes = "音楽3に"
      self.PlayingSong = self.user.Playing_3
    default:
      print("フラグが立っていませんmusicselection")
      print(self.user.SelectionFlag)
    }
    
    if(PlayingSong != nil){
      print(PlayingSong.value(forProperty: MPMediaItemPropertyTitle)!)
      let url: URL  = PlayingSong.value(forProperty: MPMediaItemPropertyAssetURL) as! URL
      //  let url: NSURL = PlayingSong.valueForProperty(MPMediaItemPropertyAssetURL) as! NSURL
      //  if  url != nil {
      do {
        // itemのassetURLからプレイヤーを作成する
        audioPlayer = try AVAudioPlayer(contentsOf: url , fileTypeHint: nil)
      } catch  {
        // エラー発生してプレイヤー作成失敗
        // messageLabelに失敗したことを表示
        print( "この音楽は再生できません")
        audioPlayer = nil
        // 戻る
        return
      }
      // 再生開始
      if let player = audioPlayer {
        player.play()
        // メッセージラベルに曲タイトルを表示
        // (MPMediaItemが曲情報を持っているのでそこから取得)
        //   let title = item.title ?? ""
        // messageLabel.text = title
      }
    }else{
      print(errorMes)
      print("音楽が選択されていません")
    }
    self.user.SelectionFlag = 0
    
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.receiveData()
  }
  func receiveData(){
    if let appDelegate = UIApplication.shared.delegate as! AppDelegate!{
      self.user = appDelegate.user
    }
  }
  override func viewWillDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    self.user.BeforeView = "player"
    self.setSendData()
    print("player sendData finished")
  }
  func setSendData(){
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    appDelegate.user = self.user
    if(self.user.Playing_1 != nil){
      let music1 = self.user.Playing_1?.value(forProperty: MPMediaItemPropertyTitle)! as! String
      print("player music")
      print(music1)
    }
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    //  player = MPMusicPlayerController.applicationMusicPlayer()
    // Do any additional setup after loading the view, typically from a nib.
    // player = MPMusicPlayerController.applicationMusicPlayer()
    //player = MPMusicPlayerController.systemMusicPlayer()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}



/*
 import UIKit
 import MediaPlayer
 import AVFoundation
 
 class PlayerViewController: UIViewController, MPMediaPickerControllerDelegate {
 var audioPlayer:AVAudioPlayer?
 var PlayingSong:MPMediaItem!
 var PlayingSong2:MPMediaItem!
 // player = AudioEnginePlayer.sharedInstance
 var player = AudioEnginePlayer()
 var player2 = AudioEnginePlayer()
 
 @IBAction func Play(_ sender: Any) {
 // 選択した曲情報がPlayingSongに入っているので、これをplayerにセット。
 print("play")
 print(PlayingSong.value(forProperty: MPMediaItemPropertyTitle)!)
 print(PlayingSong2.value(forProperty: MPMediaItemPropertyTitle)!)
 if(PlayingSong != nil){
 let url: URL  = PlayingSong.value(forProperty: MPMediaItemPropertyAssetURL) as! URL
 let url2: URL  = PlayingSong2.value(forProperty: MPMediaItemPropertyAssetURL) as! URL
 
 do {
 player.audioFile = try AVAudioFile(forReading: url)
 player2.audioFile = try AVAudioFile(forReading: url2)
 }
 catch {
 print("OWAOWARI")
 return
 }
 player.audioEngine.connect(player.audioPlayerNode, to: player.audioUnitTimePitch, format: player.audioFile.processingFormat)
 
 //player.audioEngine.connect(player.audioUnitTimePitch, to: player.audioEngine.mainMixerNode, fromBus: 0, toBus: 0, format: player.audioFile.processingFormat)
 
 //  イコライザを適用する場合は以下を使用
 
 player.audioEngine.connect(player.audioUnitTimePitch, to: player.audioUnitEQ, fromBus: 0, toBus: 0, format: player.audioFile.processingFormat)
 player.audioEngine.connect(player.audioUnitEQ, to: player.audioEngine.mainMixerNode, fromBus: 0, toBus: 0, format: player.audioFile.processingFormat)
 
 
 player2.audioEngine.connect(player2.audioPlayerNode, to: player2.audioUnitTimePitch, format: player2.audioFile.processingFormat)
 //player2.audioEngine.connect(player2.audioUnitTimePitch, to: player2.audioEngine.mainMixerNode, fromBus: 0, toBus: 1, format: player2.audioFile.processingFormat)
 
 //  イコライザを適用する場合は以下を使用
 
 player2.audioEngine.connect(player2.audioUnitTimePitch, to: player2.audioUnitEQ, fromBus: 0, toBus: 0, format: player2.audioFile.processingFormat)
 player2.audioEngine.connect(player2.audioUnitEQ, to: player2.audioEngine.mainMixerNode, fromBus: 0, toBus: 1, format: player2.audioFile.processingFormat)
 
 
 
 
 player.audioEngine.prepare()
 player2.audioEngine.prepare()
 
 if player.playing {
 player.pause()
 player2.pause()
 } else {
 player.audioEngine.mainMixerNode.outputVolume = 1.0
 player2.audioEngine.mainMixerNode.outputVolume = 1.0
 player.play()
 player2.play()
 }
 }
 }
 
 
 @IBOutlet weak var pitchSlider: UISlider!
 @IBAction func changePitch(_ sender: Any) {
 player.audioUnitTimePitch.pitch = pitchSlider.value
 }
 
 override func viewDidLoad() {
 super.viewDidLoad()
 //  player = MPMusicPlayerController.applicationMusicPlayer()
 // Do any additional setup after loading the view, typically from a nib.
 // player = MPMusicPlayerController.applicationMusicPlayer()
 //player = MPMusicPlayerController.systemMusicPlayer()
 }
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 }
 
 
 }
*/
