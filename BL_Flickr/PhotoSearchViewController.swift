//
//  PhotoSearchViewController.swift
//  BL_Flickr
//
//  Created by Алексей Россошанский on 24.11.17.
//  Copyright © 2017 Alexey Rossoshansky. All rights reserved.
//

import UIKit
import Kingfisher


//VC -> Presenter
protocol PhotoVCOutput {
    func fetchPhotos(tag: String, page: Int)
    func goToPhotoDetailView()
    func passPhotoToDetailViewContr(_ segue: UIStoryboardSegue)
}

//Presenter -> VC
protocol PhotoVCInput {
    func displayFetchedPhotos(photos: [PhotoModel], totalPages: Int)
    func diplayErrorView(message: String)
    
    func showWaitingView()
    func hideWaitingView()
    func getPhotoCount() -> Int
}

class PhotoSearchViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: PhotoVCOutput!
    
    var currentPage = 1
    var totalPages = 1
    var photosArray = [PhotoModel]()
}

//MARK: View Loads
extension PhotoSearchViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lets start appeals chain
        performSearch(searchText: "sky")
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //init all objects
        PhotoSearchAssembly.share.configure(viewController: self)
    }
    
}


extension PhotoSearchViewController {
    
    func performSearch(searchText: String) {
        presenter.fetchPhotos(tag: searchText, page: currentPage)
    }
    
}



//MARK: CollectionView DataSource
extension PhotoSearchViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentPage < totalPages {
            return photosArray.count + 1
        } else {
            return photosArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < photosArray.count {
            return photoCellCreating(collectionView, indexPath: indexPath)
        } else {
            currentPage += 1
            performSearch(searchText: "people")
            return photoLoadingCellCreating(collectionView, indexPath: indexPath)
        }
    }
    
    //Cell creating
    
    func photoCellCreating(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! PhotoCell
        
        
        cell.photoImage.alpha = 0
        cell.photoImage.kf.setImage(with: self.photosArray[indexPath.row].smallPhotoUrl)
        
        UIView.animate(withDuration: 0.3) {
            cell.photoImage.alpha = 1
        }
        
        return cell
    }
    
    func photoLoadingCellCreating (_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageLoadingCell", for: indexPath) as! PhotoLoadingCell
        return cell
    }
}



//MARK: CollectionView Delegate
extension PhotoSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.presenter.goToPhotoDetailView()
    }
}

//MARK: CollectionView DelegateFlowLayout
extension PhotoSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize: CGSize
        
        if indexPath.row < photosArray.count{
            itemSize = CGSize(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1 )
        } else {
            itemSize = CGSize(width: collectionView.bounds.width, height: 100)
        }
        return itemSize
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
    
    
    
    
}



//MARK: Display photos
extension PhotoSearchViewController: PhotoVCInput {
    func displayFetchedPhotos(photos: [PhotoModel], totalPages: Int) {
        self.photosArray.append(contentsOf: photos)
        self.totalPages = TotalPages.share.totalAmountOfPages
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func diplayErrorView(message: String) {
        let alert = UIAlertController(title: "Some problem", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}



//MARK: Activity View
extension PhotoSearchViewController {
    func showWaitingView(){
        let alert = UIAlertController(title: nil, message: "Wait please", preferredStyle: .alert)
        alert.view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .white
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    
    func hideWaitingView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func getPhotoCount() -> Int {
        return self.photosArray.count
    }
    
}



//MARK: Go to DetailView
extension PhotoSearchViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.passPhotoToDetailViewContr(segue)
    }
}

