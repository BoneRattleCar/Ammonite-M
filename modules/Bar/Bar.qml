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
            const occ = {};
            Hyprland.workspaces.values.map(ws=>occ[ws.id]=ws.active);
            return occ;
        }

        readonly property var acWin: {
            const wholeName= Hyprland.activeToplevel?.title
            const reg = /^.*\s[—–-]\s/
            return wholeName.replace(reg, "")
        }

        MarginWrapperManager { margin: 15 }

        Rectangle {
            id: content
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                anchors.horizontalCenter: parent.horizontalCenter
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

            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom

                ColumnLayout {
                    id: trayColumn
                    Layout.alignment: Qt.AlignHCenter
                    property int hoveredIndex: -1
                    property real hoveredY: 0

                    Repeater {
                        model:SystemTray.items.values

                        delegate: Item{
                            id: trayItem
                            required property var modelData
                            required property int index

                            implicitWidth:25
                            implicitHeight:25

                            Image{
                                id:trayIcon
                                anchors.fill:parent
                                source: modelData.icon
                            }

                            HoverHandler {
                                onHoveredChanged: {
                                    if(hovered){
                                        trayColumn.hoveredIndex = index
                                        trayColumn.hoveredY = trayItem.mapToItem(null, 0, trayItem.height / 2).y
                                        trayMenu.notifyHover(modelData, trayColumn.hoveredY)
                                    } else {
                                        trayMenu.notifyLeave()
                                    }
                                }
                            }
                        }
                    }

                    TrayMenu {
                        id: trayMenu
                    }
                }

                ColumnLayout {
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