import QtQuick
import QtQuick.Effects

Rectangle {
    id: root
    color: "#000000"

    property int stage
    readonly property real logoSize: Math.min(width, height) * 0.4
    // ring starts at the right end of the gap in the logo and runs clockwise
    readonly property real gapDeg: 9.4
    readonly property real startDeg: -90 + 17
    property real progress: 0

    onStageChanged: {
        if (stage >= 1) intro.start()
        progress = Math.min(1, stage / 6)
        if (stage == 6) fadeOut.start()
    }
    Behavior on progress { NumberAnimation { duration: 700; easing.type: Easing.OutCubic } }

    Item {
        id: glow
        width: root.logoSize * 2.6
        height: width
        anchors.centerIn: parent
        opacity: 0

        Image { anchors.fill: parent; source: "images/glow_orange.png"; opacity: 1.0 - glowBlue.opacity }
        Image {
            id: glowBlue
            anchors.fill: parent
            source: "images/glow_blue.png"
            opacity: 0

            SequentialAnimation on opacity {
                running: true
                loops: Animation.Infinite
                NumberAnimation { to: 1.0; duration: 3500; easing.type: Easing.InOutSine }
                NumberAnimation { to: 0.0; duration: 3500; easing.type: Easing.InOutSine }
            }
        }
    }

    Item {
        id: logo
        width: root.logoSize
        height: width
        anchors.centerIn: parent
        opacity: 0
        scale: 0.85
        transformOrigin: Item.Center

        // flame: gentle breathing
        Image {
            id: flame
            anchors.fill: parent
            source: "images/logo_flame.png"
            smooth: true
            mipmap: true
            transformOrigin: Item.Center

            SequentialAnimation on scale {
                running: true
                loops: Animation.Infinite
                NumberAnimation { from: 1.0; to: 1.03; duration: 1800; easing.type: Easing.InOutSine }
                NumberAnimation { to: 1.0; duration: 1800; easing.type: Easing.InOutSine }
            }
        }

        // ring: dim track + bright part that fills as the session loads
        Image {
            anchors.fill: parent
            source: "images/logo_ring.png"
            smooth: true
            mipmap: true
            opacity: 0.18
        }

        Item {
            id: pie
            anchors.fill: parent
            visible: false
            layer.enabled: true

            Canvas {
                anchors.fill: parent
                property real p: root.progress
                onPChanged: requestPaint()
                onPaint: {
                    var ctx = getContext("2d")
                    ctx.reset()
                    var r = Math.PI / 180
                    var c = width / 2
                    ctx.fillStyle = "#ffffff"
                    ctx.beginPath()
                    ctx.moveTo(c, c)
                    ctx.arc(c, c, width, root.startDeg * r, (root.startDeg + p * (360 - root.gapDeg)) * r, false)
                    ctx.closePath()
                    ctx.fill()
                }
            }
        }

        Image {
            id: ringBright
            anchors.fill: parent
            source: "images/logo_ring.png"
            smooth: true
            mipmap: true
            layer.enabled: true
            layer.effect: MultiEffect {
                maskEnabled: true
                maskSource: pie
                maskThresholdMin: 0.5
                maskSpreadAtMin: 0.1
            }
        }
    }

    ParallelAnimation {
        id: intro
        NumberAnimation { target: logo; property: "opacity"; to: 1; duration: 700; easing.type: Easing.OutCubic }
        NumberAnimation { target: logo; property: "scale"; to: 1; duration: 900; easing.type: Easing.OutBack }
        NumberAnimation { target: glow; property: "opacity"; to: 1; duration: 1500 }
    }

    NumberAnimation {
        id: fadeOut
        target: root
        property: "opacity"
        to: 0
        duration: 400
    }

    Component.onCompleted: intro.start()
}
