//
//  LikedPostsViewModel.swift
//  Navigation
//
//  Created by Роман on 30.01.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import CoreData

class LikedPostsViewModel: ViewInput & ViewOutput {
    
    var onDidDissapear: (() -> Void)?
    
    var coordinator: Coordinator?
    
    var onDataChanged: ((String) -> Void)?
    
    var configuration: ConfigType?
    
    var onSelectAction: (() -> Void)?
    
    var presentAlertVC: ((String, String, String) -> ())?
    
    var model: LikedPostsModel
    
    init(model: LikedPostsModel) {
        self.model = model
        
        onDataChanged = { [weak self] text in
            guard let self = self else { return }
            guard !text.isEmpty else {
                self.presentAlertVC?("Input field is empty!", "Enter some text, please", "Ok")
                print("Field is empty!")
                return
            }
            coreDataStack.backgroundViewContext.performAndWait {
                let request = NSFetchRequest<LikedPost>()
                request.entity = LikedPost.entity()
       // let predicate = NSPredicate(format: "\(#keyPath(LikedPost.author)) == %@", text) - так тоже работает
                let predicate = NSPredicate(format: "%K == %@", #keyPath(LikedPost.author), text)
                request.returnsObjectsAsFaults = false
                request.predicate = predicate
                do {
                    let bufferLikedPostsArray = try coreDataStack.backgroundViewContext.fetch(request)
                    guard !bufferLikedPostsArray.isEmpty else {
                        self.presentAlertVC?("No such authors", "Correct request, please", "Ok")
                        return
                    }
                    model.likedPosts = bufferLikedPostsArray
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
