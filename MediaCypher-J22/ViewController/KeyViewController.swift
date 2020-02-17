//
//  ViewController.swift
//  MediaCypher-J22
//
//  Created by mac on 2/17/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class KeyViewController: UIViewController {
    
    @IBOutlet weak var keyCollectionView: UICollectionView!
    
    private var numberArr = [Int](1...9).map({String($0)})
    private var iconArr = [UIImage(systemName: "faceid")!,UIImage(systemName: "checkmark.shield")!,UIImage(systemName: "delete.left")!]
    
    private var selectedCode = String() {
        didSet {
            keyCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupKey()
      
    }

    private func setupKey() {
        //MUST register Xib's to views to be able to use
        keyCollectionView.register(UINib(nibName: HeaderCollectionCell.identifier, bundle: Bundle.main), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionCell.identifier)
    }

}

//MARK: CollectionView
extension KeyViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? numberArr.count : iconArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCollectionCellOne.identifier, for: indexPath) as! KeyCollectionCellOne
            cell.number = numberArr[indexPath.row]
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCollectionCellTwo.identifier, for: indexPath) as! KeyCollectionCellTwo
            cell.icon = iconArr[indexPath.row]
            return cell
        }
    }
    
    //render header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionCell.identifier, for: indexPath) as! HeaderCollectionCell
        cell.code = String(repeating: "*", count: selectedCode.count)
        return cell
    }
    
}

extension KeyViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedCode.append(numberArr[indexPath.row])
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 120) / 3
        return CGSize(width: width, height: width)
    }
    
    //height for header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = view.frame.height * 0.30
        return section == 0 ? CGSize(width: view.frame.width, height: height) : .zero
    }
    
    //horizontal spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    //vertical spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    //cell insets (leading and trailing)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let first = UIEdgeInsets(top: 0, left: 30, bottom: 20, right: 30)
        let second = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        return section == 0 ? first : second
    }
    
}
