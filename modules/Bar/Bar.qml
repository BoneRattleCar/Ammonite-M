import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Widgets
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
            // if (!wholeName) return Tr.trCtx("Desktop", "shown when no window is focused");
            // const reg = /[^—–-]+$/
            // return wholeName.match(reg)[0]
            const reg = /^.*\s[—–-]\s/
            return wholeName.replace(reg, "")

            // const parts = wholeName.split(/\s+[\-\u2013\u2014]\s+/);
            // if (parts.length > 1)
            //     return parts[parts.length - 1].trim();
        }

        MarginWrapperManager { margin: 15 }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

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

            // property var tray:{
            //     console.log(SystemTray.items.values[0].menu)
            //     SystemTray.items.values[0].activate
            // }

            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom

                ColumnLayout {
                    Layout.alignment: Qt.AlignHCenter

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
                                    id:icon
                                    anchors.fill:parent
                                    source: SystemTray.items.values[index].icon
                                }
                            }
                        }
                    }
                }

                ColumnLayout {
                    // anchors.horizontalCenter: parent.horizontalCenter
                    Layout.alignment: Qt.AlignHCenter

                    Text{
                        text:Time.hour
                    }

                    Text{
                        text:Time.mins
                    }
                }
            }
        }
}
