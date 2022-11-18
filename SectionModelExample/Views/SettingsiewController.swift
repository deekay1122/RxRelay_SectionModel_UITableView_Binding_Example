//
//  ViewController.swift
//  SectionModelExample
//
//  Created by Daisaku Ejiri on 2022/11/18.
//

import UIKit
import RxSwift
import RxDataSources

class SettingsiewController: UIViewController {

  let dataService = DataService.shared
  let bag = DisposeBag()
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.register(SettingsSwitchTVCell.self, forCellReuseIdentifier: SettingsSwitchTVCell.identifier)
    tableView.register(SettingsParameterTVCell.self, forCellReuseIdentifier: SettingsParameterTVCell.identifier)
    tableView.rowHeight = 40
    return tableView
  }()
  
  lazy var datasource = RxTableViewSectionedReloadDataSource<SettingsViewSectionModel>(configureCell: configureCell)
  
  lazy var configureCell: RxTableViewSectionedReloadDataSource<SettingsViewSectionModel>.ConfigureCell = { [weak self] (dataSource, tableView, indexPath, _) in
    let item = dataSource[indexPath]
    switch item {
    case .isFretboardVertical:
      let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSwitchTVCell.identifier, for: indexPath) as! SettingsSwitchTVCell
      // not using the tag info in this case, but can save it as index
      cell.tag = indexPath.row
      cell.configure(text: item.parameter.name, isOn: item.parameter.isOn)
      cell.switchValueChangedHandler = { [weak self] _, isOn in
        // using item.parameter.key to store bool value in UserDefaults
        UserDefaults.standard.set(isOn, forKey: item.parameter.key)
      }
      return cell
    case .isMetronomeOn:
      let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSwitchTVCell.identifier, for: indexPath) as! SettingsSwitchTVCell
      cell.tag = indexPath.row
      cell.configure(text: item.parameter.name, isOn: item.parameter.isOn)
      cell.switchValueChangedHandler = { [weak self] _, isOn in
        UserDefaults.standard.set(isOn, forKey: item.parameter.key)
      }
      return cell
    case .tempo:
      let cell = tableView.dequeueReusableCell(withIdentifier: SettingsParameterTVCell.identifier, for: indexPath) as! SettingsParameterTVCell
      cell.tag = indexPath.row
      cell.configure(text: item.parameter.name)
      var intValue: Int = 0
      if let floatValue = item.parameter.value {
        intValue = Int(floatValue)
      }
      cell.valueLabel.text = "\(intValue)"
      cell.buttonHandler = { [weak self] _, value in
        intValue += value
        intValue = min(max(20, intValue), 400)
        cell.valueLabel.text = "\(intValue)"
        UserDefaults.standard.set(intValue, forKey: item.parameter.key)
      }
      return cell
    case .guitarVolume:
      let cell = tableView.dequeueReusableCell(withIdentifier: SettingsParameterTVCell.identifier, for: indexPath) as! SettingsParameterTVCell
      cell.tag = indexPath.row
      cell.configure(text: item.parameter.name)
      var floatValue: Float = 0
      if let stroredFloatValue = item.parameter.value {
        floatValue = stroredFloatValue
      }
      cell.valueLabel.text = String(format: "%.1f", floatValue)
      cell.buttonHandler = { [weak self] _, value in
        // converting the button value to 0.1 or -0.1 for increment/decrementing
        floatValue += Float(value) / 10.0
        // assuring the float value is in between 0.0 and 1.0
        floatValue = min(max(floatValue, 0.0), 1.0)
        // formatting the floatValue to only have 1 decimal floating number
        cell.valueLabel.text = String(format: "%.1f", floatValue)
        // updating in UserDefaults for retention
        UserDefaults.standard.set(floatValue, forKey: item.parameter.key)
      }
      return cell
    case .metronomeVolume:
      let cell = tableView.dequeueReusableCell(withIdentifier: SettingsParameterTVCell.identifier, for: indexPath) as! SettingsParameterTVCell
      cell.tag = indexPath.row
      cell.configure(text: item.parameter.name)
      var floatValue: Float = 0
      if let storedFloatValue = item.parameter.value {
        floatValue = storedFloatValue
      }
      cell.valueLabel.text = String(format: "%.1f", floatValue)
      cell.buttonHandler = { [weak self] _, value in
        floatValue += Float(value) / 10.0
        floatValue = min(max(floatValue, 0.0), 1.0)
        cell.valueLabel.text = String(format: "%.1f", floatValue)
        UserDefaults.standard.set(floatValue, forKey: item.parameter.key)
      }
      return cell
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    view.addSubview(tableView)
    
    dataService.getSettingsItems().asObservable()
      .bind(to: tableView.rx.items(dataSource: datasource))
      .disposed(by: bag)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    layout()
  }
  
  private func layout() {
    tableView.frame = view.bounds
  }
}

