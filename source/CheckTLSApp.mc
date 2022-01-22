import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class CheckTLSApp extends Application.AppBase {
    private const TESTS = [
        {
            :shortname => "DigiCert CA-2 G2",
            :fullname => "DigiCert Baltimore CA-2 G2",
            :serial => "08 62 92 85 76 CC 7F 86 5D 1F 7F DF 35 32 58 0D",
            :url => "https://garmin-check-tls.s3.amazonaws.com/test.json",
            :expected => 200
        },
        {
            :shortname => "Comodo ECC",
            :fullname => "COMODO ECC Certification Authority",
            :serial => "1F 47 AF AA 62 00 70 50 54 4C 01 9E 9B 63 99 2A",
            :url => "https://reqres.in/api/users/2",
            :expected => 200
        },
        {
            :shortname => "DST Root CA X3",
            :fullname => "DST Root CA X3",
            :serial => "44 AF B0 80 D6 A3 27 BA 89 30 39 86 2E F8 40 6B",
            :url => "https://www.mocky.io/v2/5cf44057330000585d75865a",
            :expected => 200
        },
        {
            :shortname => "Sectigo RSA",
            :fullname => "Sectigo RSA Domain Validation Secure Server CA",
            :serial => "00 D3 83 BD 9C 5B 36 89 60 BE 39 AA FD 58 23 00 71",
            :url => "https://runcasts.com/garmin/v1/ping",
            :expected => 200
        },
        {
            :shortname => "Digicert SHA2",
            :fullname => "DigiCert SHA2 Extended Validation Server CA",
            :serial => "01 7F 1B 99 5C EA 4F 22 D6 0E DA 77 23 DF 4E B8",
            :url => "https://www.digicert.com/services/v2/user",
            :expected => 403
        }
    ];

    function onSyncDone() {
        WatchUi.switchToView(new CheckTLSView(), new CheckTLSDelegate(), WatchUi.SLIDE_IMMEDIATE);
    }

    function getSyncDelegate() {
        System.println("getSyncDelegate");
        return new SyncDelegate({ :callback => self.method(:onSyncDone),
                                  :tests => self.TESTS });
    }

    function getTests() {
        return self.TESTS;
    }

    function clearResponseCodes() {
        Storage.deleteValue("responseCodes");
    }

    function setResponseCodes(responseCodes) {
        Storage.setValue("responseCodes", responseCodes);
    }

    function getResponseCodes() {
        var r = Storage.getValue("responseCodes");
        return (r != null) ? r : [];
    }

    // Start
    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
        self.clearResponseCodes();
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        return [ new CheckTLSView(), new CheckTLSDelegate() ] as Array<Views or InputDelegates>;
    }

}

function getApp() as CheckTLSApp {
    return Application.getApp() as CheckTLSApp;
}