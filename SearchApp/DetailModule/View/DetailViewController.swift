//
//  DetailViewController.swift
//  SearchApp
//
//  Created by Vasiliy Vygnych on 12.01.2024.
//

import UIKit
import SnapKit
import SDWebImage

class DetailViewController: UIViewController {
    
    var presenter: DetailPresenterProtocol?
    
//MARK: - UIView
    private var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    private var infoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(named: "gray")?.cgColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 8
        return button
    }()
    private var bayViewTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .sFProDisplay(ofSize: 12,
                                   weight: .bold)
        label.text = "ГДЕ КУПИТЬ"
        label.textAlignment = .center
        return label
    }()
//MARK: - UIImageView
    private var imageLogo: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = .gray
        return image
    }()
    private var previewImage: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.tintColor = .gray
        return image
    }()
    private var imageView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "imageView")
        return image
    }()
//MARK: - UILabel
    private var titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .sFProDisplay(ofSize: 20,
                                   weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private var descriptionLabdel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .sFProDisplay(ofSize: 15,
                                   weight: .regular)
        label.numberOfLines = 0
        label.textColor = .gray
       return label
    }()
//MARK: - UIButton
    private var favouritesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "star"),
                                  for: .normal)
        button.tintColor = .gray
        return button
    }()
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupeView()
        setupeButton()
        setupeConstraint()
        presenter?.viewDidLoad()
    }
//MARK: - setupeView
    private func setupeView() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        view.addSubview(contentView)
        contentView.addSubview(imageLogo)
        contentView.addSubview(previewImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabdel)
        contentView.addSubview(favouritesButton)
        contentView.addSubview(infoButton)
        infoButton.addSubview(bayViewTitle)
        infoButton.addSubview(imageView)
    }
//MARK: - setupeButton
    private func setupeButton() {
        favouritesButton.addTarget(self,
                                   action: #selector(favourites),
                                   for: .touchUpInside)
        infoButton.addTarget(self,
                             action: #selector(info),
                             for: .touchUpInside)
        let backButton: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                          style: .plain,
                                                          target: self,
                                                          action: #selector(back))
        backButton.tintColor = .white
        navigationItem.leftBarButtonItem = backButton
    }
//MARK: - @objc func favourites
    @objc func favourites() {
        if favouritesButton.currentBackgroundImage == UIImage(systemName: "star") {
                favouritesButton.setBackgroundImage(UIImage(systemName: "star.fill"),
                                              for: .normal)
                favouritesButton.tintColor = .systemOrange
        } else {
            favouritesButton.setBackgroundImage(UIImage(systemName: "star"),
                                              for: .normal)
            favouritesButton.tintColor = .gray
        }
    }
//MARK: - @objc func back & info
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    @objc func info() {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            self.infoButton.transform = CGAffineTransform(scaleX: 0.75,
                                                          y: 0.75)
            self.infoButton.backgroundColor = .lightGray
        }, completion: { finished in
            print("где купить")
        })
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            self.infoButton.transform = CGAffineTransform(scaleX: 1,
                                                          y: 1)
            self.infoButton.backgroundColor = .white
        }, completion: nil)
    }
//MARK: - setupeConstraint
    private func setupeConstraint() {
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(98)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        imageLogo.snp.makeConstraints { make in
            make.top.equalTo(26)
            make.height.width.equalTo(32)
            make.left.equalTo(16)
        }
        previewImage.snp.makeConstraints { make in
            make.top.equalTo(26)
            make.width.equalTo(150)
            make.height.equalTo(230)
            make.centerX.equalToSuperview()
        }
        favouritesButton.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.height.width.equalTo(30)
            make.right.equalTo(-16)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(previewImage.snp.bottom).inset(-20)
            make.width.equalTo(180)
            make.height.equalTo(28)
            make.left.equalTo(10)
        }
        descriptionLabdel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-10)
            make.width.equalTo(328)
            make.height.equalTo(44)
            make.left.equalTo(10)
        }
        infoButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabdel.snp.bottom).inset(-40)
            make.centerX.equalToSuperview()
            make.left.equalTo(10)
            make.width.equalToSuperview().inset(10)
            make.height.equalTo(36)
        }
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(13.75)
            make.height.equalTo(17.5)
            make.left.equalTo(bayViewTitle.snp.left).inset(-10)
        }
        bayViewTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(20)
        }
    }
}
//MARK: - extension DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func dataSet(model: listDrugsModel) {
        let logoUrl = URL(string: "http://shans.d2.i-partner.ru\(model.categories.icon)")
        imageLogo.sd_setImage(with: logoUrl,
                              placeholderImage: UIImage(systemName: "photo.circle"))
        let previewUrl = URL(string: "http://shans.d2.i-partner.ru\(model.image)")
        previewImage.sd_setImage(with: previewUrl,
                                 placeholderImage: UIImage(named: "noFoto"))
        titleLabel.text = model.name
        descriptionLabdel.text = model.description
    }
}
