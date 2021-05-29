//
//  UITableCell.swift
//  mChars
//
//  Created by f4ni on 29.05.2021.
//

import SnapKit

class TableCell: UITableViewCell {
    
    let imageV: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(imageV)
        imageV.snp.makeConstraints { mk in
            mk.top.bottom.equalToSuperview()
            mk.left.equalToSuperview()
            mk.width.equalTo(self.snp.height)
        }
        textLabel?.snp.makeConstraints({ mk in
            mk.leading.equalTo(imageV.snp.trailing).offset(10)
            mk.trailing.equalToSuperview().offset(10)
        })
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
