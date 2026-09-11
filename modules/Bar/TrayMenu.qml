import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Wayland
import "../../"

PanelWindow {
    id: root

    property var menuItem: null
    property real targetY: 1000
    property bool _itemHovered: false
    property bool _panelHovered: false

    property bool hovering: menuItem !== null
    property bool closing: false

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
        ib1.rounding = 20

    }

    function notifyLeave() {
        _itemHovered = false
        hideTimer.restart()
    }

    Timer {
        id: hideTimer
        interval: 150
        onTriggered: {
            if (!root._itemHovered && !root._panelHovered)
                root.menuItem = null
                ib1.rounding = 0
        }
    }

    QsMenuOpener {
        id: menuOpener
        menu: root.menuItem && root.menuItem.hasMenu ? root.menuItem.menu : null
    }

    implicitWidth: 320
    implicitHeight: 600

    color: "transparent"
    WlrLayershell.namespace: "quickshell-tray-menu"
    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
    exclusiveZone: -1

    anchors.left: true
    anchors.top: true
    margins.left: 45
    margins.top: targetY - implicitHeight / 2
    Behavior on margins.top { NumberAnimation { duration: 150; easing.type: Easing.OutCubic } }

    Rectangle {
        id: visualRect
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        color: "#ffffff"
        topRightRadius:8
        bottomRightRadius:8
        clip: true

        width: root.hovering ? (menuColumn.implicitWidth + 24) : 0
        height: menuColumn.implicitHeight + 16

        Behavior on width {
            NumberAnimation {
                id: widthAnim
                duration: 1500
                easing.type: Easing.OutCubic
                onRunningChanged: {
                    if (!running && !root.hovering)
                        root.closing = false
                }
            }
        }
        Behavior on height { NumberAnimation { duration: 1500; easing.type: Easing.OutCubic } }

        HoverHandler {
            onHoveredChanged: {
                root._panelHovered = hovered
                if (hovered) hideTimer.stop()
                else hideTimer.restart()
            }
        }

        ColumnLayout {
            id: menuColumn
            anchors.centerIn: parent
            spacing: 2

            Repeater {
                model: menuOpener.children
                delegate: Text {

                    required property var modelData
                    visible: !modelData.isSeparator
                    text: modelData.text
                    color: modelData.enabled ? "#000000" : "#6c7086"

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
        roundingColor:"#ffc0ca"
        rounding: 20
        rotation:180
        anchors.top:visualRect.top
        anchors.topMargin: -20
        transformOrigin: BottomLeft

        Behavior on rounding { NumberAnimation { duration: 1500; easing.type: Easing.OutCubic } }

    }
}