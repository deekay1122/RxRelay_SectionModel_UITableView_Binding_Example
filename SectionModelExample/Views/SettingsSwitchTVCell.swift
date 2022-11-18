//
//  SettingsTVCellWithSwitch.swift
//  PerfectChordBook
//
//  Created by Daisaku Ejiri on 2022/11/18.
//

import UIKit

class SettingsSwitchTVCell: UITableViewCell {

  public static let identifier = "SettingsSwitchTVCell"
  
  lazy var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var _switch: UISwitch = {
    let _switch = UISwitch()
    _switch.translatesAutoresizingMaskIntoConstraints = false
    _switch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    return _switch
  }()
  
  var switchValueChangedHandler: ((Int, Bool) -> Void)!
  
  @objc private func switchValueChanged(_ sender: UISwitch) {
    switchValueChangedHandler(self.tag, sender.isOn)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(label)
    self.contentView.addSubview(_switch)
  }
  
  private func layout() {
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
      label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      
      _switch.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
      _switch.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      
      label.trailingAnchor.constraint(equalTo: _switch.leadingAnchor),
    ])
  }
  
  public func configure(text: String, isOn: Bool?) {
    layout()
    self.label.text = text
    if let isOn = isOn {
      self._switch.isOn = isOn      
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
