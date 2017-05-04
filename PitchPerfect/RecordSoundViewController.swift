//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by AKSHAY SUNDERWANI on 21/04/17.
//  Copyright © 2017 AKSHAY SUNDERWANI. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation


class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: - PROPERTIES
    
    @IBOutlet weak var lblRecordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    @IBOutlet weak var startRecordingButton: UIButton!
    var audioRecorder: AVAudioRecorder!

    // MARK: - METHODS
    
    @IBAction func recordVoice(_ sender: Any) {
        lblRecordingLabel.text = "Recording in Progress"
        handleButtonRecordState(false)
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let fileName = "recordVoice.wav"
        let pathArray = [dirPath, fileName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        let audio_session = AVAudioSession.sharedInstance()
        try! audio_session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)

        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
                
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            let alert = UIAlertController(title: "Error", message: "ERROR IN RECORDING!!!", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let changeVCObj = segue.destination as! ChangeVoiceViewController
            changeVCObj.recordedAudioURL = sender as! URL
        }
    }
    
    func handleButtonRecordState(_ enable: Bool) {
        stopRecordingButton.isEnabled = !enable
        startRecordingButton.isEnabled = enable
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        lblRecordingLabel.text = "Tap to Record"
        handleButtonRecordState(true)
        audioRecorder.stop()
        let audio_session = AVAudioSession.sharedInstance()
        try! audio_session.setActive(false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopRecordingButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.accessibilityIdentifier = NSStringFromClass(RecordSoundViewController.self).components(separatedBy: ".").last!
    }
    
}

