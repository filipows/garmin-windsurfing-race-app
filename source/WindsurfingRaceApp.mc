using Toybox.Application;
using Toybox.WatchUi;

// This is the primary entry point of the application.
// Since we are using the :background annotation to include only the
// required code in the background process, we must annotate the
// application base so it can be accessed in the background process
(:background)
class WindsurfingRaceApp extends Application.AppBase {
    var mTimerView;
    var mBackgroundData;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
        if( mTimerView ) {
            mTimerView.saveProperties();
            mTimerView.setBackgroundEvent();
        }
        Toybox.System.println(mProperties);
    }

    // This method is called when data is returned from our
    // Background process.
    function onBackgroundData(data) {
        if( mTimerView ) {
            mTimerView.backgroundEvent(data);
        } else {
            mBackgroundData = data;
        }
    }


    // Return the initial view of your application here
    // This method runs each time the main application starts.
    function getInitialView() {
        mTimerView = new WindsurfingRaceView(mBackgroundData);
        mTimerView.deleteBackgroundEvent();
        return [mTimerView, new WindsurfingRaceDelegate(mTimerView)];
    }

    // This method runs each time the background process starts.
    function getServiceDelegate(){
        return [new BackgroundTimerServiceDelegate()];
    }

}



// Global method for getting a key from the object store
// with a specified default. If the value is not in the
// store, the default will be saved and returned.
function objectStoreGet(key, defaultValue) {
    var value = Application.getApp().getProperty(key);
    if((value == null) && (defaultValue != null)) {
        value = defaultValue;
        Application.getApp().setProperty(key, value);
        }
    return value;
}

// Global method for putting a key value pair into the
// object store. This method doesn't do anything that
// setProperty doesn't do, but provides a matching function
// to the objectStoreGet method above.
function objectStorePut(key, value) {
    Application.getApp().setProperty(key, value);
}