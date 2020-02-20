//
//  HomeViewController.swift
//  MediaCypher-J22
//
//  Created by mac on 2/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    let viewModel = ViewModel()
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        
        imagePicker.mediaTypes = ["public.image", "public.movie"] //media that is allowed
        imagePicker.sourceType = .photoLibrary //how to get media
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
}

//MARK: CollectionView
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.content.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionCell.identifier, for: indexPath) as! HomeCollectionCell
        cell.content = viewModel.content[indexPath.row]
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 6) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}

//MARK: Image Picker Delegate

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //called AFTER user selects content
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String else { return }
        switch mediaType == "public.movie" {
        case true:
            break
        case false:
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
                let imageData = image.pngData() else { return }
            //TODO: Save CoreData Entity
            FileServiceManager.save(imageData)
        }
    }
    
}
