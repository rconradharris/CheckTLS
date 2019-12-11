using Toybox.Communications;
using Toybox.System;
using Toybox.WatchUi;

class CheckTLSDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        System.println("onSelect");
        Communications.startSync();
        return true;
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new CheckTLSMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}