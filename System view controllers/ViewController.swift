//
//  ViewController.swift
//  System view controllers
//
//  Created by lorin esim on 10.05.2023.
//

import UIKit
import SafariServices
import MessageUI

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate, MFMailComposeViewControllerDelegate{
    
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //Bu fonksiyon UIImagePicker tarafından bir fotoğraf seçildiğinde veya çekildiğinde çalışır.
        
        // Dictionary içerisinden, kullanıcının seçtiği görsele ulaşır
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        // seçilen görseli aktar
        imageView.image = selectedImage
        
        //Bir view controllerin ekrandan gitmesi için kullanılan fonksiyon dismiss
        dismiss(animated: true, completion: nil)
    }

    // Actions
    @IBAction func shareButtonTapped(_ button: UIButton){
        
        //Ekranda bulunan İmageView'da bir görsel olduğuna emin olmamızı sağlar.
        guard let image = imageView.image else { return }
        // ActivityController nesnesi oluşturmak
        // activityItems : oluşturulacak nesne
        // applicationActivities : ör(Message,Email)
        let activityController = UIActivityViewController( activityItems: [image], applicationActivities: nil)
        // Ekranda Yeni bir view controller göstermek için kullanılır.
        present(activityController, animated: true, completion: nil)
    }
    @IBAction func safariButtonTapped(_ button: UIButton){
        
        if let url = URL(string: "https://www.instagram.com/lorinesim/"){
            let safariController = SFSafariViewController(url: url)
            
            
            present(safariController, animated: true, completion: nil)
        }
    }
    @IBAction func photosButtonTapped(_ button: UIButton){
        
        let imagePickerController = UIImagePickerController()
        //imagePickerController'ın yöneticisini belirler. Belirtilmezse Delegate fonksiyonları çalışmaz.
        imagePickerController.delegate = self
        
        //actionSheet = Ekranın altında gelen sayfa görünümü
        //alert = Ekranın ortasında seçenekler görünür
        let alertController = UIAlertController(title: "Görsel kaynağı seçin", message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let cameraAction = UIAlertAction(title: "Kamera", style: .default) { (action) in
           //aksiyon tetiklendiğinde bu kod bloğu çalışır
            imagePickerController.sourceType = .camera
           
            self.present(imagePickerController, animated: true, completion: nil)
        }
        
        let photoLibrary = UIAlertAction(title: "Fotoğraf Galerisi", style: .default) { (action)in
            // fotoğraf galerisi tetiklendiğinde bu kod bloğu çalışır
            imagePickerController.sourceType = .photoLibrary
            
            self.present(imagePickerController, animated: true, completion: nil)
            
        }
        
        

        
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibrary)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func emailButtonTapped(_ button: UIButton){
        // Mail atılabilir bir ortamda olduğumuzdan emin olmalıyız.örneğin similatör mail atamaz ve bu uygulamamızın çökmesine neden olur.
       
        guard MFMailComposeViewController.canSendMail() else { return }
        
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        
        // mail alıcıları
        mailComposer.setToRecipients(["lorinesin02@gmail.com"])
        
        // mail in subject'i
        mailComposer.setSubject("Ekibinize dahil olmak istiyorum :)")
        
        // mail içeriği
        mailComposer.setMessageBody("Merhaba, Sayın yetkili.. ", isHTML: false)
        
        // Oluşturulan viewControllerin ekranda gösterilmesi
        present(mailComposer, animated: true, completion: nil)
        
    }
}

