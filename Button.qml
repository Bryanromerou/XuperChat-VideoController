import QtQuick 2.0

Item {
    id: root
    width: 100
    height: 100
    property string text
    property color bgColor: "white"
    property color bgColorSelected: "#bdbdbd"
    property color textColor: "black"
    property color textColorSelected: "white"
    property alias enabled: mouseArea.enabled
    property alias radius: bgr.radius

    signal clicked

    Rectangle {
        id: bgr
        anchors.fill: parent
        color: mouseArea.pressed ? bgColorSelected : bgColor
        radius: height / 15
        border.width: 1

        Text {
            id: text
            anchors.centerIn: parent
            text: root.text
            font.pixelSize: 0.4 * parent.height
            color: mouseArea.pressed ? textColorSelected : textColor
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                root.clicked()
            }
        }
    }
}
