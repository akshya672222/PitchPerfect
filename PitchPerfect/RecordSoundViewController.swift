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
        stopRecordingButton.isEnabled = true
        startRecordingButton.isEnabled = false
        
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
        
//        do{
//            audioRecorder = try AVAudioRecorder(url: filePath!, settings: [:])
//        }catch{
//            
//        }
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag{
            print("Finish recording")
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        }else{
            print("ERROR IN RECORDING!!!")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording"{
            let changeVCObj = segue.destination as! ChangeVoiceViewController
            changeVCObj.recordedAudioURL = sender as! URL
        }
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        lblRecordingLabel.text = "Tap to Record"
        stopRecordingButton.isEnabled = false
        startRecordingButton.isEnabled = true
        
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

