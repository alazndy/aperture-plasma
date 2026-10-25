import QtQuick
import QtQuick.Controls as QQC2
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    id: root
    property bool cfg_Centered
    property bool cfg_CenteredDefault
    property bool cfg_Animate
    property bool cfg_AnimateDefault

    QQC2.CheckBox {
        Kirigami.FormData.label: i18n("Logo:")
        text: i18n("Centered")
        checked: root.cfg_Centered
        onToggled: root.cfg_Centered = checked
    }
    QQC2.CheckBox {
        text: i18n("Animate")
        checked: root.cfg_Animate
        onToggled: root.cfg_Animate = checked
    }
}
