//
// Reference links
// https://developer.garmin.com/connect-iq/connect-iq-basics/app-types/#widgets
// https://developer.garmin.com/connect-iq/core-topics/glances/#glances
//
//
//

import Toybox.Activity;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.Math;
import Toybox.WatchUi;

( : glance) class MyGlanceView extends WatchUi.GlanceView {
  function initialize() { GlanceView.initialize(); }

  function onUpdate(dc) {
    // dc.setColor(Graphics.COLOR_BLACK,Graphics.COLOR_BLACK);
    // dc.clear();
    // dc.setColor(0x12d9db,Graphics.COLOR_TRANSPARENT);

    // dc.drawText(dc.getWidth()/2, 5, Graphics.FONT_TINY,"Données",
    // Graphics.TEXT_JUSTIFY_CENTER); 

    // dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_TINY,"Par ici -->",
    // Graphics.TEXT_JUSTIFY_CENTER);
    var h = dc.getHeight() / 3;
    dc.setColor(0x000091, Graphics.COLOR_TRANSPARENT);
    dc.fillCircle(0, h * 1.5, h);
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    dc.fillCircle(h * 2, h * 1.5, h);
    dc.setColor(0xE1000F, Graphics.COLOR_TRANSPARENT);
    dc.fillCircle(h * 4, h * 1.5, h);
    // x and y coordinates were iterations of trial and error
    dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
    dc.drawText(12, 35, Graphics.FONT_LARGE,"J'", Graphics.TEXT_JUSTIFY_LEFT); 
    dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_TRANSPARENT);
    dc.drawText(55, 35, Graphics.FONT_LARGE,"aime", Graphics.TEXT_JUSTIFY_LEFT); 

  }
}

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
    var press;
    // 
    if (info has : altitude) {
      alt = Math.round(info.altitude);

    } else {
      alt = 9999;
    }
    // pressure in Pascals captured from the watch sensor
    // https://developer.garmin.com/connect-iq/api-docs/Toybox/Activity/Info.html#ambientPressure-var
    if (info has : ambientPressure) {
      press = info.ambientPressure;
      // in simulator it's null because there is no pressure sensor in the laptop
      if (press == null) {
        press = 999;
      }
      // convert from Pascals to inches of Mercury
      press *= 0.0002953;
    } else {
      press = 9999;
    }
    // drop the decimal
    // https://developer.garmin.com/connect-iq/api-docs/Toybox/Lang/Number.html#format-instance_function
    var altStr = Lang.format("$1$", [alt.format("%d")]);
    var view = View.findDrawableById("Alt") as Text;
    view.setText("Altitude: " + altStr);
    // format two decimal places
    var pdStr = Lang.format("$1$", [press.format("%.2f")]);
    var pd = View.findDrawableById("Press") as Text;
    pd.setText("Pression: " + pdStr);
    // Call the parent onUpdate function to redraw the layout
    View.onUpdate(dc);
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}
}
