//
//  AudioViewController.swift
//  Navigation
//
//  Created by Роман on 09.12.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import AVFoundation

class AudioViewController: UIViewController, AVAudioRecorderDelegate {

    var iterator: Int = 0
    
    var player = AVAudioPlayer()
    
    var userRecordedPlayer = AVAudioPlayer()
    
    var numberOfRecords = 0
    
    var recordingSession: AVAudioSession!
    
    var audioRecorder: AVAudioRecorder!
    
    private let songs: [Song] = [
        Song(name: "Let it snow" , url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Frank Sinatra. Let it snow", ofType: "mp3")!)),
        Song(name: "Love Is Here To Stay" , url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Louis Armstrong & Ella Fitzgerald. Love Is Here To Stay", ofType: "mp3")!)),
        Song(name: "Midnight City" , url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "M83. Midnight City", ofType: "mp3")!)),
        Song(name: "If I Didn't Care" , url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "The Ink Spots. If I Didn't Care", ofType: "mp3")!)),
        Song(name: "The show must go on" , url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "Queen", ofType: "mp3")!))
    ]
    
    private let songNameLabel : UILabel = {
        let label = UILabel()
        label.text = "Current song name".localized()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    private var recordButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "record.circle.fill"), for: .normal)
        button.tintColor = .red
        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 15)
        button.imageView?.layer.masksToBounds = false
        button.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var playRecodedButton = CustomButton(title: "Play recorded sound".localized(), font: .boldSystemFont(ofSize: 15), titleColor: .red) { [weak self] in
        guard let self = self else { return }
        let path = self.getDirectory().appendingPathComponent("\(self.numberOfRecords).m4a")
        
        do {
            self.userRecordedPlayer = try AVAudioPlayer(contentsOf: path)
            self.userRecordedPlayer.play()
        } catch {
            print("Something went wrong")
        }
    }
    
    private var stopButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "stop.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(stopTapped), for: .touchUpInside)
        return button
    }()
    
    private var pauseButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(pauseTapped), for: .touchUpInside)
        return button
    }()
    
    private var playButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
        return button
    }()
    
    private var forwardButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(forwardTapped), for: .touchUpInside)
        return button
    }()
    
    private var backwardButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backwardTapped), for: .touchUpInside)
        return button
    }()
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(songNameLabel)
        view.addSubview(playButton)
        view.addSubview(pauseButton)
        view.addSubview(stopButton)
        view.addSubview(forwardButton)
        view.addSubview(backwardButton)
    }
    
    func subviewsLayout() {
        songNameLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(songNameLabel.snp.bottom).offset(100)
        }
        
        stopButton.snp.makeConstraints { make in
            make.top.equalTo(playButton)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        pauseButton.snp.makeConstraints { make in
            make.top.equalTo(playButton)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(50)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
        
        backwardButton.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(50)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }
    
    func getDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func startRecording() {
        let audioFilename = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

            recordButton.setImage(UIImage(systemName: "waveform.circle"), for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            recordButton.setImage(UIImage(systemName: "record.circle.fill"), for: .normal)
            UserDefaults.standard.set(numberOfRecords, forKey: "myNumber")
        } else {
            finishRecording(success: false)
            print("Record failed")
        }
    }
    
    @objc func recordTapped() {
        if audioRecorder == nil {
            numberOfRecords += 1
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func loadRecordingUI() {
        view.addSubview(recordButton)
        view.addSubview(playRecodedButton)
        
        recordButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        
        playRecodedButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized:
            print("Already have permission")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { granted in
                DispatchQueue.main.async {
                    if granted {
                        print("User granted permission to use microphone")
                    }
                }
            }
        case .denied, .restricted:
            break
        @unknown default:
            break
        }
        
        recordingSession = AVAudioSession.sharedInstance()
        
        if let number: Int = UserDefaults.standard.object(forKey: "myNumber") as? Int {
            numberOfRecords = number
        }
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        print("No permission to record")
                    }
                }
            }
        } catch {
            print("Some error occured")
        }
        
        setupViews()
        subviewsLayout()
        
        do {
            player = try AVAudioPlayer(contentsOf: songs[iterator].url)
            player.prepareToPlay()
        }
        catch {
            print(error)
        }
    }
    
    @objc func stopTapped() {
        player.stop()
        player.currentTime = 0
    }
    
    @objc func playTapped() {
        player.play()
        songNameLabel.text = songs[iterator].name
    }
    
    @objc func pauseTapped() {
        player.stop()
    }
    
    @objc func forwardTapped() {
        if iterator < songs.count - 1 {
            iterator += 1
            do {
                player = try AVAudioPlayer(contentsOf: songs[iterator].url)
                player.prepareToPlay()
                player.play()
                songNameLabel.text = songs[iterator].name
            } catch {
                print(error)
            }
        } else {
            iterator = 0
            do {
                player = try AVAudioPlayer(contentsOf: songs[iterator].url)
                player.prepareToPlay()
                player.play()
                songNameLabel.text = songs[iterator].name
            } catch {
                print(error)
            }
        }
    }
    
    @objc func backwardTapped() {
        if iterator > 0 {
        iterator -= 1
        player = try! AVAudioPlayer(contentsOf: songs[iterator].url)
        player.prepareToPlay()
        player.play()
        songNameLabel.text = songs[iterator].name
        } else {
            iterator = songs.count - 1
            player = try! AVAudioPlayer(contentsOf: songs[iterator].url)
            player.prepareToPlay()
            player.play()
            songNameLabel.text = songs[iterator].name
        }
    }
}
