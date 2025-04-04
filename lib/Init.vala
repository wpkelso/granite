/*
 * Copyright 2021 elementary, Inc. (https://elementary.io)
 * SPDX-License-Identifier: LGPL-3.0-or-later
 */

namespace Granite {
    private static bool initialized = false;

    /**
     * Initializes Granite.
     * If Granite has already been initialized, the function will return.
     * Makes sure translations and types for Granite are set up properly.
     * @since 7.2.0
     */
    [Version (since = "7.2.0")]
    public void init () {
        if (initialized) {
            return;
        }

        typeof (Granite.Settings).ensure ();

        unowned var display_manager = Gdk.DisplayManager.@get ();
        display_manager.display_opened.connect (StyleManager.init_for_display);

        foreach (unowned var display in display_manager.list_displays ()) {
            StyleManager.init_for_display (display);
        }

        GLib.Intl.bindtextdomain (Granite.GETTEXT_PACKAGE, Granite.LOCALEDIR);
        GLib.Intl.bind_textdomain_codeset (Granite.GETTEXT_PACKAGE, "UTF-8");
        initialized = true;
    }
}
