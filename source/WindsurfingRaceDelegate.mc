using Toybox.WatchUi;

class WindsurfingRaceDelegate extends WatchUi.BehaviorDelegate {
    var mParentView;

    function initialize(view) {
        BehaviorDelegate.initialize();
        mParentView = view;
    }

    // Call the start stop timer method on the parent view
    // when the select action occurs (start/stop button on most products)
    function onSelect() {
        mParentView.startStopTimer();
        return true;
    }


    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new WindsurfingRaceMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

    // Call the reset method on the parent view when the
    // back action occurs.
    function onBack() {
        return mParentView.resetTimer();
    }
}