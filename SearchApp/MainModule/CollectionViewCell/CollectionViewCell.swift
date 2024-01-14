//
//  CollectionViewCell.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import UIKit
import SnapKit
import SDWebImage

class CollectionViewCell: UICollectionViewCell {
    
//MARK: - imageView
    var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        image.tintColor = .gray
        return image
    }()
//MARK: - titleLabdel
    private var titleLabdel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .sFProDisplay(ofSize: 13,
                                   weight: .bold)
       return label
    }()
    private var descriptionLabdel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .sFProDisplay(ofSize: 12,
                                   weight: .regular)
        label.numberOfLines = 0
        label.textColor = .gray
       return label
    }()
//MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
        setupeConstraint()
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 8
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1,
                                         height: 1)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//MARK: - configures
    func configures(model: listDrugsModel?) {
        guard let mod = model else { return }
        let url = URL(string: "http://shans.d2.i-partner.ru\(mod.image)")
        imageView.sd_setImage(with: url,
                              placeholderImage: UIImage(named: "noFoto"))
        titleLabdel.text = model?.name
        descriptionLabdel.text = model?.description
    }
}
//MARK: - extension
private extension CollectionViewCell {
    func initialization() {
        self.addSubview(imageView)
        self.addSubview(titleLabdel)
        self.addSubview(descriptionLabdel)
    }
//MARK: - setupeConstraint
    func setupeConstraint() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(12)
            make.height.equalTo(82)
        }
        titleLabdel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(12)
            make.height.lessThanOrEqualTo(80)
        }
        descriptionLabdel.snp.makeConstraints { make in
            make.top.equalTo(titleLabdel.snp.bottom).inset(-10)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(12)
            make.height.lessThanOrEqualTo(85)
        }
    }
}
