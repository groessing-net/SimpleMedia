SimpleMedia 2
=============
SimpleMedia is file and media management in Collections.
This module is intended for being used with Zikula 1.3.x. Later on when Zikula Core 1.4.0 is stable enough the code will be re-generated with MOST and made ready for Zikula 1.4.0.

ModuleStudio
------------
The basic module with data structure is generated with MOST (http://modulestudio.de/ by Guite aka Axel) and only for the latest Zikula >= 1.3.x.
The Code is being converted to ModuleStudio 0.6.1 (via the webgen interface of MOST) at the moment, and is not stable and completed yet :-( Hang on.

See for more information the wiki page: https://github.com/zikula-ev/SimpleMedia/wiki

Zikula Core 1.3.5/6 Patches
---------------------------
FIXED in 1.3.7
There are some small patches to make sure the latest generated MOST modules also work well in Zikula core 1.3.5 and 1.3.6. These patches
are incorporated into Zikula Core 1.3.7. See also http://modulestudio.de/documentation/c/95-Troubleshooting#TroubleshootingGeneration
* Patch for category selector. Due to a bug in the category selector in Zikula 1.3.5 and 1.3.6 you will run into problems when trying to save an entity with categories. To solve this just merge the fix shown in https://github.com/zikula/core/pull/1561/files and you are done.
* Unable to find workflow file. If you get this error you have generated an application for Zikula 1.3.5/1.3.6 which contains a small bug that is fixed in 1.3.7. Please apply the fix shown in https://github.com/zikula/core/commit/f7e3379e7060859aab334be6707fe6e0ab61baf8 in order to fix the error.
* duplicate key issue with categories https://github.com/zikula/core/pull/1566

Template development & overrides
--------------------------------

Templates are being developed by first putting them in /config with a template_override and after being final they will 
go in the module templates folder. So during development the contents of the config folder needs to be copied to /config.
template_overrides_sm2.yml serves as example template_overrides to use for this.
