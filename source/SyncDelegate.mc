using Toybox.Application;
using Toybox.Communications;
using Toybox.System;
using Toybox.WatchUi;

class SyncDelegate extends Communications.SyncDelegate {

    private var mIdx = -1;
    private var mTests;
    private var mResponseCodes = [];
    private var mCallback;

    function initialize(options) {
        Communications.SyncDelegate.initialize();
        self.mCallback = options[:callback];
        self.mTests = options[:tests];
    }

    private function nextTest() {
        self.mIdx++;
        return (self.mIdx < self.mTests.size()) ? self.mTests[self.mIdx] : null;
    }

    private function finish() {
        Application.getApp().setResponseCodes(self.mResponseCodes);

        Communications.notifySyncComplete(null);
        if (self.mCallback != null) {
            self.mCallback.invoke();
        }
    }

    function doTest(responseCode, data) {
        System.println("responseCode=" + responseCode);
        if (self.mIdx >= 0) {
            // Skip printing first result (mIdx = -1) because that was just
            // there to prime the pump
            var percentageComplete = (self.mIdx + 1) * 100 /  self.mTests.size();
            Communications.notifySyncProgress(percentageComplete);
            self.mResponseCodes.add(responseCode);
        }

        var test = self.nextTest();
        if (test == null) {
            // No more tests...
            self.finish();
            return;
        }

        // More tests, keep the chain going...
        Communications.makeWebRequest(test[:url], {}, {
                :method => Communications.HTTP_REQUEST_METHOD_GET,
                :headers => { "Content-Type" => Communications.REQUEST_CONTENT_TYPE_JSON },
                :responseType => Communications.HTTP_RESPONSE_CONTENT_TYPE_JSON
            },
            self.method(:doTest)
        );
    }

    function onStartSync() {
        System.println("onStartSync");
        // Prime the pump to begin...
        self.doTest(200, null);
    }

    function onStopSync() {
        System.println("onStopSync");
        Communications.cancelAllRequests();
        Communications.notifySyncComplete(null);
    }

    function isSyncNeeded() {
        System.println("isSyncNeeded");
        return true;
    }


}