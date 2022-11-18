//
//  SettingsParameterTVCell.swift
//  PerfectChordBook
//
//  Created by Daisaku Ejiri on 2022/11/18.
//

import UIKit

class SettingsParameterTVCell: UITableViewCell {

  public static let identifier = "SettingsParameterTVCell"
  
  lazy var label: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  lazy var _switch: UISwitch = {
    let _switch = UISwitch()
    _switch.translatesAutoresizingMaskIntoConstraints = false
    return _switch
  }()
  
  lazy var plusButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "plus"), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.contentVerticalAlignment = .fill
    button.contentHorizontalAlignment = .fill
    button.tintColor = .black
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 3
    button.layer.masksToBounds = true
    button.tag = 1
    button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    return button
  }()
  
  lazy var minusButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setImage(UIImage(systemName: "minus"), for: .normal)
    button.imageView?.contentMode = .scaleAspectFit
    button.contentVerticalAlignment = .fill
    button.contentHorizontalAlignment = .fill
    button.tintColor = .black
    button.layer.borderColor = UIColor.black.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 3
    button.layer.masksToBounds = true
    button.tag = -1
    button.addTarget(self, action: #selector(onButtonTapped), for: .touchUpInside)
    return button
  }()
  
  var buttonHandler: ((Int, Int) -> Void)!
  
  @objc private func onButtonTapped(_ sender: UIButton) {
    buttonHandler(self.tag, sender.tag)
  }
  
  lazy var valueLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = label.font.withSize(20)
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .center
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.contentView.addSubview(label)
    self.contentView.addSubview(plusButton)
    self.contentView.addSubview(valueLabel)
    self.contentView.addSubview(minusButton)
    layout()
  }
  
  private func layout() {
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
      label.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      
      plusButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
      plusButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      plusButton.widthAnchor.constraint(equalToConstant: 20),
      plusButton.heightAnchor.constraint(equalToConstant: 25),
      
      valueLabel.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor),
      valueLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
      valueLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
      valueLabel.widthAnchor.constraint(equalToConstant: 50),
      
      minusButton.trailingAnchor.constraint(equalTo: valueLabel.leadingAnchor),
      minusButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
      minusButton.widthAnchor.constraint(equalToConstant: 20),
      minusButton.heightAnchor.constraint(equalToConstant: 25),
      
      label.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor),
    ])
  }
  
  public func configure(text: String) {
    self.label.text = text
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
