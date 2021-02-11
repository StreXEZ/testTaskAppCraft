//
//  SingleAlbumWorker.swift
//  TestTask
//
//  Created by Khusnullin Denis on 10.02.2021.
//

import Foundation
import Alamofire


class SingleAlbumWorker {
    let url = "https://jsonplaceholder.typicode.com/photos?albumId="
    
    func fetchAlbumImages(for albumId: Int,callback: @escaping (Result<SingleAlbumModel.FetchAlbum.Response, APIServiceError>) -> Void) {
        let finalUrl = url + String(albumId)
        AF.request(finalUrl).responseJSON { (response) in
            if checkResponse(response: response, callback: callback), let data = response.data {
                do {
                    let images = try JSONDecoder().decode([SingleAlbumImage].self, from: data)
                    callback(.success(SingleAlbumModel.FetchAlbum.Response(images: images)))
                } catch {
                    callback(.failure(APIServiceError.jsonDecodingError))
                }
            }
        }
    }
}
