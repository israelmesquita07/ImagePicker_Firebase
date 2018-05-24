//
//  ViewController.swift
//  testeImagePicker
//
//  Created by Rodrigo Guimaraes on 2017-10-20.
//  Copyright © 2017 RodrigoLG. All rights reserved.
//

import UIKit
import ImagePicker
import FirebaseStorage

class ViewController: UIViewController, ImagePickerDelegate  {
    
    var imagePickerController : ImagePickerController!
    
//    Firebase
    var referenciaStorage: StorageReference!
    
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        return
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        imagePickerController.dismiss(animated: true, completion: {
            if images.count > 0 {
                self.bgImg.image = images[0]
//                UPLOAD PARA O FIREBASE
                var data = Data()
                data = (UIImageJPEGRepresentation(images[0], 0.8)!)
                let caminho = "photos/test.jpg"
                let metadados = StorageMetadata()
                metadados.contentType = "image/jpg"
                self.referenciaStorage.child(caminho).putData(data, metadata: metadados, completion: { (metadata, error) in
                    if let erro = error{
                        print("Deu ruim: \(erro.localizedDescription)")
                        return
                    }else{
                        let downloadURL = metadata!
                        print(downloadURL)
                    }
                })
            }
            })
        return
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        return
    }
    

    @IBOutlet weak var bgImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        referenciaStorage = Storage.storage().reference()
    }

    @IBAction func abrirImagePicker(_ sender: Any) {
        imagePickerController = ImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        present(imagePickerController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

