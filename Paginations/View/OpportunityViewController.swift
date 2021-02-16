//
//  OpportunityViewController.swift
//  Paginations
//
//  Created by Ekrem Özkaraca on 15.02.2021.
//

import UIKit
import SDWebImage
import DropDown

class OpportunityViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    var nasaViewModel : NasaViewModel!
    var detailsInfo : Photos = Photos()
    
    private var path = "Opportunity"
    private var page = 1
    private var sol = 1000
    private var camera : String? = nil
    
    let menu : DropDown = {
        let menu  = DropDown()
        menu.dataSource.append("All")
        return menu
    }()
    
    @IBOutlet weak var filterButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        nasaViewModel = NasaViewModel()
        menu.anchorView = filterButtonOutlet
        menu.selectionAction = {index, title in
            if title == "All" {
                self.camera = nil
            }
            else{
                self.camera = title
            }
            self.page = 1
            self.nasaViewModel.getNasaPhotos(path: self.path, solQuery: self.sol, camera: self.camera, pageQuery: self.page) { (response) in
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }

        }

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(MyCollectionViewCell.nib(), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
        nasaViewModel.getNasaPhotos(path: path, solQuery: sol, camera: camera, pageQuery: page){(response) in
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    @IBAction func filterButtonClicked(_ sender: Any) {
        menu.dataSource.removeDuplicates()
        menu.show()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        detailsInfo = nasaViewModel.nasaPhotosList[indexPath.row]
        
        performSegue(withIdentifier: "toDetailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailsViewController {
            dest.selectedItemModel = detailsInfo
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == nasaViewModel.nasaPhotosList.count - 1 {
            page += 1
            nasaViewModel.getNasaPhotos(path: path, solQuery: sol, camera: camera, pageQuery: page) { (response) in
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nasaViewModel.nasaPhotosList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        let imageUrl = URL(string:nasaViewModel.nasaPhotosList[indexPath.row].img_src ?? "")
        cell.imageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "nasa"))
        menu.dataSource.append(contentsOf: [nasaViewModel.nasaPhotosList[indexPath.row].camera?.name ?? ""])
        return cell
    }
}
