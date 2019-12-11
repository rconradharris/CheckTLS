using Toybox.Application;
using Toybox.Graphics;
using Toybox.System;
using Toybox.WatchUi;

class CheckTLSView extends WatchUi.View {

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    private function formatResponseCode(test, responseCode) {
        var msg = "ERROR";
        if (responseCode == 200) {
            msg = "OK";
        } else if (responseCode == 0) {
            msg = "FAIL";
        }
        return "[ " + msg + " ] " + test[:shortname];
    }

    private function drawResult(dc, x, y, font, test, responseCode) {
        var text = self.formatResponseCode(test, responseCode);
        if (responseCode == 200) {
            dc.setColor(Graphics.COLOR_GREEN, Graphics.COLOR_BLACK);
        } else {
            dc.setColor(Graphics.COLOR_RED, Graphics.COLOR_BLACK);
        }
        dc.drawText(x, y, font, text, Graphics.TEXT_JUSTIFY_CENTER);
    }

    private function getIntroText() {
        var ds = System.getDeviceSettings();
        if (ds.isTouchScreen) {
            return "Tap to Begin";
        }
        return "Click Start/Stop\nto Begin";
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        var app = Application.getApp();

        var tests = app.getTests();

        var cx = dc.getWidth() / 2;
        var y = 25;
        var font = Graphics.FONT_TINY;
        var fontHeight = dc.getFontHeight(font);

        dc.clear();
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);

        var responseCodes = app.getResponseCodes();
        if (responseCodes.size() == 0) {
            dc.drawText(cx, cx, font, self.getIntroText(), Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
            return;
        }

        dc.drawText(cx, y, font, "Results", Graphics.TEXT_JUSTIFY_CENTER);
        y += fontHeight;

        for (var i=0; i < responseCodes.size(); i++) {
            var responseCode = responseCodes[i];
            var test = tests[i];

            self.drawResult(dc, cx, y, font, test, responseCode);
            y += fontHeight;
        }

    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

}
