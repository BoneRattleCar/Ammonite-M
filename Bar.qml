import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import qs.services
import QtQuick.Shapes
import QtQuick.Effects

PanelWindow {
        readonly property var occupied: {
            const occ = {};
            for (const ws of Hyprland.workspaces.values)
                occ[ws.id] = ws.lastIpcObject.windows > 0;
                console.log(occ[ws.id])
            return occ;
        }

    Text{
        text:"asdasd"
    }
}