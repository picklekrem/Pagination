//
//  MyCollectionViewCell.swift
//  Paginations
//
//  Created by Ekrem Özkaraca on 11.02.2021.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var imageView: UIImageView!
    static let identifier = "MyCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    static func nib() -> UINib{
        return UINib(nibName: "MyCollectionViewCell", bundle: nil)
    }

}
