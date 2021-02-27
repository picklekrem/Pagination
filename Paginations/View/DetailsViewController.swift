//
//  DetailsViewController.swift
//  Paginations
//
//  Created by Ekrem Özkaraca on 13.02.2021.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var landingDateLabel: UILabel!
    
    var selectedItemModel : Photos = Photos()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = selectedItemModel.earth_date
        vehicleNameLabel.text = selectedItemModel.rover?.name
        cameraLabel.text = selectedItemModel.camera?.full_name
        taskLabel.text = selectedItemModel.rover?.status
        launchDateLabel.text = selectedItemModel.rover?.launch_date
        landingDateLabel.text = selectedItemModel.rover?.landing_date
        let url = URL(string: selectedItemModel.img_src ?? "")
        detailsImageView.sd_setImage(with: url , placeholderImage: UIImage(named: "nasa"))
    }
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
