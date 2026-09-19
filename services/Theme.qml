pragma Singleton
import Quickshell
import Quickshell.Io
import QtQuick

Singleton{
    id: root

    property var colors: ({})
    property var hct: ({})

    FileView {
        id: themeFile
        watchChanges: true
        onFileChanged: this.reload()

        path: Quickshell.shellDir + "/services/theme.json"

        JsonAdapter {
            property var accent: "#8C8BA9"

            property var hct: ({
                hue: 285.68,
                chroma: 20.12,
                tone: 58.89
            })

            property var colors: ({})
        }

        onLoaded: {
            // root.accent = this.adapter.accent
            // root.hct = this.adapter.hct
            root.colors = this.adapter.colors
        }
    }

    property color accent: colors.accent ?? "#8C8BA9"

    property color background: colors.background ?? "#0E0E12"
    property color onBackground: colors.onBackground ?? "#E7E4F0"

    property color surface: colors.surface ?? "#0E0E12"
    property color surfaceDim: colors.surfaceDim ?? "#0E0E12"
    property color surfaceBright: colors.surfaceBright ?? "#2C2B34"

    property color surfaceContainerLowest: colors.surfaceContainerLowest ?? "#000000"
    property color surfaceContainerLow: colors.surfaceContainerLow ?? "#131318"
    property color surfaceContainer: colors.surfaceContainer ?? "#ff0000"
    property color surfaceContainerHigh: colors.surfaceContainerHigh ?? "#1F1F26"
    property color surfaceContainerHighest: colors.surfaceContainerHighest ?? "#25252E"

    property color onSurface: colors.onSurface ?? "#E7E4F0"
    property color surfaceVariant: colors.surfaceVariant ?? "#25252E"
    property color onSurfaceVariant: colors.onSurfaceVariant ?? "#ACAAB5"

    property color outline: colors.outline ?? "#76747F"
    property color outlineVariant: colors.outlineVariant ?? "#484750"

    property color primary: colors.primary ?? "#C4C2EE"
    property color primaryDim: colors.primaryDim ?? "#B6B5E0"
    property color onPrimary: colors.onPrimary ?? "#3D3D61"
    property color primaryContainer: colors.primaryContainer ?? "#4F4F74"
    property color onPrimaryContainer: colors.onPrimaryContainer ?? "#E2E0FF"

    property color secondary: colors.secondary ?? "#C6C4DD"
    property color secondaryDim: colors.secondaryDim ?? "#B8B6CF"
    property color onSecondary: colors.onSecondary ?? "#3F3E52"
    property color secondaryContainer: colors.secondaryContainer ?? "#3A3A4D"
    property color onSecondaryContainer: colors.onSecondaryContainer ?? "#BFBDD5"

    property color tertiary: colors.tertiary ?? "#FFE7FD"
    property color tertiaryDim: colors.tertiaryDim ?? "#FCD2FE"
    property color onTertiary: colors.onTertiary ?? "#6D4D72"
    property color tertiaryContainer: colors.tertiaryContainer ?? "#FCD2FE"
    property color onTertiaryContainer: colors.onTertiaryContainer ?? "#644569"

    property color error: colors.error ?? "#F97386"
    property color errorDim: colors.errorDim ?? "#C44B5F"
    property color onError: colors.onError ?? "#490013"
    property color errorContainer: colors.errorContainer ?? "#871C34"
    property color onErrorContainer: colors.onErrorContainer ?? "#FF97A3"

    property color success: colors.success ?? "#B5CCBA"
    property color onSuccess: colors.onSuccess ?? "#213528"
    property color successContainer: colors.successContainer ?? "#374B3E"
    property color onSuccessContainer: colors.onSuccessContainer ?? "#D1E9D6"
}