import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import qs.Services.UI

Rectangle {
    id: panelSettings
    width: 300
    height: 400
    color: Color.mSurface // Uses Material Design 3 surface color
    radius: 12

    Process {
        id: cmdRunner
        property string currentCommand: ""
        command: currentCommand.split(" ")
    }

    function runCommand(cmd) {
        cmdRunner.currentCommand = cmd;
        cmdRunner.running = true;
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        Text {
            text: "DualSense Settings"
            color: Color.mOnSurface
            font.pixelSize: 18
            font.bold: true
        }

        // Trigger Settings
        Text {
            text: "Trigger Modes"
            color: Color.mOnSurfaceVariant
        }
        RowLayout {
            ComboBox {
                id: sideCombo
                model: ["left", "right"]
            }
            ComboBox {
                id: modeCombo
                model: ["off", "feedback", "weapon", "bow", "galloping", "machine", "choppy", "vibrate"]
            }
            Button {
                text: "Apply"
                onClicked: {
                    runCommand("dualsensectl trigger " + sideCombo.currentText + " " + modeCombo.currentText + " 0")
                }
            }
        }

        // Lightbar Settings
        Text {
            text: "Lightbar Color (RGB)"
            color: Color.mOnSurfaceVariant
        }
        RowLayout {
            SpinBox { id: rBox; from: 0; to: 255; value: 0 }
            SpinBox { id: gBox; from: 0; to: 255; value: 0 }
            SpinBox { id: bBox; from: 0; to: 255; value: 255 }
            Button {
                text: "Set"
                onClicked: {
                    runCommand("dualsensectl lightbar " + rBox.value + " " + gBox.value + " " + bBox.value)
                }
            }
        }

        // Player LEDs
        Text {
            text: "Player LEDs (1-5)"
            color: Color.mOnSurfaceVariant
        }
        RowLayout {
            Repeater {
                model: 5
                Button {
                    text: (index + 1).toString()
                    onClicked: {
                        runCommand("dualsensectl player-leds " + (index + 1))
                    }
                }
            }
        }

        Item {
            Layout.fillHeight: true // Spacer
        }
    }
}
