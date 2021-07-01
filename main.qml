import QtQuick 2.4
import QtQuick.Window 2.12
import QtMultimedia 5.15
import QtQuick.Dialogs 1.0

Window {
    id:root
    width: 375
    height: 812
    visible: true
    title: qsTr("Video Contoller")

    FileDialog {
        id: fileDialog
        title: "Choose Video to Play"
        folder: shortcuts.home
        onAccepted: {
            console.log("You chose: " + fileDialog.fileUrls[0])
            video.source = decodeURIComponent(fileDialog.fileUrl)
            video.play()
        }
        onRejected: {
            console.log("Canceled")
            Qt.quit()
        }
    }
    Rectangle{
        id:videoContainer
        width : root.width
        height : 200
        color: "black"

        Video {
            id: video
            source: "/videos/Bunny2.mp4"
            anchors.fill: parent
            onPositionChanged: {
                if (video.position > 1000 && video.duration - video.position < 1000) {
                    video.pause();
                    playButton.text = "Play"
                }
            }
        }
    }

    Button{
        id:playButton
        height: 40
        width: 100
        text: "Play"
        y: video.height + 50
        x: video.width / 2 - playButton.width/2
        onClicked: {
            video.playbackState == MediaPlayer.PlayingState ?
            (
                playButton.text = "Play",
                video.pause()
            )
            :
            (
                playButton.text = "Pause",
                video.play()
            )
            if (video.position > 1000 && video.duration - video.position < 1000) {
                video.seek(0);
                video.play();
                playButton.text = "Pause";
            }
        }
    }
    Button{
        id:fileButton
        height: 40
        width: 100
        text: "Select File"
        y: playButton.y + 80
        x: video.width / 2 - fileButton.width/2
        onClicked: {
            fileDialog.open()
        }
    }
    Slider{
        dialColor:"#B96D48"
        dialSize: 30
        y: videoContainer.height - dialSize/2
        width: root.width
        maximum:  video.duration
        value:    video.position
        minimum: 0
        onClicked: video.seek(value)
    }


}

