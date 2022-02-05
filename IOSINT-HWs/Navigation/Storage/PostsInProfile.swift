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

let robotiPost = ProfilePost(author: "Netflix", description: "Вышел 2 сезон сериала Любовь. Смерть. Роботы. Продюсерами второго сезона выступили Тим Миллер («Дэдпул») и Дэвид Финчер («Бойцовский клуб», «Социальная сеть», «Исчезнувшая»). И они сделали то, что умеют лучше всего: показали нам серию триллеров c красивой графикой и продуманным сюжетом.", image: "roboti", likes: 160000, views: 200000)
let forumPost = ProfilePost(author: "RBK", description: "В Санкт-Петербурге прошёл международный экономический форум", image: "forum", likes: 20, views: 66)
let wwdcPost = ProfilePost(author: "Gazeta.ru", description: "Обновленный FaceTime, AirPods вместо слухового аппарата, новая функция SharePlay, напоминания о забытых наушниках и многое другое продемонстрировала Apple на своей ежегодной выставке для разработчиков WWDC 2021.", image: "wwdc", likes: 1000, views: 1001)
let teslaPost = ProfilePost(author: "Elon Musk", description: "Tesla Model S побила мировой рекорд на дистанции 1/4 мили. Электромобиль преодолел 402 метра за 9,23 секунды.", image: "tesla", likes: 15000, views: 50000)


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
