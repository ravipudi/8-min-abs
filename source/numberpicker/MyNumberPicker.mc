/**
 *    Copyright (C) 2018 Toomas Römer <toomasr@gmail.com>
 *
 *    Licensed under the Apache License, Version 2.0 (the "License");
 *    you may not use this file except in compliance with the License.
 *    You may obtain a copy of the License at
 *
 *        http://www.apache.org/licenses/LICENSE-2.0
 *
 *    Unless required by applicable law or agreed to in writing, software
 *    distributed under the License is distributed on an "AS IS" BASIS,
 *    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *    See the License for the specific language governing permissions and
 *    limitations under the License.
 */

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as System;
using Toybox.Application as App;

class MyNumberPicker extends Ui.Picker {
	hidden var mPropName;
	hidden var numberFactory = new NumberFactory(5, 95, 5);
	hidden var title = new Ui.Text({:text=>"Seconds",
    							 :locX=>WatchUi.LAYOUT_HALIGN_CENTER});
	
    function initialize(propName) {
    	mPropName = propName;

    	var value = MinuteAbsApp.loadState(mPropName);
    	
        Ui.Picker.initialize({:title => title,
        					  :pattern => [numberFactory],
        					  :defaults => [numberFactory.getIndex(value)]});
    }
    
    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Ui.Picker.onUpdate(dc);
    }
    
    function saveState(value) {
    	MinuteAbsApp.saveState(mPropName, value);
        setOptions({:title => title,
        			  :pattern => [numberFactory],
        			  :defaults => [numberFactory.getIndex(value)]});
    }
}

class MyNumberPickerDelegate extends Ui.PickerDelegate {
	hidden var mPicker;
	
    function initialize(picker) {
        Ui.PickerDelegate.initialize();
        mPicker = picker;
    }

	function onCancel() {
		Ui.popView(Ui.SLIDE_IMMEDIATE);
	}

	function onAccept(values) {
		mPicker.saveState(values[0]);
		Ui.popView(Ui.SLIDE_IMMEDIATE);
	}
}