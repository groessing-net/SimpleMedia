{* purpose of this template: show output of multi upload action in user area *}
{* include file='user/header.tpl' *}
{* purpose of this template: header for user area *}
{* pageaddvar name='javascript' value='prototype'}
{pageaddvar name='javascript' value='validation'}
{pageaddvar name='javascript' value='zikula'}
{pageaddvar name='javascript' value='livepipe'}
{pageaddvar name='javascript' value='zikula.ui'}
{pageaddvar name='javascript' value='zikula.imageviewer'}
{pageaddvar name='javascript' value='modules/SimpleMedia/javascript/SimpleMedia.js' *}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    <div class="z-frontendbox">
        <h2><img src="modules/SimpleMedia/images/sm2_16x16.png" width=16 height=16 alt='' /> {gt text='SimpleMedia' comment='This is the title of the header template'}</h2>
        {modulelinks modname='SimpleMedia' type='user'}
    </div>
{/if}
{insert name='getstatusmsg'}

{*
<!-- Force latest IE rendering engine or ChromeFrame if installed -->
<!--[if IE]>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<![endif]-->
*}

{pageaddvar name='stylesheet' value='modules/SimpleMedia/lib/vendor/bootstrap-3.1.1/css/bootstrap.min.css'}
{pageaddvar name='stylesheet' value='modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/css/jquery.fileupload.css'}
{pageaddvar name='stylesheet' value='modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/css/jquery.fileupload-ui.css'}
<!-- CSS adjustments for browsers with JavaScript disabled -->
{pageaddvarblock name='header'}
<noscript><link rel="stylesheet" href="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/css/jquery.fileupload-noscript.css"></noscript>
<noscript><link rel="stylesheet" href="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/css/jquery.fileupload-ui-noscript.css"></noscript>
{/pageaddvarblock}

{pageaddvar name='javascript' value='jQuery'}
{pageaddvar name='javascript' value='jQuery-ui'}

