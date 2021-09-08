//
//  PostsInProfile.swift
//  Navigation
//
//  Created by Роман on 10.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

struct ProfilePost {
    var author: String
    var description: String
    var image: String
    var likes: Int
    var views: Int
}

struct Posts {
    static let postsArray: [ProfilePost] = [robotiPost, forumPost, wwdcPost, teslaPost]
}

let robotiPost = ProfilePost(author: "Netflix", description: "Вышел 2 сезон сериала Любовь. Смерть. Роботы. Продюсерами второго сезона выступили Тим Миллер («Дэдпул») и Дэвид Финчер («Бойцовский клуб», «Социальная сеть», «Исчезнувшая»). И они сделали то, что умеют лучше всего: показали нам серию триллеров c красивой графикой и продуманным сюжетом.", image: "roboti", likes: 160000, views: 200000)
let forumPost = ProfilePost(author: "RBK", description: "В Санкт-Петербурге прошёл международный экономический форум", image: "forum", likes: 20, views: 66)
let wwdcPost = ProfilePost(author: "Gazeta.ru", description: "Обновленный FaceTime, AirPods вместо слухового аппарата, новая функция SharePlay, напоминания о забытых наушниках и многое другое продемонстрировала Apple на своей ежегодной выставке для разработчиков WWDC 2021.", image: "wwdc", likes: 1000, views: 1001)
let teslaPost = ProfilePost(author: "Elon Musk", description: "Tesla Model S побила мировой рекорд на дистанции 1/4 мили. Электромобиль преодолел 402 метра за 9,23 секунды.", image: "tesla", likes: 15000, views: 50000)



