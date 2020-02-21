//
//  HomeViewController.swift
//  MediaCypher-J22
//
//  Created by mac on 2/20/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    let viewModel = ViewModel()
    let imagePicker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @IBAction func cameraButtonTapped(_ sender: UIBarButtonItem) {
        
        imagePicker.mediaTypes = ["public.image", "public.movie"] //media that is allowed
        imagePicker.sourceType = .photoLibrary //how to get media
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func setup(){
        viewModel.delegate = self
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
        let content = viewModel.content[indexPath.row]
        switch content.isVideo {
        case true:
//            guard let path = content.path,
//                let url = URL(string: path) else { return }
            guard let path = Bundle.main.path(forResource: "sample", ofType: "mp4") else { return }
            let url = URL(fileURLWithPath: path) 
            let videoPlayer = AVPlayer(url: url)
            let videoVC = AVPlayerViewController()
            videoVC.player = videoPlayer
            present(videoVC, animated: true) {
                videoVC.player?.play()
            }
            
        case false:
            let photoVC = storyboard?.instantiateViewController(identifier: String(describing: PhotoViewController.self)) as! PhotoViewController
            viewModel.current = content
            photoVC.viewModel = viewModel
            navigationController?.pushViewController(photoVC, animated: true)
        }
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
            guard let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
                let data = try? Data(contentsOf: url) else { return }
//            guard let endpoint = Bundle.main.path(forResource: "sample", ofType: "mp4"),
//                let data = try? Data(contentsOf:  URL(fileURLWithPath: endpoint)) else { return }
            
            FileServiceManager.save(data, true)
        case false:
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage,
                let imageData = image.jpegData(compressionQuality: 0.9) else { return }
            FileServiceManager.save(imageData, false)
        }
        
        picker.dismiss(animated: true) {
            self.viewModel.reload()
        }
    }
    
}


extension HomeViewController: ModelDelegate{
    func updateUI() {
        DispatchQueue.main.async {
            self.homeCollectionView.reloadData()
        }
    }
}
