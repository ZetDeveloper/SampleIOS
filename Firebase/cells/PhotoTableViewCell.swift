//
//  PhotoTableViewCell.swift
//  Firebase
//
//  Created by Daniel on 18/12/21.
//

import UIKit
import AVFoundation

protocol CameraDelegate {
    func openCamera()
}

class PhotoTableViewCell: UITableViewCell, AVCapturePhotoCaptureDelegate {

    var delegateCamera: CameraDelegate?
    @IBOutlet weak var photo: UIImageView!
    
    @IBAction func uploadPhoto(_ sender: Any) {
    }
    @IBAction func takePhoto(_ sender: Any) {
        openCamera()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func openCamera() {
        delegateCamera?.openCamera()
    }
    
    
    func setImage(image: UIImage?){
        photo.image = image
    }
  
    
}
