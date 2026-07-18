using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Activity;
using Toybox.Application;

class VisualGearsField extends WatchUi.DataField {

    // Class variables
    hidden var frontGear = null;
    hidden var rearGear = null;
    
    // Constructor
    function initialize() {
        DataField.initialize();
    }

    // Called when data is updated
    function compute(info) {
        // Access derailleur information
        if (info has :frontDerailleurIndex && info.frontDerailleurIndex != null) {
            frontGear = info.frontDerailleurIndex;
        }
        if (info has :rearDerailleurIndex && info.rearDerailleurIndex != null) {
            rearGear = info.rearDerailleurIndex;
        }
        
        // Return true to indicate data was processed
        return true;
    }
    
    // Update the display
    function onUpdate(dc) {
        // Clear the display
        dc.setColor(Graphics.COLOR_TRANSPARENT, Graphics.COLOR_BLACK);
        dc.clear();
        
        // Draw gear information display
        drawGearInfo(dc);
    }
    
   // Draw gear information display with rectangles
function drawGearInfo(dc) {
    // Constants for display settings
    var DEBUG = false;                   // Set debug information to false
    var RECT_SPACING = 4;                // Spacing between rectangles
    var RECT_BORDER = 2;                 // Border thickness
    var TEXT_HEIGHT = 15;                // Height for debug text
    var MARGIN = 8;                      // Margin around the edges
    var ROW_SPACING = 5;                 // Vertical spacing between rows
    
    // Device-specific offsets
    var deviceOffset = 0;
    
    // Detect device and apply appropriate offset
    var deviceType = System.getDeviceSettings().partNumber;
    if (deviceType != null) {
        if (deviceType.find("1050") != null) {
            deviceOffset = 6;  // Edge 1050 needs +6 offset
        } else if (deviceType.find("540") != null) {
            deviceOffset = 3;  // Edge 540 needs +3 offset
        } else {
            deviceOffset = 6;
        }
        // Add more device-specific offsets as needed
    }
    
    // Get display dimensions
    var width = dc.getWidth();
    var height = dc.getHeight();

    // Scale gear rectangles so the two rows plus the ratio text
    // fill the full height of the data field
    var ratioTextHeight = dc.getFontHeight(Graphics.FONT_MEDIUM);
    var rectHeight = (height - (2 * MARGIN) - ratioTextHeight - (2 * ROW_SPACING)) / 2;
    if (rectHeight < 10) {
        rectHeight = 10;  // Keep rectangles visible on very short fields
    }
    
    // Set colors - updated for white background and black rectangles
    var colorBackground = Graphics.COLOR_WHITE;
    var colorBorder = Graphics.COLOR_BLACK;
    var colorSelected = Graphics.COLOR_BLACK;
    var colorUnselected = Graphics.COLOR_WHITE;
    var colorText = Graphics.COLOR_BLACK;
    
    // Fill background with white
    dc.setColor(colorBackground, colorBackground);
    dc.fillRectangle(0, 0, width, height);
    
    // ----- Get gear information -----
    var frontGearMax = 0;
    var frontGearIndex = 0;
    var frontGearSize = 0;  // Number of teeth on front gear
    var rearGearMax = 0;
    var rearGearIndex = 0;
    var rearGearSize = 0;  // Number of teeth on rear gear
    
    // Get the gear information from Activity Info
    var info = Activity.getActivityInfo();
    if (info has :frontDerailleurMax && info.frontDerailleurMax != null) {
        frontGearMax = info.frontDerailleurMax;
    }
    if (info has :frontDerailleurIndex && info.frontDerailleurIndex != null) {
        frontGearIndex = info.frontDerailleurIndex;
    }
    if (info has :frontDerailleurSize && info.frontDerailleurSize != null) {
        frontGearSize = info.frontDerailleurSize;
    }
    if (info has :rearDerailleurMax && info.rearDerailleurMax != null) {
        rearGearMax = info.rearDerailleurMax;
    }
    if (info has :rearDerailleurIndex && info.rearDerailleurIndex != null) {
        rearGearIndex = info.rearDerailleurIndex;
    }
    if (info has :rearDerailleurSize && info.rearDerailleurSize != null) {
        rearGearSize = info.rearDerailleurSize;
    }
    
    // Fallback values if no data available (common setups)
    if (frontGearMax == 0 || frontGearMax == null) {
        frontGearMax = 2;
    }
    if (rearGearMax == 0 || rearGearMax == null) {
        rearGearMax = 11;
    }
    if (frontGearSize == 0 || frontGearSize == null) {
        frontGearSize = 42;  // Common chainring size
    }
    if (rearGearSize == 0 || rearGearSize == null) {
        rearGearSize = 15;  // Common cog size
    }
    
    // Calculate usable width accounting for margins
    var usableWidth = width - (2 * MARGIN);
    
    // Calculate rectangle width for rear gears (base calculation)
    var rearRectWidth = (usableWidth - (RECT_SPACING * (rearGearMax - 1))) / rearGearMax;
    
    // Calculate rectangle width for front gears (same calculation)
    var frontRectWidth = rearRectWidth;
    
    // ----- Draw Rear Gears (bottom row, full width) -----
    // Draw rear gear rectangles - full width with margins
    for (var i = 0; i < rearGearMax; i++) {
        var x = MARGIN + i * (rearRectWidth + RECT_SPACING);
        var y = MARGIN + rectHeight + ROW_SPACING;
        
        // Selected gear gets filled, others get border only
        if (i + 1 == rearGearIndex) {  // +1 because indexes are 1-based
            // Draw selected gear (filled rectangle)
            dc.setColor(colorSelected, colorBackground);
            dc.fillRectangle(x, y, rearRectWidth, rectHeight);
        } else {
            // Draw unselected gear (border only)
            dc.setColor(colorBorder, colorBackground);
            dc.drawRectangle(x, y, rearRectWidth, rectHeight);
        }
    }
    
    // ----- Draw Front Gears (top row, right-aligned) -----
    // Calculate the total width that will be used by front gear rectangles
    var frontTotalWidth = (frontGearMax * frontRectWidth) + ((frontGearMax - 1) * RECT_SPACING);
    
    // Calculate starting X to center the front gear row with device-specific offset
    var frontStartX = width - MARGIN - frontTotalWidth - deviceOffset;
    
    // Draw front gear rectangles
    for (var i = 0; i < frontGearMax; i++) {
        var x = frontStartX + i * (frontRectWidth + RECT_SPACING);
        var y = MARGIN;  // Add top margin
        
        // Selected gear gets filled, others get border only
        if (i + 1 == frontGearIndex) {  // +1 because indexes are 1-based
            // Draw selected gear (filled rectangle)
            dc.setColor(colorSelected, colorBackground);
            dc.fillRectangle(x, y, frontRectWidth, rectHeight);
        } else {
            // Draw unselected gear (border only)
            dc.setColor(colorBorder, colorBackground);
            dc.drawRectangle(x, y, frontRectWidth, rectHeight);
        }
    }
    
    // ----- Draw Gear Ratio Text -----
    // Position for gear ratio text (below the rectangles, anchored to the bottom)
    var ratioY = height - MARGIN - ratioTextHeight;
    
    // Draw gear ratio text
    dc.setColor(colorText, colorBackground);
    var ratioText = frontGearSize + " / " + rearGearSize;
    dc.drawText(width/2, ratioY, Graphics.FONT_MEDIUM, ratioText, Graphics.TEXT_JUSTIFY_CENTER);
    
    // Debug section has been retained but will not execute since DEBUG = false
    if (DEBUG) {
        var debugY = ratioY + TEXT_HEIGHT + 10;
        dc.setColor(colorText, colorBackground);
        
        // Display gear indexes and counts
        var debugText = "F: " + frontGearIndex + "/" + frontGearMax + 
                       " R: " + rearGearIndex + "/" + rearGearMax;
        dc.drawText(width/2, debugY, Graphics.FONT_TINY, debugText, Graphics.TEXT_JUSTIFY_CENTER);
        
        // If available, calculate and show gear ratio
        if (frontGearSize > 0 && rearGearSize > 0) {
            debugY += TEXT_HEIGHT + 2;
            var ratio = frontGearSize.toFloat() / rearGearSize.toFloat();
            var ratioCalcText = "Ratio: " + ratio.format("%.2f");
            dc.drawText(width/2, debugY, Graphics.FONT_TINY, ratioCalcText, Graphics.TEXT_JUSTIFY_CENTER);
        }
        
        // Show battery level if available
        debugY += TEXT_HEIGHT + 2;
        dc.drawText(width/2, debugY, Graphics.FONT_TINY, "Batt: N/A", Graphics.TEXT_JUSTIFY_CENTER);
    }
}
}