//
//  AlbumsWorker.swift
//  TestTask
//
//  Created by Khusnullin Denis on 09.02.2021.
//

import Foundation
import Alamofire

protocol AlbumsDataSourceWorker {
    func fetchAlbumsList(callback: @escaping (Result<AlbumsModel.AlbumsFetch.Response, APIServiceError>) -> Void)
}

// MARK: - Информация из API
final class AlbumsRemoteDataSource: AlbumsDataSourceWorker {
    private let url = "https://jsonplaceholder.typicode.com/albums"
    
    func fetchAlbumsList(callback: @escaping (Result<AlbumsModel.AlbumsFetch.Response, APIServiceError>) -> Void) {
        AF.request(url).responseJSON { (response) in
            if checkResponse(response: response, callback: callback), let data = response.data {
                do {
                    let albums = try JSONDecoder().decode([Album].self, from: data)
                    callback(.success(AlbumsModel.AlbumsFetch.Response(albums: albums)))
                } catch {
                    callback(.failure(APIServiceError.jsonDecodingError))
                }
            }
        }
    }
}
