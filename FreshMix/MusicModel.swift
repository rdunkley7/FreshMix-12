//
//  MusicModel.swift
//  FreshMix
//
//  Created by Dunkley, Rachel A on 11/18/18.
//  Copyright © 2018 Dunkley, Rachel A. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer



class MusicModel{
    //Song list array
    let genrePlaylist: [String] = ["Alternative",
                                   "Alternative & Punk",
                                   "Electronic",
                                   "Hip-Hop/Rap",
                                   "Indie Rock",
                                   "Latin",
                                   "Pop",
                                   "R&B/Soul",
                                   "Rock" ]
    struct genreData{
        
        let cell : Int!
        let text : String!
        let coverImage: UIImage!
        
    }
    
    
    var genreIconArray = [genreData]()
    
    func loadGenreIcons(){
        genreIconArray = [genreData(cell : 1, text : "Alternative", coverImage: #imageLiteral(resourceName: "AlternativeImage copy")),
                          genreData(cell : 2, text : "Alternative & Punk", coverImage: #imageLiteral(resourceName: "punk copy")),
                          genreData(cell : 3, text : "Electronic", coverImage: #imageLiteral(resourceName: "electronic copy")),
                          genreData(cell : 4, text : "Hip-Hop/Rap", coverImage: #imageLiteral(resourceName: "hipHopImage copy")),
                          genreData(cell : 5, text : "Indie Rock", coverImage: #imageLiteral(resourceName: "indieArt2 copy")),
                          genreData(cell : 6, text : "Latin", coverImage: #imageLiteral(resourceName: "latinoImage copy")),
                          genreData(cell : 7, text : "Pop", coverImage: #imageLiteral(resourceName: "popMicrophoneIcon copy")),
                          genreData(cell : 8, text : "R&B/Soul", coverImage: #imageLiteral(resourceName: "microphoneIcon")),
                          genreData(cell : 9, text : "Rock", coverImage: #imageLiteral(resourceName: "rockImage copy"))
        ]
    }
    
    
    
    
    
    
    
    var genre: String = "Pop"
    
    //Get song/artist info?? from MPMediaPlayer class??
    
    
    var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    /*
    func getTrackTime() {
        
        if let nowPlayingItem = musicPlayer.nowPlayingItem{
            var trackTime = musicPlayer.currentPlaybackTime
        }
        
    
    
    
    }
    
    
    
    func rewind(){
        var trackTime = musicPlayer.currentPlaybackTime
        
        trackTime -= 10.0
        if trackTime <= 0 {
            musicPlayer.pause()
            musicPlayer.currentPlaybackTime = 0
        }
        else{
            musicPlayer.currentPlaybackTime = trackTime
        }

        
        if musicPlayerController.currentPlaybackTime < 5 {
            // If the currently playing `MPMediaItem` is less than 5 seconds into playback then skip to the previous item.
            musicPlayerController.skipToPreviousItem()
        } else {
            // Otherwise skip back to the beginning of the currently playing `MPMediaItem`.
            musicPlayerController.skipToBeginning()
        }
        
        
    }
        
     */
        
        
    }
    
    /*
    extension UIImageView {
        
        func setRounded() {
            let radius = self.frame.width / 2
            self.layer.cornerRadius = radius
            self.layer.masksToBounds = true
        }
 */



