External Packages used in SimpleMedia
=====================================
This folder contains some external libraries/packages that are used inside the module.

jsCropperUI
-----------
Used for cropping image thumbnails
* Version 1.2.2
* http://www.defusion.org.uk/code/javascript-image-cropper-ui-using-prototype-scriptaculous/
* BSD license
* Prototype/Scriptaculous based
* Alternatives: see https://github.com/zikula-ev/SimpleMedia/issues/83

flvplayer
---------
Used for playing flash files
* Version unclear
* http://www.jwplayer.com/
* JWPlayer 5 & 6 have CC licenses and not for commercial use. 
* Uses SWFObject 1.5: http://blog.deconcept.com/swfobject/ MIT license
* Replace with a modern HTML5 player (with fallback) that can do this and is MIT licensed

mp3
---
Used for playing mp3 files, details unclear, replace with a HTML5 player (with fallback).

jQuery-File-Upload by Blueimp 
-----------------------------
Will be used for directly uploading a set of images and creating multiple medium entities.
* Version 9.5.6
* http://blueimp.github.io/jQuery-File-Upload/
* MIT license
* jQuery / HTML5

Twitter Bootstrap
-----------------
Is used in the jQuery-File-Upload templates
* Version 3.1.1
* http://getbootstrap.com/
* MIT license and copyright 2014 Twitter
* jQuery, Glyphicons

Masonry
-------
Cascading grid layout library for frontend gallery display of images.
* Version v3.1.4
* https://github.com/desandro/masonry
* MIT license
* jQuery is not required to use Masonry. But if you do enjoy jQuery, Masonry works with it as a jQuery plugin.

getID3
------
getID3 is a PHP script that extracts useful information from images, MP3s & other multimedia file formats.
EXIF/IPTC/XMP metadata is extracted from the medium. Removed helperapps from package
* Version v1.10.x beta
* http://www.getid3.org / https://github.com/JamesHeinrich/getID3
* LGPLv3

Blueimp Bootstrap Image Gallery
-------------------------------
Used in the frontend for media image display
* Version 3.1.0
* http://blueimp.github.io/Bootstrap-Image-Gallery/
* MIT license
* Bootstrap 3 and jQuery based
* Alternative: blueimp non-bootstrap gallery

Blueimp Javascript libraries
----------------------------
Used in the jQuery-File-Upload frontend display. All MIT licensed
* JS templating engine: https://github.com/blueimp/JavaScript-Templates
* JS preview and resizing images: https://github.com/blueimp/JavaScript-Load-Image
* JS image resizing: https://github.com/blueimp/JavaScript-Canvas-to-Blob
