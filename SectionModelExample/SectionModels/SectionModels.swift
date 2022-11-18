//
//  SectionModels.swift
//  PerfectChordBook
//
//  Created by Daisaku Ejiri on 2022/11/18.
//

import Foundation
import RxDataSources

typealias SettingsViewSectionModel = SectionModel<SettingsViewSection, SettingsItem>

enum SettingsViewSection {
  case onOrOff
  case parameter
}

enum SettingsItem {
  
  // onOrOff
  case isFretboardVertical
  case isMetronomeOn
  
  // parameter
  case tempo
  case guitarVolume
  case metronomeVolume
  
  var parameter: Parameter {
    switch self {
    case .isFretboardVertical:
      return DataService.isFretboardVertical
    case .isMetronomeOn:
      return DataService.isMetronomeOn
    case .tempo:
      return DataService.tempoValue
    case .guitarVolume:
      return DataService.guitarVolume
    case .metronomeVolume:
      return DataService.metronomeVolume
    }
  }
}
