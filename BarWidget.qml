import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: barWidget
    width: layout.implicitWidth + 16
    height: 32 // Standard bar height placeholder

    property string batteryLevel: "Unknown"

    Process {
        id: batteryPoller
        command: ["dualsensectl", "battery"]
        running: false
        onStdoutLinesChanged: {
            if (stdoutLines.length > 0 && stdoutLines[0] !== "") {
                batteryLevel = stdoutLines[0]
            }
        }
    }

    Timer {
        interval: 60000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            batteryPoller.running = true
        }
    }

    RowLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 8

        Text {
            // Gamepad icon (using Nerd Fonts or similar)
            text: "\uf11b" // FontAwesome gamepad icon as placeholder
            color: Theme.on_surface // Uses Noctalia Theme Material Design 3 property
            font.pixelSize: 16
        }

        Text {
            text: barWidget.batteryLevel
            color: Theme.on_surface
            font.pixelSize: 14
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            if (typeof openPanel === "function") {
                openPanel()
            } else {
                console.log("openPanel function not found in context")
            }
        }
    }
}
