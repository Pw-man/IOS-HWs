//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    let cellID = "ID"
    var residentsUrls: [String] = []
    var residentsNames: [String] = []
    let dispatchGroup = DispatchGroup()
    
    private lazy var alertButton: CustomButton = .init(title: "Show alert", font: .boldSystemFont(ofSize: 15), titleColor: .white) { [weak self] in
        guard let self = self else { return }
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    var latinSentenceLabel = UILabel()
    var planetOrbitalPeriodLabel = UILabel()
    
    private func serializationDownload() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos/4") else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data, let _ = response as? HTTPURLResponse {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let text = json["title"] as? String {
                            DispatchQueue.main.async {
                                self.latinSentenceLabel.text = text
                            }
                        }
                    }
                } catch let err as NSError {
                    print("Error to load with : \(err.localizedDescription)")
                }
            }
        }
        dataTask.resume()
    }
    
    private func decoderDownload() {
        guard let url = URL(string: "https://swapi.dev/api/planets/1") else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data, let _ = response as? HTTPURLResponse {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let planet : Planet = try decoder.decode(Planet.self, from: data)
                    self.residentsUrls = planet.residents
                    self.downloadResident()
                    self.dispatchGroup.notify(queue: DispatchQueue.main) {
                        self.tableView.reloadData()
                    }
                    DispatchQueue.main.async {
                        self.planetOrbitalPeriodLabel.text = "\(planet.orbitalPeriod)"                        
                    }
                } catch let err as NSError {
                    print(err.localizedDescription)
                }
            }
        }
        dataTask.resume()
    }
    
    func downloadResident() {
        residentsUrls.forEach { adress in
            dispatchGroup.enter()
            guard let url = URL(string: adress) else { return }
            let session = URLSession(configuration: .default)
            let request = URLRequest(url: url)
            let dataTask1 = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data, let _ = response as? HTTPURLResponse {
                    do {
                        let decoder1 = JSONDecoder()
                        decoder1.keyDecodingStrategy = .convertFromSnakeCase
                        let resident: Resident = try decoder1.decode(Resident.self, from: data)
                        self.residentsNames.append(resident.name)
                        self.dispatchGroup.leave()
                    } catch let eror as NSError {
                        print(eror.localizedDescription)
                    }
                }
            }
            dataTask1.resume()
        }
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(planetOrbitalPeriodLabel.snp.bottom).offset(20)
            make.bottom.bottom.equalToSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(alertButton)
        view.backgroundColor = .systemYellow
        view.addSubview(latinSentenceLabel)
        view.addSubview(planetOrbitalPeriodLabel)
        setupTableView()
        
        
        serializationDownload()
        decoderDownload()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        latinSentenceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
        }
        
        planetOrbitalPeriodLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
        }
        
        alertButton.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
}

extension InfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        residentsNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = residentsNames[indexPath.row]
            cell.contentConfiguration = content
        } else {
            cell.textLabel?.text = "old version"
        }
        return cell
    }
}
