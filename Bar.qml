import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Wayland
import qs.services
import QtQuick.Shapes
import QtQuick.Effects
import QtQuick.Layouts

PanelWindow {
        id:root
        readonly property var occupied: {
            // const occ = {};
            // for (const ws of Hyprland.workspaces.values)
            //     occ[ws.id] = ws.lastIpcObject.windows > 0;
            //     console.log(occ[ws.id])
            // return occ;

            // console.log(Hyprland.activeToplevel.title)
            const occ = {};
            // Hyprland.workspaces.values.map(ws=>console.log(ws.id));
            // console.log(Hyprland.workspaces.values)
            Hyprland.workspaces.values.map(ws=>occ[ws.id]=ws.active);
            // console.log(JSON.stringify(occ, null, 2))
            return occ;
        }

        readonly property var acWin: {
            const wholeName= Hyprland.activeToplevel?.title
            // console.log(wholeName)
            if (!wholeName) return "Desktop";
            // console.log(wholeName)
            const reg = /[^—–-]+$/
            // console.log(wholeName.match(reg)[0] ?? 'Desktop')
            return wholeName.match(reg)[0]
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            // anchors.verticalCenter: parent.verticalCenter
            color:"#ffc0ca"
            implicitWidth:30
            implicitHeight:150
            radius:15

            ColumnLayout{
                anchors.centerIn: parent
                Repeater {
                    model: 5
                    Rectangle {
                        required property int index
                        color:`${occupied[index+1] ? "black" : occupied.hasOwnProperty(index+1) ? "gray" : "white"}`
                        implicitWidth:15
                        implicitHeight:15
                        radius:15
                    }
                }
            }
        }


        Text{
            id:text
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text:root.acWin
            rotation:-90

            Behavior on text {
                // enabled: text.animate

                SequentialAnimation {
                    NumberAnimation {
                        target: text
                        property: "opacity"
                        to: 0
                        duration:100
                    }
                    PropertyAction {}
                    NumberAnimation {
                        target: text
                        property: "opacity"
                        to: 1
                        duration:100

                    }
                }
            }
        }

        property var tray:{
            // console.log(SystemTray.items.values.length)
            // SystemTray.items.values[0].activate
        }

        ColumnLayout {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            Repeater {
                model:SystemTray.items.values.length
                Item{
                    implicitWidth:25
                    implicitHeight:25

                    MouseArea {
                        anchors.fill:parent
                        acceptedButtons: Qt.LeftButton | Qt.RightButton
                        onClicked: event=>{
                            if (event.button === Qt.LeftButton) SystemTray.items.values[index].secondaryActivate()

                        }

                        Image{
                            anchors.fill:parent
                            source: SystemTray.items.values[index].icon
                        }
                    }

                }
            }
        }
}