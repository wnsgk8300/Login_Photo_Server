//
//  PhotoViewController.swift
//  Login_Photo_Server
//
//  Created by photypeta-junha on 2021/08/31.
//

import UIKit
import Photos
import SnapKit
import AssetsLibrary

class PhotoViewController: UIViewController {
    
    let photoFrame = UIImageView()
    let photoImageView = UIImageView()
    let photoAlbumText = UILabel()
    let imagePickerController = UIImagePickerController()
    let photobutton = UIButton(type: .system)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        setUI()
        //여기에 사진 url 넣기
        let url = URL(string: "http://m.todaysppc.com/userfiles/20181216132944a12332.jpg")
        guard let imageSource = CGImageSourceCreateWithURL(url! as CFURL, nil),
              let metadata = CGImageSourceCopyMetadataAtIndex(imageSource, 0, nil),
              let tags = CGImageMetadataCopyTags(metadata),
              let imageInfo = self.readMetadataTagArr(tagArr: tags) else { return print("안됨") }
        //아이폰으로 찍은 사진들만 정보가 나옴
        print(imageInfo)
        print(imageInfo.keys.map({ String.init($0)
        }))
    }
    
    func readMetadataTagArr(tagArr: CFArray) -> [String: Any]? {
        var result = [String: Any]()
        for (_, tag) in (tagArr as NSArray).enumerated() {
            let tagMetadata = tag as! CGImageMetadataTag
            if let cfName = CGImageMetadataTagCopyName(tagMetadata) {
                let name = String(cfName)
                result[name] = self.readMetadataTag(metadataTag: tagMetadata)
            }
        }
        return result
    }
    func readMetadataTag(metadataTag: CGImageMetadataTag) -> [String: Any] {
        var result = [String: Any]()
        guard let cfName = CGImageMetadataTagCopyName(metadataTag) else { return result }
        let name = String(cfName)
        let value = CGImageMetadataTagCopyValue(metadataTag)
        
        /// checking the type of `value` object and then performing respective operation on `value`
        if CFGetTypeID(value) == CFStringGetTypeID() {
            let valueStr = String(value as! CFString)
            result[name] = valueStr
        } else if CFGetTypeID(value) == CFDictionaryGetTypeID() {
            let nsDict: NSDictionary = value as! CFDictionary
            result[name] = self.getDictionary(from: nsDict)
        } else if CFGetTypeID(value) == CFArrayGetTypeID() {
            let valueArr: NSArray = value as! CFArray
            for (_, item) in valueArr.enumerated() {
                let tagMetadata = item as! CGImageMetadataTag
                result[name] = self.readMetadataTag(metadataTag: tagMetadata)
            }
        } else {
            // when the data was of some other type
            let descriptionString: CFString = CFCopyDescription(value);
            let str = String(descriptionString)
            result[name] = str
        }
        return result
    }

        /// Converting CGImage Metadata dictionary to [String: Any]
    func getDictionary(from nsDict: NSDictionary) -> [String: Any] {
        var subDictionary = [String: Any]()
        for (key, val) in nsDict {
            guard let key = key as? String else { continue }
            let tempDict: [String: Any] = [key: val]
            if JSONSerialization.isValidJSONObject(tempDict) {
                subDictionary[key] = val
            } else {
                let mData = val as! CGImageMetadataTag
                let tempDict: [String: Any] = [key: self.readMetadataTag(metadataTag: mData)]
                if JSONSerialization.isValidJSONObject(tempDict) {
                    subDictionary[key] = tempDict
                }
            }
        }
        return subDictionary
    }


    
    
}

extension PhotoViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {


    
    @objc
    func selectButtonTouched(_ sender: Any) {
        self.imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.contentMode = .scaleAspectFit
            photoImageView.image = image
            
        }
        dismiss(animated: true, completion: nil)

    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        if context != nil {
            return context.createCGImage(inputImage, from: inputImage.extent)
        }
        return nil
    }
    
}


extension PhotoViewController {
    func setUI() {
        view.addSubview(photoImageView)
        photoImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(200)
        }
        view.addSubview(photobutton)
        photobutton.snp.makeConstraints {
            $0.top.equalTo(photoImageView.snp.bottom).offset(50)
            $0.width.height.equalTo(50)
            $0.centerX.equalToSuperview()
        }
        photobutton.addTarget(self, action: #selector(selectButtonTouched(_:)), for: .touchUpInside)
        photobutton.backgroundColor = .red
        
        
        photoImageView.backgroundColor = .yellow
    }
    
    
}