<div class="simplemedia-multiupload">
    {gt text='MultiUpload of Media' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    <p>{gt text='Explanation of how to upload, how it works'}</p>

    <!-- The file upload form used as target for the file upload widget -->
    <form class="z-form z-linear" id="simplemedia-fileupload" action="{modurl modname='SimpleMedia' type='user' func='multiUploadSave'}" method="post" enctype="multipart/form-data">
		<input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
        <!-- Redirect browsers with JavaScript disabled to the origin page -->
        <noscript><input type="hidden" name="redirect" value="http://blueimp.github.io/jQuery-File-Upload/"></noscript>
		
		<fieldset>
		<legend>{gt text='The collection for storing the media'}</legend>
		<div class="z-formrow">
			<label for='simplemedia-collection'>{gt text='Store media in collection'}</label>
			<select id="simplemedia-collection" name="collection" class="z-form-dropdownlist">
			<option value="-1">{gt text='Create new collection'}</option>
			{foreach from=$collectionItems item='collection'}
			<option value="{$collection.value}"{if $collection.value == $selectedCollection} selected="selected"{/if}>{$collection.text}</option>
			{/foreach}
			</select>
		</div>
		<div id="simplemedia-collection-details">
			<div class="z-formrow">
				<label for="simplemedia_collection_title">{gt text='Title of the new collection for storing media'}:</label> 
				<input id="simplemedia_collection_title" name="collectionTitle" value=''>
			</div>
			<div class="z-formrow">
				<label for="simplemedia_collection_description">{gt text='Description of the new collection for storing media'}:</label> 
				<input id="simplemedia_collection_description" name="collectionDescription" value=''>
			</div>
			<div class="z-formrow">
				<label for="simplemedia_collection_category">{gt text='Category of the new collection for storing media'}:</label> 
				<input id="simplemedia_collection_category" name="collectionCategory" value=''>
			</div>
		</div>
		</fieldset>
		<fieldset>
		<legend>{gt text='Media to upload'}</legend>
		<div class="z-formrow">
			<label for="simplemedia_category">{gt text='Category to assign to media'}:</label>
			<input id="simplemedia_category" name="category" value=''>
		</div>
		
        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
        <div class="z-buttonrow fileupload-buttonbar">
            <div class="col-lg-7">
                <!-- The fileinput-button span is used to style the file input field as button -->
                <span class="btn btn-success fileinput-button">
                    <i class="glyphicon glyphicon-plus"></i>
                    <span>{gt text='Add files...'}</span>
                    <input type="file" name="files[]" multiple>
                </span>
                <button type="submit" class="btn btn-primary start">
                    <i class="glyphicon glyphicon-upload"></i>
                    <span>{gt text='Start upload'}</span>
                </button>
                <button type="reset" class="btn btn-warning cancel">
                    <i class="glyphicon glyphicon-ban-circle"></i>
                    <span>{gt text='Cancel upload'}</span>
                </button>
                {* <button type="button" class="btn btn-danger delete">
                    <i class="glyphicon glyphicon-trash"></i>
                    <span>{gt text='Delete'}</span>
                </button>
                <input type="checkbox" class="toggle"> *}
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
		<table width="100%" role="presentation" class="table table-striped"><tbody class="files"></tbody></table>
		</fieldset>
    </form>

	{*-- Optionally use other template for upload/download links https://github.com/blueimp/jQuery-File-Upload/wiki/Template-Engine --*}
    {*-- The template to display files available for upload --*}
    <script id="template-upload" type="text/x-tmpl">
    {% for (var i=0, file; file=o.files[i]; i++) { %}
        <tr class="template-upload fade">
            <td>
                <span class="preview"></span>
            </td>
            <td>
                <label>{{gt text='Title'}}: <input name="title[]" {{* optional required *}}></label>
				<br />
                <label>{{gt text='Description'}}: <input name="description[]"></label>
            </td>
            <td>
                <p class="name">{%=file.name%}</p>
				<strong class="error text-danger"></strong>
            </td>
            <td>
            <p class="size">{{gt text='Processing files...'}}</p>
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

    {*-- The template to display files available for download (Javascript Template) --*}
	{*-- The actual downloading part should be removed, since this will not be via multiUpload ! --*}
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
        </tr>
    {% } %}
    </script>
	
	{* jQuery and jQueryUI are loaded with pagevar *}
    <!-- <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script> -->
    <!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
    <!-- <script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/js/vendor/jquery.ui.widget.js"></script> -->
    <!-- The Templates plugin is included to render the upload/download listings -->
    <script src="modules/SimpleMedia/lib/vendor/blueimp-js/tmpl.min.js"></script>
    <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
    <script src="modules/SimpleMedia/lib/vendor/blueimp-js/load-image.min.js"></script>
    <!-- The Canvas to Blob plugin is included for image resizing functionality -->
    <script src="modules/SimpleMedia/lib/vendor/blueimp-js/canvas-to-blob.min.js"></script>
    <!-- Bootstrap JS is not required, but included for the responsive demo navigation -->
    <!-- <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.3/js/bootstrap.min.js"></script> -->
    <!-- blueimp Gallery script -->
    <!-- <script src="http://blueimp.github.io/Gallery/js/jquery.blueimp-gallery.min.js"></script> -->
	
	{*-- The scripts for the actual uploading --*}
    <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
    <script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/js/jquery.iframe-transport.js"></script>
    <!-- The basic File Upload plugin -->
    <script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/js/jquery.fileupload.js"></script>
    <!-- The File Upload processing plugin -->
    <script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/js/jquery.fileupload-process.js"></script>
    <!-- The File Upload image preview & resize plugin -->
    <script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/js/jquery.fileupload-image.js"></script>
    <!-- The File Upload audio preview plugin -->
    <script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/js/jquery.fileupload-audio.js"></script>
    <!-- The File Upload video preview plugin -->
    <script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/js/jquery.fileupload-video.js"></script>
    <!-- The File Upload validation plugin -->
    <script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/js/jquery.fileupload-validate.js"></script>
    <!-- The File Upload user interface plugin -->
    <script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/js/jquery.fileupload-ui.js"></script>

    {*-- script for loading fileupload and binding the various elements --*}
    <script>
        /* global $, window */
        jQuery(function () {
            'use strict';

            // Initialize the jQuery File Upload widget:
            jQuery('#simplemedia-fileupload').fileupload({
                // Uncomment the following to send cross-domain cookies:
                //xhrFields: {withCredentials: true},
                url: 'index.php?module=simplemedia&type=user&func=multiUploadSave',
				type: 'POST',
				dataType: 'json',
				fileInput: jQuery('input:file')
				/*
				limitMultiFileUploads: 3,
				limitMultiFileUploadSize: 100000,
				sequentialUploads: true to process upload sequential iso of parallel,
				
				*/
            });

            // Enable iframe cross-domain access via redirect option:
			// DISABLED
            /* 
			jQuery('#simplemedia-fileupload').fileupload(
                    'option',
                    'redirect',
                    window.location.href.replace(
                            /\/[^\/]*$/,
                            '/cors/result.html?%s'
                    )
            );
			*/

            // Load existing files:
			// NOT NEEDED FOR SM2
			/*
            jQuery('#simplemedia-fileupload').addClass('fileupload-processing');
            jQuery.ajax({
                // Uncomment the following to send cross-domain cookies:
                //xhrFields: {withCredentials: true},
                url: jQuery('#fileupload').fileupload('option', 'url'),
                dataType: 'json',
                context: jQuery('#fileupload')[0]
            }).always(function () {
                jQuery(this).removeClass('fileupload-processing');
            }).done(function (result) {
                jQuery(this).fileupload('option', 'done')
                        .call(this, jQuery.Event('done'), {result: result});
            });
			*/
			
            // Make sure the additional form fields are also uploaded
			// These fields can be added per file or in general
			// form fields can be made required if needed
            jQuery('#simplemedia-fileupload').bind('fileuploadsubmit', function (e, data) {
                var inputs = data.context.find(':input');
                if (inputs.filter('[required][value=""]').first().focus().length) {
                    data.context.find('button').prop('disabled', false);
                    return false;
                }
                data.formData = inputs.serializeArray();
            });
        });
		
		// Show new collection form fields when creating new collection is chosen.
		jQuery(document).ready(function(){
			if (jQuery('#simplemedia-collection').val() != -1) {
				jQuery('#simplemedia-collection-details').hide();
			}
			jQuery('#simplemedia-collection').change(function(){
				if (jQuery('#simplemedia-collection').val() == -1) {
					jQuery('#simplemedia-collection-details').show("slow");
				} else {
					jQuery('#simplemedia-collection-details').hide("slow");
				}
			});
		}); 		
    </script>
    <!-- The XDomainRequest Transport is included for cross-domain file deletion for IE 8 and IE 9 -->
    <!--[if (gte IE 8)&(lt IE 10)]>
    <script src="modules/SimpleMedia/lib/vendor/jQuery-File-Upload-9.5.6/js/cors/jquery.xdr-transport.js"></script>
    <![endif]-->
</div>
{include file='user/footer.tpl'}
