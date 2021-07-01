import QtQuick 2.0

Item {
    id:root
    property color dialColor: "black"
    property color barColor: "gray"
    property real value
    property int dialRadius: 50
    signal moved ()

    Rectangle {
        id: container
        anchors.fill: parent
        color: "transparent"

        Rectangle{
            id:bar
            width: container.width
            height: root.dialRadius/4
            radius: bar.height/2
            color: root.barColor
            Rectangle{
                id:innerBar
                height: bar.height; radius: bar.radius
                width: bar.width*root.value
                color: root.dialColor
            }
        }

        // Dial
        Rectangle {
            id: dial
            x: root.value*(container.width) - dial.width/2
            y: 1 - dial.height/2 + bar.height/2
            width: root.dialRadius; height: root.dialRadius
            radius: width/2
            color: root.dialColor

            MouseArea {
                anchors.fill: parent
                drag.target: dial
                drag.axis: Drag.XAxis
                drag.minimumX: 0
                drag.maximumX: (container.width)+dial.radius
                onHoveredChanged: {
                    console.log(hoverEnabled)
                }
                onPositionChanged: {
                    root.moved()
                    root.value = dial.x/(container.width+ dial.width)
                }
                onPressAndHold: {
                    console.log(root.value)
                }
                onEntered: {
                   console.log("Entered")
                }
                onExited: {
                    console.log("Exited")
                }
            }
        }

    }
}
