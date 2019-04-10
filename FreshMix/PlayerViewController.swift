//
//  PlayerViewController.swift
//  FreshMix
//
//  Created by Dunkley, Rachel A on 11/18/17.
//  Copyright © 2017 Dunkley, Rachel A. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer


class PlayerViewController: UIViewController {
    
    var myIndex = 0
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        /*
         Need to notify of song change, so view can
         update song info to the NEW song.
         */
//        repeatOnOff.isOn = false
//        
//        shuffleOnOff.isOn = false
        
        musicPlayer.beginGeneratingPlaybackNotifications()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleMusicPlayerManagerDidUpdateState),
            name: NSNotification.Name.MPMusicPlayerControllerNowPlayingItemDidChange,
            object: nil)
        
    }
    
    /*
     Start playing genre selected.
     Set the trackSlider to beginning and move w/ the update function
     Also update/display song's info
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        playGenre(genre: (musicModel.genrePlaylist[myIndex]))
        
        trackSlider.maximumValue = Float((musicPlayer.nowPlayingItem?.playbackDuration)!)
        
        _ = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(PlayerViewController.updateSlider),
                                 userInfo: nil, repeats: true)
        
        updateCurrentItemMetadata()
        
        
    }
    
    /*
     Function to name the notification of the changed state
     */
    func didUpdateState(_ notification: Notification){
        _ = NSNotification.Name("didUpdateState")
    }
    
    /*
     Need to stop generating notifications when view disappears
     Song ends
     */
    override func viewWillDisappear(_ animated: Bool) {
        musicPlayer.endGeneratingPlaybackNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    var audioPlayer = AVAudioPlayer()
    var musicModel = MusicModel()
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    var genre: String!
    
    
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var trackSlider: UISlider!
    
    let MPMediaItemPropertyTitle : String = ""
    
    
    
    /*
     Start query and filter for the selected genre.
     Begin on shuffle mode, prep and play.
     and update to current song info
     */
    
    func playGenre(genre: String){
        musicPlayer.stop()
        
        let query = MPMediaQuery()
        let predicate = MPMediaPropertyPredicate(value: genre, forProperty: MPMediaItemPropertyGenre)
        
        query.addFilterPredicate(predicate)
        
        musicPlayer.setQueue(with: query)
        updateCurrentItemMetadata()
        
        shuffleOnOff.isOn = true
        //musicPlayer.shuffleMode = .songs

        repeatOnOff.isOn = false
        
        
        musicPlayer.prepareToPlay()
        musicPlayer.play()
        
    }
    
    /*
     Updates song info with Title, Artist, and album artwork if not nil.
     Sets to default string and a default picture if = nil.
     */
    func updateCurrentItemMetadata() {

        if(repeatOnOff.isOn == false){
            musicPlayer.repeatMode = .none
        }
   
        
        if(shuffleOnOff.isOn == true){
            musicPlayer.shuffleMode = .songs
        }
        else{
            musicPlayer.shuffleMode = .off
        }

        
        
        
        
        
        
        
        if let nowPlayingItem = musicPlayer.nowPlayingItem {
            
            coverImage.image = nowPlayingItem.artwork?.image(at: coverImage.frame.size)
            let coverArtwork = musicPlayer.nowPlayingItem?.artwork?.image(at: coverImage.frame.size)
            
            if(coverArtwork == nil){
                coverImage.image = UIImage(named: "defaultImage")
            }
            
            songTitleLabel.text = nowPlayingItem.title
            artistLabel.text = nowPlayingItem.artist
            
        } else {
            
            let coverArtwork = musicPlayer.nowPlayingItem?.artwork?.image(at: coverImage.frame.size)
            
            if(coverArtwork == nil){
                coverImage.image = UIImage(named: "defaultImage")
            }
            
            songTitleLabel.text = "Unkown Title"
            artistLabel.text = "Unknown Artist"
        }
    }
    
    
    /*
     Buttons to manage playback functions.
     Methods from MusicKit/ MediaPlayer framework
     Update song metadata when buttons pressed to ensure the correct song's
     information is being displayed.
     */
    
    @IBAction func playButton(_ sender: UIButton) {
        musicPlayer.prepareToPlay()
        musicPlayer.play()
        updateCurrentItemMetadata()
    }
    
    @IBAction func pauseButton(_ sender: UIButton) {
        musicPlayer.pause()
        updateCurrentItemMetadata()
    }
    
    @IBOutlet weak var repeatOnOff: UISwitch!
    
    @IBAction func repeatSwitch(_ sender: UISwitch) {
        if(repeatOnOff.isOn == false){
            
            musicPlayer.repeatMode = .none
        }
        else {
           musicPlayer.repeatMode = .one
        }
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        musicPlayer.skipToNextItem()
        
        updateCurrentItemMetadata()
    }
    
    @IBAction func previousButton(_ sender: UIButton) {
        musicPlayer.skipToPreviousItem()
        updateCurrentItemMetadata()
    }
    
    
    
    
    
    /*
     MOVE TO THE MODEL***********************************?????
     */
    
    @IBAction func fastForwardButton(_ sender: UIButton) {
        var trackTime = musicPlayer.currentPlaybackTime
        
        trackTime += 20.0
        if trackTime >= (musicPlayer.nowPlayingItem?.playbackDuration)! {
            musicPlayer.pause()
            musicPlayer.currentPlaybackTime = 0
        }
        else{
            musicPlayer.currentPlaybackTime = trackTime
        }
    }
    
    @IBAction func rewindButton(_ sender: UIButton) {
        var trackTime = musicPlayer.currentPlaybackTime
        
        trackTime -= 10.0
        if trackTime <= 0 {
            musicPlayer.pause()
            musicPlayer.currentPlaybackTime = 0
        }
        else{
            musicPlayer.currentPlaybackTime = trackTime
        }
    }
    
    @IBAction func songSlider(_ sender: UISlider) {
        musicPlayer.pause()
        musicPlayer.currentPlaybackTime = TimeInterval(trackSlider.value)
        musicPlayer.prepareToPlay()
        musicPlayer.play()
    }
    
    @objc func updateSlider(){
        trackSlider.value = Float(musicPlayer.currentPlaybackTime)
    }
    
    
    
    
    @IBOutlet weak var shuffleOnOff: UISwitch!
    
    //private var shuffleSwitchIsOn = true
    
    @IBAction func shuffleSwitch(_ sender: UISwitch) {
        
        if(shuffleOnOff.isOn == false){
            
            musicPlayer.shuffleMode = .off
        }
        else {
            musicPlayer.shuffleMode = .songs
        }

        
        
        
//        if shuffleSwitchIsOn == true {
//            musicPlayer.shuffleMode = .songs
//        }
//        else{
//            musicPlayer.shuffleMode = .off
//        }
 
        
        
    }
    
    
    
    
    
    
    /*
     Methods to observe the notifications
     Put the update metadata on the main queue to more quickly update the info!!
     Otherwise many times info does not display, bc takes too long.
     And ends up just displaying our default "N/A" info
     */
    @objc func handleMusicPlayerManagerDidUpdateState() {
        DispatchQueue.main.async {
            self.updateCurrentItemMetadata()
        }
    }
    
    /*
     func handleMusicPlayerControllerNowPlayingItemDidChange() {
     NotificationCenter.default.post(name: didUpdateState, object: nil)
     }
     
     */
    
    
    
    
    
}
