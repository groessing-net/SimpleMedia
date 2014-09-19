<!DOCTYPE HTML>
<html lang="en">
<head>
    <!-- Force latest IE rendering engine or ChromeFrame if installed -->
    {browserhack condition='IE'}
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    {/browserhack}
    <meta charset="utf-8">
    <title>jQuery File Upload Demo</title>
    <meta name="description" content="File Upload widget with multiple file selection, drag&amp;drop support, progress bars, validation and preview images, audio and video for jQuery. Supports cross-domain, chunked and resumable file uploads and client-side image resizing. Works with any server-side platform (PHP, Python, Ruby on Rails, Java, Node.js, Go etc.) that supports standard HTML form file uploads.">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap styles -->
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    <!-- Generic page styles -->
    <link rel="stylesheet" href="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/css/style.css">
    <!-- blueimp Gallery styles -->
    <link rel="stylesheet" href="http://blueimp.github.io/Gallery/css/blueimp-gallery.min.css">
    <!-- CSS to style the file input field as button and adjust the Bootstrap progress bars -->
    <link rel="stylesheet" href="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/css/jquery.fileupload.css">
    <link rel="stylesheet" href="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/css/jquery.fileupload-ui.css">
    <!-- CSS adjustments for browsers with JavaScript disabled -->
    <noscript><link rel="stylesheet" href="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/css/jquery.fileupload-noscript.css"></noscript>
    <noscript><link rel="stylesheet" href="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/css/jquery.fileupload-ui-noscript.css"></noscript>
</head>
<body>
<div class="container">
    <h1>1. {gt text='Upload media into temporary storage'}</h1>
    <p>
        <strong>{gt text='Allowed file extensions:'}</strong> <span id="theFileFileExtensions">{$modvars.SimpleMedia.allowedExtensions}</span><br />
        <strong>{gt text='Allowed file size:'}</strong> {$modvars.SimpleMedia.maxUploadFileSize*1024|simplemediaGetFileSize:'':false:false}
    </p>


    <!-- The file upload form used as target for the file upload widget -->
    <form id="fileupload" action="//jquery-file-upload.appspot.com/" method="POST" enctype="multipart/form-data">
        <!-- Redirect browsers with JavaScript disabled to the origin page -->
        <noscript><input type="hidden" name="redirect" value="http://blueimp.github.io/jQuery-File-Upload/"></noscript>
        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
        <div class="row fileupload-buttonbar">
            <div class="col-lg-7">
                <!-- The fileinput-button span is used to style the file input field as button -->
                <span class="btn btn-success fileinput-button">
                    <i class="glyphicon glyphicon-plus"></i>
                    <span>Add files...</span>
                    <input type="file" name="files[]" multiple>
                </span>
                <button type="submit" class="btn btn-primary start">
                    <i class="glyphicon glyphicon-upload"></i>
                    <span>Start upload</span>
                </button>
                <button type="reset" class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel upload</span>
                </button>
                <button type="button" class="btn btn-danger delete">
                    <i class="glyphicon glyphicon-trash"></i>
                    <span>Delete</span>
                </button>
                <input type="checkbox" class="toggle">
                <!-- The global file processing state -->
                <span class="fileupload-process"></span>
            </div>
            <!-- The global progress state -->
            <div class="col-lg-5 fileupload-progress fade">
                <!-- The global progress bar -->
                <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                    <div class="progress-bar progress-bar-success" style="width:0%;"></div>
                </div>
                <!-- The extended global progress state -->
                <div class="progress-extended">&nbsp;</div>
            </div>
        </div>
        <!-- The table listing the files available for upload/download -->
        <table role="presentation" class="table table-striped"><tbody class="files"></tbody></table>
    </form>


    <h1>2. {gt text='Move media into collection'}</h1>
    <form action="{modurl modname='SimpleMedia' type='medium' func='multiuploadmove'}" method="post">
        <fieldset>
            <legend>{gt text='Collection'}</legend>
            <div class="z-formrow">
                <label for='simplemedia-collection'>{gt text='Choose the collection to upload media to'}</label>
                <select id="simplemedia-collection" name="collectionStore" class="z-form-dropdownlist">
                    <option value="-1">{gt text='Create new collection'}</option>
                    {foreach from=$collectionItems item='collection'}
                        <option value="{$collection.value}"{if $collection.value == $selectedCollection} selected="selected"{/if}>{$collection.text}</option>
                    {/foreach}
                </select>
            </div>
            <div id="simplemedia-collection-details">
                <div class="z-formrow">
                    <label for="simplemedia_collection_title">{gt text='Title of the new collection for storing media'}:</label>
                    <input required="" id="simplemedia_collection_title" name="collectionStoreTitle" value=''>
                </div>
                <div class="z-formrow">
                    <label for="simplemedia_collection_description">{gt text='Description of the new collection for storing media'}:</label>
                    <input required="" id="simplemedia_collection_description" name="collectionStoreDescription" value=''>
                </div>
                {*-- not implemented yet in handler
                <div class="z-formrow">
                    <label for="simplemedia_collection_category">{gt text='Category of the new collection for storing media'}:</label>
                    <input id="simplemedia_collection_category" name="collectionStoreCategory" value=''>
                </div>
                *}
            </div>
        </fieldset>{*
        <fieldset>
            <legend>{gt text='Media to upload'}</legend>
            <div class="z-formrow">
                <label for="simplemedia_category">{gt text='Category to assign to media'}:</label>
                <input id="simplemedia_category" name="category" value=''>
            </div>
        </fieldset>*}
        <button type="submit" class="btn btn-success btn-lg">{gt text='Move into SimpleMedia collection'}</button>
    </form>
    <br />
    <br />
    <br />
    <br />
    <br />
