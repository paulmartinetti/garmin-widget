import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Math;
import Toybox.WatchUi;

class InfoWidgetView extends WatchUi.View {
  function initialize() { View.initialize(); }

  // Load your resources here
  function onLayout(dc as Dc) as Void { setLayout(Rez.Layouts.MainLayout(dc)); }

  // Called when this View is brought to the foreground. Restore
  // the state of this View and prepare it to be shown. This includes
  // loading resources into memory.
  function onShow() as Void {}

  // Update the view
  function onUpdate(dc as Dc) as Void {
    var info = Activity.getActivityInfo();
    var alt;
    if (info has :altitude) {
      alt = Math.round(info.altitude);

    } else {
      alt = 9999;
    }
    // drop the decimal
    // https://developer.garmin.com/connect-iq/api-docs/Toybox/Lang/Number.html#format-instance_function
    var altStr = Lang.format("$1$", [alt.format("%d")]);
    var view = View.findDrawableById("Alt") as Text;
    view.setText("Altitude: " + altStr);
    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}
}
