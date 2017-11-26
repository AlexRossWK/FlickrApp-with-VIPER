//
//  PhotoDetailViewController.swift
//  BL_Flickr
//
//  Created by Алексей Россошанский on 23.11.17.
//  Copyright © 2017 Alexey Rossoshansky. All rights reserved.
//

import UIKit
import Kingfisher
//Presenter -> VC
protocol PhotoDetailVCInput: class{
    func addPhoto(photo: PhotoModel)
}
//VC -> Presenter 
protocol PhotoDetailVCOutput: class{
    func saveSelectedPhotoFromRouter(photo: PhotoModel)
    func finalPhotoSend()
}

class PhotoDetailsViewController: UIViewController, PhotoDetailVCInput {
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
   
    var presenter: PhotoDetailVCOutput!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoDetailsAssembly.shared.configure(viewController: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.finalPhotoSend()
    
    }
    
    func addPhoto(photo: PhotoModel) {
        self.detailImage.kf.setImage(with: photo.largePhotoUrl)
        self.detailLabel.text = photo.title
    }

}
