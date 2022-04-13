//
//  PostsInProfile.swift
//  Navigation
//
//  Created by Роман on 10.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

struct ProfilePost {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

struct Posts {
    static var postsArray: [ProfilePost] = [robotiPost ,robotiPost, forumPost, wwdcPost, teslaPost]
}

let robotiPost = ProfilePost(author: "Netflix", description: "Season 2 of the TV series Love. Death. Robots. was released. The producers of the second season were Tim Miller («Deadpool») and David Fincher («Fight club», «Social network», «Dissapeared»). And they did what they do best: they showed us a series of thrillers with beautiful graphics and a thoughtful plot.", image: "roboti", likes: 160000, views: 200000)
let forumPost = ProfilePost(author: "RBK", description: "The International Economic Forum was held in St. Petersburg.", image: "forum", likes: 20, views: 66)
let wwdcPost = ProfilePost(author: "Gazeta.ru", description: "An updated FaceTime, AirPods instead of a hearing aid, a new Share Play function, reminders of forgotten headphones and much more were demonstrated by Apple at its annual WWDC 2021 developer exhibition.", image: "wwdc", likes: 1000, views: 1001)
let teslaPost = ProfilePost(author: "Elon Musk", description: "Tesla Model S broke the world record at a distance of 1/4 mile. The electric car overcame 402 meters in 9.23 seconds.", image: "tesla", likes: 15000, views: 50000)


//MARK: - image processor realization with UIImage in ProfileVC

//        switch indexPath.row {
//        case 0:
//            let cell = PhotosTableViewCell()
//            return cell
//        case 1:
//            let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PostTableViewCell
//            cell.profilePost = Posts.postsArray[indexPath.row]
//            imageProcessor.processImage(sourceImage: Posts.postsArray[1].image, filter: .crystallize(radius: 12)) { filterImg in
//                cell.profilePost?.image = filterImg!
//            }
//                return cell
//        case 2:
//              let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PostTableViewCell
//            cell.profilePost = Posts.postsArray[indexPath.row]
//            imageProcessor.processImage(sourceImage: Posts.postsArray[2].image, filter: .bloom(intensity: 0.5)) { filterImg in
//                cell.profilePost?.image = filterImg!
//            }
//                return cell
//        case 3:
//            let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PostTableViewCell
//            cell.profilePost = Posts.postsArray[indexPath.row]
//            imageProcessor.processImage(sourceImage: Posts.postsArray[3].image, filter: .monochrome(color: .blue, intensity: 0.9)) { filterImg in
//                cell.profilePost?.image = filterImg!
//            }
//                return cell
//        case 4:
//            let cell : PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PostTableViewCell
//            cell.profilePost = Posts.postsArray[indexPath.row]
//            imageProcessor.processImage(sourceImage: Posts.postsArray[4].image, filter: .sepia(intensity: 0.7)) { filterImg in
//                cell.profilePost?.image = filterImg!
//            }
//                return cell
//        default:
//            return UITableViewCell()
//        }
