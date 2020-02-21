//
//  PhotoViewController.swift
//  MediaCypher-J22
//
//  Created by mac on 2/21/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ourImage: UIImageView!
    
    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 8
        guard let image = viewModel.current.getImage else { return }
        DispatchQueue.main.async {
            self.ourImage.image = image
        }
    }


}

extension PhotoViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return ourImage
    }
}