</div>
<!-- The blueimp Gallery widget -->
<div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls" data-filter=":even">
    <div class="slides"></div>
    <h3 class="title"></h3>
    <a class="prev">‹</a>
    <a class="next">›</a>
    <a class="close">×</a>
    <a class="play-pause"></a>
    <ol class="indicator"></ol>
</div>
<!-- The template to display files available for upload -->
<script id="template-upload" type="text/x-tmpl">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td>
            <span class="preview"></span>
        </td>
        <td>
            <p class="name">{%=file.name%}</p>
    <strong class="error text-danger"></strong>
    </td>
    <td>
    <p class="size">Processing...</p>
    <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>
    </td>
    <td>
    {% if (!i && !o.options.autoUpload) { %}
                <button class="btn btn-primary start" disabled>
                    <i class="glyphicon glyphicon-upload"></i>
                    <span>Start</span>
                </button>
            {% } %}
    {% if (!i) { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel</span>
                </button>
            {% } %}
    </td>
    </tr>
    {% } %}
</script>
<!-- The template to display files available for download -->
<script id="template-download" type="text/x-tmpl">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        <td>
            <span class="preview">
                {% if (file.thumbnailUrl) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
                {% } %}
            </span>
        </td>
        <td>
            <p class="name">
                {% if (file.url) { %}
                    <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
                {% } else { %}
                    <span>{%=file.name%}</span>
                {% } %}
            </p>
            {% if (file.error) { %}
                <div><span class="label label-danger">Error</span> {%=file.error%}</div>
    {% } %}
        </td>
        <td>
            <span class="size">{%=o.formatFileSize(file.size)%}</span>
        </td>
        <td>
            {% if (file.deleteUrl) { %}
                <button class="btn btn-danger delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                    <i class="glyphicon glyphicon-trash"></i>
                    <span>Delete</span>
                </button>
                <input type="checkbox" name="delete" value="1" class="toggle">
            {% } else { %}
                <button class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>Cancel</span>
                </button>
            {% } %}
        </td>
    </tr>
{% } %}
</script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
<script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/js/vendor/jquery.ui.widget.js"></script>
<!-- The Templates plugin is included to render the upload/download listings -->
<script src="http://blueimp.github.io/JavaScript-Templates/js/tmpl.min.js"></script>
<!-- The Load Image plugin is included for the preview images and image resizing functionality -->
<script src="http://blueimp.github.io/JavaScript-Load-Image/js/load-image.min.js"></script>
<!-- The Canvas to Blob plugin is included for image resizing functionality -->
<script src="http://blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
<!-- Bootstrap JS is not required, but included for the responsive demo navigation -->
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<!-- blueimp Gallery script -->
<script src="http://blueimp.github.io/Gallery/js/jquery.blueimp-gallery.min.js"></script>
<!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
<script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/js/jquery.iframe-transport.js"></script>
<!-- The basic File Upload plugin -->
<script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/js/jquery.fileupload.js"></script>
<!-- The File Upload processing plugin -->
<script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/js/jquery.fileupload-process.js"></script>
<!-- The File Upload image preview & resize plugin -->
<script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/js/jquery.fileupload-image.js"></script>
<!-- The File Upload audio preview plugin -->
<script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/js/jquery.fileupload-audio.js"></script>
<!-- The File Upload video preview plugin -->
<script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/js/jquery.fileupload-video.js"></script>
<!-- The File Upload validation plugin -->
<script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/js/jquery.fileupload-validate.js"></script>
<!-- The File Upload user interface plugin -->
<script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.7.0/js/jquery.fileupload-ui.js"></script>
<!-- The main application script -->
<script>
/*
 * jQuery File Upload Plugin JS Example 8.9.1
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */

/* global $, window */

$(function () {
    'use strict';

    // Initialize the jQuery File Upload widget:
    $('#fileupload').fileupload({
        // Uncomment the following to send cross-domain cookies:
        //xhrFields: {withCredentials: true},
        url: '{{modurl modname='SimpleMedia' type='medium' func='multiUploadSave' assign='url'}}{{$url}}'
    });

    // Enable iframe cross-domain access via redirect option:
    $('#fileupload').fileupload(
        'option',
        'redirect',
        window.location.href.replace(
            /\/[^\/]*$/,
            '/cors/result.html?%s'
        )
    );

    // Load existing files:
    $('#fileupload').addClass('fileupload-processing');
    $.ajax({
        // Uncomment the following to send cross-domain cookies:
        //xhrFields: {withCredentials: true},
        url: $('#fileupload').fileupload('option', 'url'),
        dataType: 'json',
        context: $('#fileupload')[0]
    }).always(function () {
        $(this).removeClass('fileupload-processing');
    }).done(function (result) {
        $(this).fileupload('option', 'done')
            .call(this, $.Event('done'), {result: result});
    });
});
</script>
<!-- The XDomainRequest Transport is included for cross-domain file deletion for IE 8 and IE 9 -->
{browserhack condition='(gte IE 8)&(lt IE 10)'}
<script src="js/cors/jquery.xdr-transport.js"></script>
{/browserhack}
<script type="text/javascript">
    $(function() {
        function toggleCollectionSettings() {
            if($('#simplemedia-collection').val() == '-1') {
                $('#simplemedia-collection-details').show();
                $('#simplemedia-collection-details').find('input').attr('required', '');
            } else {
                $('#simplemedia-collection-details').hide();
                $('#simplemedia-collection-details').find('input').removeAttr('required');
            }
        }
        toggleCollectionSettings();
        $('#simplemedia-collection').change(toggleCollectionSettings);
    });
</script>
</body>
</html>
