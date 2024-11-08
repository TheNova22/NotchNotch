import SwiftUI
import Foundation

// Define a class for the song info
class SpotifyNowPlaying: ObservableObject {
    @Published var songTitle: String = "Unknown"
    @Published var artist: String = "Unknown"
    @Published var album: String = "Unknown"
    @Published var imageUrl: String = "https://img.freepik.com/free-vector/modern-question-mark-template-idea-message-vector_1017-47932.jpg"

    init() {
        getCurrentSong()
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
                self.getCurrentSong()
        }
    }
    
    func goToNextSong() {
        let script = """
        tell application "Spotify"
            if it is running and player state is playing then
                play next track
                set currentTrack to name of current track
                set currentArtist to artist of current track
                set currentAlbum to album of current track
                set currentUrl to artwork url of current track
                return currentTrack & "||" & currentArtist & "||" & currentAlbum & "||" & currentUrl
            else
                return "No song playing"
            end if
        end tell
        """
        if let appleScript = NSAppleScript(source: script) {
            var error: NSDictionary?
            if let output = appleScript.executeAndReturnError(&error).stringValue {
                let components = output.components(separatedBy: "||")
                if components.count == 4 {
                    DispatchQueue.main.async {
                        self.songTitle = components[0]
                        self.artist = components[1]
                        self.album = components[2]
                        self.imageUrl = components[3]
                    }
                }
            } else {
                print("AppleScript error: \(String(describing: error))")
            }
        }
    }
    
    func goToPrevSong() {
        let script = """
        tell application "Spotify"
            if it is running and player state is playing then
                play previous track
                set currentTrack to name of current track
                set currentArtist to artist of current track
                set currentAlbum to album of current track
                set currentUrl to artwork url of current track
                return currentTrack & "||" & currentArtist & "||" & currentAlbum & "||" & currentUrl
            else
                return "No song playing"
            end if
        end tell
        """
        if let appleScript = NSAppleScript(source: script) {
            var error: NSDictionary?
            if let output = appleScript.executeAndReturnError(&error).stringValue {
                let components = output.components(separatedBy: "||")
                if components.count == 4 {
                    DispatchQueue.main.async {
                        self.songTitle = components[0]
                        self.artist = components[1]
                        self.album = components[2]
                        self.imageUrl = components[3]
                    }
                }
            } else {
                print("AppleScript error: \(String(describing: error))")
            }
        }
    }
    
    func playPause() {
        let script = """
        tell application "Spotify"
            if it is running then
                if player state is paused then
                    play
                else
                    pause
                end if
                return "Completed"
            else
                return "Spotify is not running"
            end if
        end tell
        """
        if let appleScript = NSAppleScript(source: script) {
            var error: NSDictionary?
            if let output = appleScript.executeAndReturnError(&error).stringValue {
                print(output)
            } else {
                print("AppleScript error: \(String(describing: error))")
            }
        }
    }

    func getCurrentSong() {
        let script = """
        tell application "Spotify"
            if it is running and player state is playing then
                set currentTrack to name of current track
                set currentArtist to artist of current track
                set currentAlbum to album of current track
                set currentUrl to artwork url of current track
                return currentTrack & "||" & currentArtist & "||" & currentAlbum & "||" & currentUrl
            else
                return "No song playing"
            end if
        end tell
        """
        
        if let appleScript = NSAppleScript(source: script) {
            var error: NSDictionary?
            if let output = appleScript.executeAndReturnError(&error).stringValue {
                let components = output.components(separatedBy: "||")
                if components.count == 4 {
                    DispatchQueue.main.async {
                        self.songTitle = components[0]
                        self.artist = components[1]
                        self.album = components[2]
                        self.imageUrl = components[3]
                    }
                }
            } else {
                print("AppleScript error: \(String(describing: error))")
            }
        }
    }
}
