//
//  PhotoDetailsAssembly.swift
//  BL_Flickr
//
//  Created by Алексей Россошанский on 23.11.17.
//  Copyright © 2017 Alexey Rossoshansky. All rights reserved.
//

import Foundation


class PhotoDetailsAssembly {
    
static let shared = PhotoDetailsAssembly()
    
func configure(viewController: PhotoDetailsViewController){
    
    let presenter = PhotoDetailsPresenter()
    viewController.presenter = presenter
    presenter.view = viewController
}
    
}
