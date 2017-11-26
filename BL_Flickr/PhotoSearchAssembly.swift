//
//  PhotoSearchAssembly.swift
//  BL_Flickr
//
//  Created by Алексей Россошанский on 23.11.17.
//  Copyright © 2017 Alexey Rossoshansky. All rights reserved.
//

import Foundation
//Initialaizing and depedencies
class PhotoSearchAssembly {
    
    static let share = PhotoSearchAssembly()
    
    
    func configure(viewController: PhotoSearchViewController) {
        let APIDataManager = FlickrDataManager()
        let interactor = PhotoSearchInteractor()
        let presenter = PhotoSearchPresenter()
        let router = PhotoSearchRouting()
        
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        interactor.apiDataManager = APIDataManager
        
        presenter.view = viewController
        interactor.presenter = presenter
        
        router.viewController = viewController
        presenter.router = router
    }
}
