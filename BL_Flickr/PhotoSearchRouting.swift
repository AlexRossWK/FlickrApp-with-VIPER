//
//  PhotoSearchRouting.swift
//  BL_Flickr
//
//  Created by Алексей Россошанский on 23.11.17.
//  Copyright © 2017 Alexey Rossoshansky. All rights reserved.
//

import Foundation
import UIKit
//Router -> Presenter(PhotoDetailVC)
protocol photoSearchRouterInput: class {
    func  goToPhotoDetail()
    
   func passPhotoToDetailViewContrRout(_ segue: UIStoryboardSegue)
}


class PhotoSearchRouting: photoSearchRouterInput {

    
    weak var viewController: PhotoSearchViewController!
    
    func  goToPhotoDetail() {
        viewController.performSegue(withIdentifier: "goToPhotoDetail", sender: nil)
    }
    
    func passPhotoToDetailViewContrRout(_ segue: UIStoryboardSegue) {
        if segue.identifier == "goToPhotoDetail" {
            if let selectedIndexPath = viewController.collectionView.indexPathsForSelectedItems?.first {
                 let selectedPhotoModel = viewController.photosArray[selectedIndexPath.row]
                 let showDetailVC = segue.destination as! PhotoDetailsViewController
                showDetailVC.presenter.saveSelectedPhotoFromRouter(photo: selectedPhotoModel)
            }
        }
    }
}
