//
//  PhotosCell.swift
//  PhotoLibrary
//
//  Created by Timofey Kharitonov on 05.02.2022.
//

import UIKit
import SDWebImage

class PhotosCell: UICollectionViewCell {
    
    static let reuseId = "PhotosCell"
    
    private let checkMark: UIImageView = {
        let image = UIImage(named: "success")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0
        return imageView
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false // фиксирование данного элемента на ячейке с помощью кода
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    var unsplashPhoto: UnsplashPhoto! {
        didSet {
            let photoUrl = unsplashPhoto.urls["regular"]
            guard let imageUrl = photoUrl, let url = URL(string: imageUrl) else { return }
            photoImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    // каждый раз, когда это свойство будет меняться: при нажатии на ячейку с фото
    // ячейка будет либо затухать, либо появляться
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    // Используем данную функциб для того, чтобы изображения не накладывались друг на друга при скролле (подгрузка изображений)
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image =  nil
    }
    
    private func updateSelectedState() {
        photoImageView.alpha = isSelected ? 0.7 : 1
        checkMark.alpha = isSelected ? 1 : 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        updateSelectedState()
        setupPhotoImageView()
        setupCheckMarkView()
    }
    
    private func setupPhotoImageView() {
        addSubview(photoImageView)
        
        // фиксирование эл-та (constraints) с помощью кода
        photoImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
    }
    
    private func setupCheckMarkView() {
        addSubview(checkMark)
        checkMark.trailingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: -8).isActive = true
        checkMark.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
