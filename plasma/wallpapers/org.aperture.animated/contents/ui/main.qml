import QtQuick
import org.kde.plasma.plasmoid

WallpaperItem {
    id: root

    readonly property bool animate: root.configuration.Animate
    readonly property bool centered: root.configuration.Centered
    readonly property real logoSize: Math.min(width, height) * 0.42
    readonly property real cx: width * (centered ? 0.5 : 0.7)
    readonly property real cy: height * 0.5

    Rectangle {
        anchors.fill: parent
        color: "#000000"
    }

    // glow: starts logo-orange, slowly drifts to logo-blue and back
    Image {
        id: glowOrange
        source: "../images/glow_orange.png"
        width: root.logoSize * 3
        height: width
        x: root.cx - width / 2
        y: root.cy - height / 2
        opacity: 1.0 - glowBlue.opacity
    }

    Image {
        id: glowBlue
        source: "../images/glow_blue.png"
        width: glowOrange.width
        height: width
        x: glowOrange.x
        y: glowOrange.y
        opacity: 0.0

        SequentialAnimation on opacity {
            running: root.animate
            loops: Animation.Infinite
            PauseAnimation { duration: 3000 }
            NumberAnimation { to: 1.0; duration: 7000; easing.type: Easing.InOutSine }
            PauseAnimation { duration: 3000 }
            NumberAnimation { to: 0.0; duration: 7000; easing.type: Easing.InOutSine }
        }
    }

    // ripples
    Repeater {
        model: 2
        Image {
            id: ripple
            required property int index
            source: "../images/ripple.png"
            width: root.logoSize * 1.1
            height: width
            x: root.cx - width / 2
            y: root.cy - height / 2
            opacity: 0.0
            scale: 1.0

            SequentialAnimation {
                running: root.animate
                loops: Animation.Infinite
                PauseAnimation { duration: ripple.index * 3000 }
                ParallelAnimation {
                    NumberAnimation { target: ripple; property: "scale"; from: 1.0; to: 1.9; duration: 6000; easing.type: Easing.OutQuad }
                    SequentialAnimation {
                        NumberAnimation { target: ripple; property: "opacity"; from: 0.0; to: 0.45; duration: 600 }
                        NumberAnimation { target: ripple; property: "opacity"; to: 0.0; duration: 5400; easing.type: Easing.OutQuad }
                    }
                }
            }
        }
    }

    // logo: slow breathing and float
    Image {
        id: logo
        source: "../images/logo.png"
        width: root.logoSize
        height: width
        smooth: true
        mipmap: true
        x: root.cx - width / 2
        y: root.cy - height / 2
        transformOrigin: Item.Center

        SequentialAnimation on scale {
            running: root.animate
            loops: Animation.Infinite
            NumberAnimation { from: 1.0; to: 1.04; duration: 3500; easing.type: Easing.InOutSine }
            NumberAnimation { to: 1.0; duration: 3500; easing.type: Easing.InOutSine }
        }
        SequentialAnimation on rotation {
            running: root.animate
            loops: Animation.Infinite
            NumberAnimation { from: -1.2; to: 1.2; duration: 5000; easing.type: Easing.InOutSine }
            NumberAnimation { to: -1.2; duration: 5000; easing.type: Easing.InOutSine }
        }
    }
}
