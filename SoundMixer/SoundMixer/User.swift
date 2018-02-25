//
//  User.swift
//  SoundMixer
//
//  Created by 利穂 虹希 on 2018/02/13.
//  Copyright © 2018年 EdTechTokushima. All rights reserved.
//

import Foundation
import MediaPlayer
class User {
  var Name:String!
  var Id:Int!
  var Playing_1:MPMediaItem?
  var Playing_2:MPMediaItem?
  var Playing_3:MPMediaItem?
  var SelectionFlag:Int = 0
  var BeforeView:String?
  var homeflag:Bool = false
  var musicSetFlag:Bool = false
  var musicSetting = [MusicSetting]()
}
struct MusicSetting {
  var Playing_1:MPMediaItem?
  var Playing_2:MPMediaItem?
  var Playing_3:MPMediaItem?
  var Playing_1_volume:Double
  var Playing_2_volume:Double
  var Playing_3_volume:Double
  var Playing_1_pitch:Double
  var Playing_2_pitch:Double
  var Playing_3_pitch:Double
  var Playing_1_EQflag:Bool
  var Playing_2_EQflag:Bool
  var Playing_3_EQflag:Bool
  var Playing_1_position:Double
  var Playing_2_position:Double
  var Playing_3_position:Double
}
