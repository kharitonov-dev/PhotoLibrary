//
//  MainTabBarController.swift
//  PhotoLibrary
//
//  Created by Timofey Kharitonov on 01.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        let photosLibrary = PhotosLibraryViewController(collectionViewLayout: UICollectionViewFlowLayout())
       
        viewControllers = [
            generateNavigationController(rootViewController: photosLibrary, title: "Photos", image: #imageLiteral(resourceName: "photos")),
            generateNavigationController(rootViewController: ViewController(), title: "Favourites", image: #imageLiteral(resourceName: "heart")),
        ]
    }
    
    // Функция, которая создает превью и тайтл для таббара
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
