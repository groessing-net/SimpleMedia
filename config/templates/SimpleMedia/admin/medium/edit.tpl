{* purpose of this template: build the Form to edit an instance of medium *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/SimpleMedia/javascript/SimpleMedia_editFunctions.js'}
{pageaddvar name='javascript' value='modules/SimpleMedia/javascript/SimpleMedia_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit medium' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create medium' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit medium' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="simplemedia-medium simplemedia-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {simplemediaFormFrame}
    {formsetinitialfocus inputId='title'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {gt text='Medium title' assign='toolTip'}
            {formlabel for='title' __text='Title' mandatorysym='1' cssClass='simplemedia-form-tooltips' title=$toolTip}
            {formtextinput group='medium' id='title' mandatory=true readOnly=false __title='Enter the title of the medium' textMode='singleline' maxLength=255 cssClass='required' }
            {simplemediaValidationError id='title' class='required'}
        </div>
        
        <div class="z-formrow">
            {gt text='The attached file to this medium' assign='toolTip'}
            {assign var='mandatorySym' value='1'}
            {if $mode ne 'create'}
                {assign var='mandatorySym' value='0'}
            {/if}
            {formlabel for='theFile' __text='The file' mandatorysym=$mandatorySym cssClass='simplemedia-form-tooltips' title=$toolTip}<br />{* break required for Google Chrome *}
            {if $mode eq 'create'}
                {formuploadinput group='medium' id='theFile' mandatory=true readOnly=false cssClass='required validate-upload' }
            {else}
                {formuploadinput group='medium' id='theFile' mandatory=false readOnly=false cssClass=' validate-upload' }
                <span class="z-formnote"><a id="resetTheFileVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></span>
            {/if}
            
            <span class="z-formnote">{gt text='Allowed file extensions:'} <span id="theFileFileExtensions">{$modvars.SimpleMedia.allowedExtensions}</span></span>
            <span class="z-formnote">{gt text='Allowed file size:'} {$modvars.SimpleMedia.maxUploadFileSize*1024|simplemediaGetFileSize:'':false:false}</span>
            {if $mode ne 'create'}
                {if $medium.theFile ne ''}
                    <span class="z-formnote">
                        {gt text='Current file'}:
                        <a href="{$medium.theFileFullPathUrl}" title="{$mediumObj->getTitleFromDisplayPattern()|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[medium]"{/if}>
                        {if $medium.theFileMeta.isImage}
                            {thumb image=$medium.theFileFullPath objectid="medium-`$medium.id`" preset=$mediumThumbPresetTheFile tag=true img_alt=$mediumObj->getTitleFromDisplayPattern()}
                        {else}
                            {gt text='Download'} ({$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false})
                        {/if}
                        </a>
                    </span>
                {/if}
            {/if}
            {simplemediaValidationError id='theFile' class='required'}
            {simplemediaValidationError id='theFile' class='validate-upload'}
        </div>
        
        <div class="z-formrow">
            {gt text='Extensive description of this medium item' assign='toolTip'}
            {formlabel for='description' __text='Description' cssClass='simplemedia-form-tooltips' title=$toolTip}
            {formtextinput group='medium' id='description' mandatory=false __title='Enter the description of the medium' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        {* Not displayed, only for Geo location
        <div class="z-formrow">
            {gt text='Zip code for the geographical location of this medium' assign='toolTip'}
            {formlabel for='zipcode' __text='Zipcode' cssClass='simplemedia-form-tooltips' title=$toolTip}
            {formtextinput group='medium' id='zipcode' mandatory=false readOnly=false __title='Enter the zipcode of the medium' textMode='singleline' maxLength=15 cssClass='' }
        </div>
        *}
        
        <div class="z-formrow">
            {gt text='Contains an optional thumbnail image for the medium item.' assign='toolTip'}
            {formlabel for='previewImage' __text='Preview image' cssClass='simplemedia-form-tooltips' title=$toolTip}
            {formintinput group='medium' id='previewImage' mandatory=false __title='Enter the preview image of the medium' maxLength=11 cssClass='validate-digits' }
            {simplemediaValidationError id='previewImage' class='validate-digits'}
        </div>

        {* Should be used with a sorting script, not directly
        <div class="z-formrow">
            {gt text='Used for sorting media within a collection.' assign='toolTip'}
            {formlabel for='sortValue' __text='Sort value' cssClass='simplemedia-form-tooltips' title=$toolTip}
            {formintinput group='medium' id='sortValue' mandatory=false __title='Enter the sort value of the medium' maxLength=11 cssClass=' validate-digits' }
            {simplemediaValidationError id='sortValue' class='validate-digits'}
        </div>
        *}
        
        <div class="z-formrow">
            {formlabel for='mediaType' __text='Media type' cssClass=''}
            {formdropdownlist group='medium' id='mediaType' mandatory=false __title='Choose the media type' selectionMode='single'}
        </div>

        {if $mode ne 'create'}
            <div class="z-formrow">
                {gt text='The number of views for this medium' assign='toolTip'}
                {formlabel for='viewsCount' __text='Views count' cssClass='simplemedia-form-tooltips' title=$toolTip}
                {formintinput group='medium' id='viewsCount' mandatory=false __title='Enter the views count of the medium' maxLength=11 cssClass='validate-digits' }
                {simplemediaValidationError id='viewsCount' class='validate-digits'}
            </div>
        {/if}
    </fieldset>

    {include file='admin/collection/include_selectEditOne.tpl' group='medium' alias='collection' aliasReverse='media' mandatory=true idPrefix='simmedMedium_Collection' linkingItem=$medium displayMode='dropdown' allowEditing=true}
    {include file='admin/include_categories_edit.tpl' obj=$medium groupName='mediumObj'}

    <fieldset class="simplemedia-map">
        <legend>{gt text='Location & Map'}</legend>
        <div class="z-formrow">
            {formlabel for='latitude' __text='Latitude (decimal degrees)'}
            {simplemediaGeoInput group='medium' id='latitude' mandatory=false __title='Enter the latitude of the medium' cssClass='validate-number'}
            {simplemediaValidationError id='latitude' class='validate-number'}
        </div>
        <div class="z-formrow">
            {formlabel for='longitude' __text='Longitude (decimal degrees)'}
            {simplemediaGeoInput group='medium' id='longitude' mandatory=false __title='Enter the longitude of the medium' cssClass='validate-number'}
            {simplemediaValidationError id='longitude' class='validate-number'}
        </div>
        <div id="mapContainer" class="simplemedia-mapcontainer">
        </div>
    </fieldset>
    
    {include file='admin/include_attributes_edit.tpl' obj=$medium}
    {include file='admin/include_metadata_edit.tpl' obj=$medium}
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$medium}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$medium.id}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.media.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.media.form_edit' id=null assign='hooks'}
    {/if}
    {if is_array($hooks) && count($hooks)}
        {foreach key='providerArea' item='hook' from=$hooks}
            <fieldset>
                {$hook}
            </fieldset>
        {/foreach}
    {/if}
    
    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatCreation' __text='Create another item after save'}
                    {formcheckbox group='medium' id='repeatCreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {foreach item='action' from=$actions}
        {assign var='actionIdCapital' value=$action.id|@ucwords}
        {gt text=$action.title assign='actionTitle'}
        {*gt text=$action.description assign='actionDescription'*}{* TODO: formbutton could support title attributes *}
        {if $action.id eq 'delete'}
            {gt text='Really delete this medium?' assign='deleteConfirmMsg'}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass confirmMessage=$deleteConfirmMsg}
        {else}
            {formbutton id="btn`$actionIdCapital`" commandName=$action.id text=$actionTitle class=$action.buttonClass}
        {/if}
    {/foreach}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
    {/simplemediaFormFrame}
{/form}
</div>
{include file='admin/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='removeImageArray'}

{pageaddvarblock name='header'}
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
    <script type="text/javascript" src="{$baseurl}plugins/Mapstraction/lib/vendor/mxn/mxn.js?(googlev3)"></script>
    <script type="text/javascript">
    /* <![CDATA[ */

        var mapstraction;
        var marker;

        function newCoordinatesEventHandler() {
            var location = new mxn.LatLonPoint($F('latitude'), $F('longitude'));
            marker.hide();
            mapstraction.removeMarker(marker);
            marker = new mxn.Marker(location);
            mapstraction.addMarker(marker,true);
            mapstraction.setCenterAndZoom(location, 18);
        }

        Event.observe(window, 'load', function() {
            mapstraction = new mxn.Mapstraction('mapContainer', 'googlev3');
            mapstraction.addControls({
                pan: true,
                zoom: 'small',
                map_type: true
            });

            var latlon = new mxn.LatLonPoint({{$medium.latitude|simplemediaFormatGeoData}}, {{$medium.longitude|simplemediaFormatGeoData}});

            mapstraction.setMapType(mxn.Mapstraction.SATELLITE);
            mapstraction.setCenterAndZoom(latlon, 16);
            mapstraction.mousePosition('position');

            // add a marker
            marker = new mxn.Marker(latlon);
            mapstraction.addMarker(marker, true);

            $('latitude').observe('change', function() {
                newCoordinatesEventHandler();
            });

            $('longitude').observe('change', function() {
                newCoordinatesEventHandler();
            });

            mapstraction.click.addHandler(function(event_name, event_source, event_args){
                var coords = event_args.location;
                Form.Element.setValue('latitude', coords.lat.toFixed(7));
                Form.Element.setValue('longitude', coords.lng.toFixed(7));
                newCoordinatesEventHandler();
            });

            {{if $mode eq 'create'}}
                // derive default coordinates from users position with html5 geolocation feature
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(setDefaultCoordinates, handlePositionError);
                }
            {{/if}}

            function setDefaultCoordinates(position) {
                $('latitude').value = position.coords.latitude.toFixed(7);
                $('longitude').value = position.coords.longitude.toFixed(7);
                newCoordinatesEventHandler();
            }

            function handlePositionError(evt) {
                Zikula.UI.Alert(evt.message, Zikula.__('Error during geolocation', 'module_simplemedia'));
            }
            {{*
                Initialise geocoding functionality.
                In contrast to the map picker this one determines coordinates for a given address.
                To use this please customise the form field names inside the function to your needs.
                You can find it in src/modules/SimpleMedia/javascript/SimpleMedia_editFunctions.js
                Furthermore you will need a link or a button with id="linkGetCoordinates" which will
                be used by the script for adding a corresponding click event handler.
                simmedInitGeoCoding();
            *}}
        });
    /* ]]> */
    </script>
{/pageaddvarblock}

<script type="text/javascript">
/* <![CDATA[ */

    var formButtons, formValidator;

    function handleFormButton (event) {
        var result = formValidator.validate();
        if (!result) {
            // validation error, abort form submit
            Event.stop(event);
        } else {
            // hide form buttons to prevent double submits by accident
            formButtons.each(function (btn) {
                btn.addClassName('z-hide');
            });
        }

        return result;
    }

    document.observe('dom:loaded', function() {

        simmedAddCommonValidationRules('medium', '{{if $mode ne 'create'}}{{$medium.id}}{{/if}}');
        {{* observe validation on button events instead of form submit to exclude the cancel command *}}
        formValidator = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = formValidator.validate();
        {{/if}}

        formButtons = $('{{$__formid}}').select('div.z-formbuttons input');

        formButtons.each(function (elem) {
            if (elem.id != 'btnCancel') {
                elem.observe('click', handleFormButton);
            }
        });

        Zikula.UI.Tooltips($$('.simplemedia-form-tooltips'));
        simmedInitUploadField('theFile');
    });

/* ]]> */
</script>
