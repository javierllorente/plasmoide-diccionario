/*
 *  plasmoide-diccionario - Un cliente del diccionario castellano de la RAE
 *              (a Castilian RAE dictionary client)
 *
 *  Copyright (C) 2016 Javier Llorente <javier@opensuse.org>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) version 3.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

import QtQuick 2.0
import QtWebKit 3.0
import QtQuick.Layouts 1.1
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.extras 2.0 as PlasmaExtras

Item {
    readonly property url raeUrl: "http://dle.rae.es/?w="
    width: 365
    height: 485
    
    ColumnLayout {
        anchors.fill: parent
        
        RowLayout {        
            Layout.fillWidth: true
            
            PlasmaComponents.TextField {
                id: textField
                placeholderText: "Introduce aquí el término a consultar"
                clearButtonShown: true
                focus: true
                Layout.fillWidth: true
                onAccepted: consultar(text)
            }
            
            PlasmaComponents.Button {
                iconSource: "edit-find"
                onClicked: consultar(textField.text)
            }
            
        }        
        
        PlasmaExtras.ScrollArea {
            id: webScroll
            Layout.fillWidth: true
            Layout.fillHeight: true
            opacity: 0.1
            
            WebView {
                id: webView
                anchors.fill: parent
                opacity: 1
                onLoadingChanged: {
                    webScroll.opacity = 1
                    logo.opacity = 0
                }
                onNavigationRequested: {
                    var pattern = new RegExp("^(https?)://[a-z0-9]+.rae.es")
                    request.action = pattern.test(request.url) ? WebView.AcceptRequest : WebView.IgnoreRequest
                }
            }
        }
        
    }
    
    PlasmaComponents.BusyIndicator {
        anchors.centerIn: parent
        opacity: webView.loading ? 1: 0
    }
    
    Image {
        id: logo
        anchors.centerIn: parent
        opacity: 0.1
        source: "file:../images/dc_128x128.png"
    }
    
    function consultar(palabra) {
        webView.url = raeUrl + palabra
    }
    
}
