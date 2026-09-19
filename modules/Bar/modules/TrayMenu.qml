import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../../"
import "../../../services"

PanelWindow {
    id: root

    property int animSpeed: 300

    property var menuItem: null
    property real targetY: 1000
    property bool _itemHovered: false
    property bool _panelHovered: false

    property bool hovering: menuItem !== null
    property bool closing: false

    property int lastHeight: 200

    onHoveringChanged: {
        if (!hovering)
            closing = true
    }

    visible: hovering || closing

    function notifyHover(item, y) {
        _itemHovered = true
        hideTimer.stop()
        menuItem = item
        targetY = y

        // visualRect.width = menuColumn.implicitWidth + 24
        visualRect.width = 250
        ib1.rounding = 20
        ib2.rounding = 20
    }

    function notifyLeave() {
        _itemHovered = false
        hideTimer.restart()
    }

    Timer {
        id: hideTimer
        interval: 100
        onTriggered: {
            if (!root._itemHovered && !root._panelHovered)
                // root.menuItem = null
                visualRect.width = 0
                ib1.rounding = 0;
                ib2.rounding = 0;
        }
    }

    QsMenuOpener {
        id: menuOpener
        menu: root.menuItem && root.menuItem.hasMenu ? root.menuItem.menu : null

        Behavior on menu {
            SequentialAnimation {
                NumberAnimation {
                    target: menuColumn
                    property: "opacity"
                    to: 0
                    duration:0
                }
                PropertyAction {}
                NumberAnimation {
                    target: menuColumn
                    property: "opacity"
                    to: 1
                    duration:200

                }
            }
        }

    }

    // implicitWidth: visualRect.width*2
    implicitWidth: 500
    implicitHeight: 400

    mask: Region {
        item: visualRect
    }

    color: "transparent"
    WlrLayershell.namespace: "quickshell-tray-menu"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
    exclusiveZone: -1

    anchors.left: true
    anchors.top: true
    margins.left: 45
    margins.top: targetY - implicitHeight / 2
    Behavior on margins.top { NumberAnimation { duration: root.animSpeed; easing.type: Easing.OutCubic } }

    Rectangle {
        id: visualRect
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        color: Theme.surfaceContainer
        topRightRadius:10
        bottomRightRadius:10
        clip: true

        //managed by notifyHover on top so dunno why this was here
        // width: root.hovering ? (menuColumn.implicitWidth + 24) : 0
        // width: root.hovering ? 250 : 0


        //to change to last height when hovering out
        // height: {
        //     root.menuItem ? menuColumn.implicitHeight + 16 : root.lastHeight
        // }

        height: menuColumn.implicitHeight + 16


        Behavior on width {
            NumberAnimation {
                id: widthAnim
                duration: root.animSpeed
                easing.type: Easing.OutCubic
                onRunningChanged: {
                    if (!running && !root.hovering)
                        root.closing = false
                }
            }
        }
        Behavior on height { NumberAnimation { duration: root.animSpeed; easing.type: Easing.OutCubic } }

        HoverHandler {
            onHoveredChanged: {
                root._panelHovered = hovered
                if (hovered) hideTimer.stop()
                else hideTimer.restart()
            }
        }

        ColumnLayout {
            id: menuColumn
            // anchors.centerIn: parent
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin:15

            spacing: 2

            Repeater {
                model: menuOpener.children
                delegate: Text {
                    Layout.fillWidth: true
                    required property var modelData
                    visible: !modelData.isSeparator
                    text: modelData.text
                    color: modelData.enabled ? Theme.primary : "#6c7086"
                    horizontalAlignment: Text.AlignLeft

                    TapHandler {
                        enabled: modelData.enabled
                        onTapped: {
                            modelData.triggered()
                            root.notifyLeave()
                        }
                    }
                }
            }
        }
    }

    InvertedBorder {
        id: ib1
        roundingColor: Theme.surfaceContainer
        rounding: 0
        rotation:180
        anchors.bottom:visualRect.top
        anchors.topMargin: -20

        Behavior on rounding { NumberAnimation { duration: root.animSpeed; easing.type: Easing.OutCubic } }
    }
    InvertedBorder {
        id: ib2
        roundingColor: Theme.surfaceContainer
        rounding: 0
        rotation: -90
        anchors.top:visualRect.bottom
        anchors.bottomMargin: -20

        Behavior on rounding { NumberAnimation { duration: root.animSpeed; easing.type: Easing.OutCubic } }
    }
}