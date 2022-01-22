import Toybox.Communications;
import Toybox.Lang;
import Toybox.WatchUi;

class CheckTLSDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        Communications.startSync();
        return true;
    }
}