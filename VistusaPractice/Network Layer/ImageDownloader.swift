//
//  ImageDownloader.swift
//  VistusaPractice
//
//  Created by Patrick Gao on 14/5/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol ImageDownloader {
    func downloadImage(urlString:String) -> Single<String>
}

class ImageDownloaderImplementation:ImageDownloader {
    /// Download image and return the location of the image where it is stored
    ///
    /// - Parameter url: image url string
    /// - Returns: image stored location path
    func downloadImage(urlString:String) -> Single<String> {
        
        let url = URL(string: urlString)!
        let filename = urlString.md5()
        return downloadImage(from: url, filename: filename)
    }
    
    fileprivate func downloadImage(from url:URL, filename:String) -> Single<String>{
        return Single<String>.create(subscribe: { (single) -> Disposable in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("image").appendingPathComponent(filename)
            
            let destination: DownloadRequest.DownloadFileDestination = { _, _ in
                
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            if self.imageExists(fileURL: fileURL){
                single(.success(fileURL.path))
            }else {
                let dispatchQueue = DispatchQueue(label: "com.patrickgao.VistusaPractice")
                dispatchQueue.async {
                    download(url, method: .get, to:destination)
                        .responseData(completionHandler: { (response) in
                            if let error = response.error {
                                single(.error(error))
                            }
                            guard let imagePath = response.destinationURL?.path else {
                                return single(.error(HTTPError.noResultData))
                            }
                            single(.success(imagePath))
                        })
                }
                
            }
            
            return Disposables.create()
        })
    }
    fileprivate func imageExists(fileURL:URL) -> Bool {
        return FileManager.default.fileExists(atPath: fileURL.absoluteString)
    }
}
