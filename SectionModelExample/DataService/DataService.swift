//
//  DataService.swift
//  SectionModelExample
//
//  Created by Daisaku Ejiri on 2022/11/18.
//

import Foundation
import RxRelay

struct Parameter {
  let name: String
  let key: String
  let value: Float?
  let isOn: Bool?
}

enum FretboardOrientation: CaseIterable {
  case horizontal
  case vertical
  
  var name: String {
    switch self {
    case .horizontal:
      return "Horizontal"
    case .vertical:
      return "Vertical"
    }
  }
}

class DataService {
  
  static let shared = DataService()
  
  private init() {
    
  }
  
  private let settingsItemsRelay = BehaviorRelay<[SettingsViewSectionModel]>(value: [])
  
  // public method to get the section model relay
  public func getSettingsItems() -> BehaviorRelay<[SettingsViewSectionModel]> {
    let sections: [SettingsViewSectionModel] = [
      onOrOffSection(),
      parameterSection(),
    ]
    settingsItemsRelay.accept(sections)
    return settingsItemsRelay
  }
  
  // get items per sections
  func parameterSection() -> SettingsViewSectionModel {
    let items: [SettingsItem] = [
      .tempo,
      .guitarVolume,
      .metronomeVolume,
    ]
    return SettingsViewSectionModel(model: .parameter, items: items)
  }
  
  func onOrOffSection() -> SettingsViewSectionModel {
    let items: [SettingsItem] = [
      .isFretboardVertical,
      .isMetronomeOn,
    ]
    return SettingsViewSectionModel(model: .onOrOff, items: items)
  }
  
  public static let isMetronomeOnKey = "Metronome_On"
  public static var isMetronomeOn: Parameter {
    Parameter(name: "Metronome On", key: DataService.isMetronomeOnKey, value: nil, isOn: UserDefaults.standard.bool(forKey: DataService.isMetronomeOnKey))
  }
  
  public static let isFretboardVerticalKey = "Is_Fretboard_Vertical"
  public static var isFretboardVertical: Parameter {
    Parameter(name: "Vertical Fretboard", key: DataService.isFretboardVerticalKey, value: nil, isOn: UserDefaults.standard.bool(forKey: DataService.isFretboardVerticalKey))
  }
  
  public static let tempoValueKey = "Tempo_Value"
  public static var tempoValue: Parameter {
    let value = UserDefaults.standard.integer(forKey: DataService.tempoValueKey)
    return Parameter(name: "Tempo", key: DataService.tempoValueKey, value: value != 0 ? Float(value) : 60, isOn: nil)
  }
  
  public static let guitarVolumeKey = "Guitar_Volume"
  public static var guitarVolume: Parameter {
    let value = UserDefaults.standard.float(forKey: DataService.guitarVolumeKey)
    return Parameter(name: "Guitar Volume", key: DataService.guitarVolumeKey, value: value != 0 ? value : 1.0, isOn: nil)
  }
  
  public static let metronomeVolumeKey = "Metronome_Volume"
  public static var metronomeVolume: Parameter {
    let value = UserDefaults.standard.float(forKey: DataService.metronomeVolumeKey)
    return Parameter(name: "Metronome Volume", key: DataService.metronomeVolumeKey, value: value != 0 ? value : 1.0, isOn: nil)
  }
}
