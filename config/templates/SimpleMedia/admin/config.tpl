{* purpose of this template: module configuration *}
{include file='admin/header.tpl'}
<div class="simplemedia-config">
    {gt text='Settings' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='config' size='small' __alt='Settings'}
        <h3>{$templateTitle}</h3>
    </div>

    {form cssClass='z-form'}
        {* add validation summary and a <div> element for styling the form *}
        {simplemediaFormFrame}
            {formsetinitialfocus inputId='pageSize'}
            {gt text='Media settings' assign='tabTitle'}
            <fieldset>
                <legend>{$tabTitle}</legend>
            
                <p class="z-confirmationmsg">{gt text='Manage all configuration settings for SimpleMedia'|nl2br}</p>
            
                <div class="z-formrow">
                    {gt text='Number of items on a page (backend)' assign='toolTip'}
                    {formlabel for='pageSize' __text='Page size backend' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='pageSize' group='config' maxLength=255 __title='Enter the page size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Number of media on a page (frontend)' assign='toolTip'}
                    {formlabel for='mediaPageSize' __text='Media page size frontend' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='mediaPageSize' group='config' maxLength=255 __title='Enter the media page size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Number of collections on a page (frontend)' assign='toolTip'}
                    {formlabel for='collectionsPageSize' __text='Collections page size frontend' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='collectionsPageSize' group='config' maxLength=255 __title='Enter the collections page size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Use this Imagine system plugin preset for medium thumbnails in the frontend.' assign='toolTip'}
                    {formlabel for='mediumImaginePreset' __text='Imagine preset for media thumbnails' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='mediumImaginePreset' group='config' maxLength=255 __title='Enter the medium imagine preset.'}
					<em class="z-sub z-formnote">
						{modurl modname='Extensions' type='adminplugin' func='dispatch' _plugin='Imagine' _action='configure' assign='imaginePluginEdit'}
						{gt text='Within SimpleMedia the Imagine system plugin is used for thumbnail generation and display in the frontend. Imagine uses presets to determine the thumbnail size and way of scaling. Choose a preset name here, the presets can be configured <a href="%s">here</a>.' tag1=$imaginePluginEdit}
					</em>
                </div>
                <div class="z-formrow">
                    {gt text='Use this Imagine system plugin preset for fullsize image medium thumbnails in the frontend.' assign='toolTip'}
                    {formlabel for='mediumFullImaginePreset' __text='Imagine preset for fullimage medium thumbnails' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='mediumFullImaginePreset' group='config' maxLength=255 __title='Enter the medium fullsize image imagine preset.'}
					<em class="z-sub z-formnote">
						{gt text='The Imagine preset simplemedia_medium_full can be used here if prefered.'}
					</em>
                </div>
                <div class="z-formrow">
                    {gt text='Use this Imagine system plugin preset for collection thumbnails in the frontend.' assign='toolTip'}
                    {formlabel for='collectionImaginePreset' __text='Imagine preset for collection thumbnails' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='collectionImaginePreset' group='config' maxLength=255 __title='Enter the collection imagine preset.'}
                </div>
                <div class="z-formrow">
                    {gt text='Enable shrinking to maximum image dimensions, original image not stored' assign='toolTip'}
                    {formlabel for='enableShrinking' __text='Enable shrink to maximum image dimensions' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formcheckbox id='enableShrinking' group='config'}
                </div>
                <div class="z-formrow" id="shrinkDimensionsRow">
                    {* gt text='Maximum image dimensions after shrink (w x h)' assign='toolTip'}
                    {formlabel for='shrinkDimensions' __text='Shrink dimensions' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='shrinkDimensions' group='config' maxLength=255 __title='Enter the shrink dimensions.' *}
                    {gt text='Maximum image dimensions after shrink (w x h)' assign='toolTip'}
                    {formlabel for='shrinkWidth' __text='Maximum image dimensions after shrink (w x h)' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                    <div>
                        {formintinput group='maxSize' id='shrinkWidth' size='8' maxLength='4' text=$modvars.SimpleMedia.shrinkDimensions.width} x
                        {formintinput group='maxSize' id='shrinkHeight' size='8' maxLength='4' text=$modvars.SimpleMedia.shrinkDimensions.height} {gt text='pixels'}
                    </div>
                </div>
                <div class="z-formrow">
                    {gt text='Use cropper for the thumbnail image' assign='toolTip'}
                    {formlabel for='useThumbCropper' __text='Use thumbnail cropper' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formcheckbox id='useThumbCropper' group='config'}
                </div>
                <div class="z-formrow" id="cropSizeModeRow">
                    {* gt text='Cropping size mode' assign='toolTip'}
                    {formlabel for='cropSizeMode' __text='Crop size mode' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='cropSizeMode' group='config' maxLength=255 __title='Enter the crop size mode. Only digits are allowed.' *}
                    {gt text='Cropping size mode' assign='toolTip'}
                    {formlabel for='cropSizeMode' __text='Crop size mode' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                    {formdropdownlist id='cropSizeMode' group='cropSize'}
                </div>
                <div class="z-formrow">
                    {gt text='Allowed file extensions for file upload' assign='toolTip'}
                    {formlabel for='allowedExtensions' __text='Allowed file extensions' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='allowedExtensions' group='config' maxLength=255 __title='Enter the allowed extensions.'}
                </div>
                <div class="z-formrow">
                    {gt text='Maximum File Size during upload in kB. Default after install is 5 MB.' assign='toolTip'}
                    {formlabel for='maxUploadFileSize' __text='Maximum upload file size' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='maxUploadFileSize' group='config' maxLength=255 __title='Enter the max upload file size. Only digits are allowed.'} {gt text="kB"}
                </div>
                <div class="z-formrow">
                    {gt text='Minimum pixel width of an image to upload, to be able to generate thumbnails.' assign='toolTip'}
                    {formlabel for='minWidthForUpload' __text='Minimum width for upload' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='minWidthForUpload' group='config' maxLength=255 __title='Enter the min width for upload. Only digits are allowed.'} {gt text='pixels'}
                </div>
                <div class="z-formrow">
                    {gt text='The default Collection that is used for new Media.' assign='toolTip'}
                    {formlabel for='defaultCollection' __text='Default collection' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {* formintinput id='defaultCollection' group='config' maxLength=255 __title='Enter the default collection. Only digits are allowed.' *}
						{formdropdownlist id='defaultCollection' group='defaultCollections'}
                </div>
                <div class="z-formrow">
                    {gt text='The folder location under userdata/SimpleMedia where the uploaded files are stored.' assign='toolTip'}
                    {formlabel for='mediaDir' __text='Media dir' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='mediaDir' group='config' maxLength=255 __title='Enter the media dir.'}
                </div>
                <div class="z-formrow">
                    {gt text='Media thumbnail folder name' assign='toolTip'}
                    {formlabel for='mediaThumbDir' __text='Media thumb dir' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='mediaThumbDir' group='config' maxLength=255 __title='Enter the media thumb dir.'}
                </div>
                <div class="z-formrow">
                    {gt text='Media thumbnail suffix' assign='toolTip'}
                    {formlabel for='mediaThumbExt' __text='Media thumb ext' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='mediaThumbExt' group='config' maxLength=255 __title='Enter the media thumb ext.'}
                </div>
                <div class="z-formrow">
                    {gt text='Count the number of medium views ' assign='toolTip'}
                    {formlabel for='countMediumViews' __text='Count medium views' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formcheckbox id='countMediumViews' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='Count the number of collection views' assign='toolTip'}
                    {formlabel for='countCollectionViews' __text='Count collection views' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formcheckbox id='countCollectionViews' group='config'}
                </div>
            </fieldset>

            <div class="z-buttons z-formbuttons">
                {formbutton commandName='save' __text='Update configuration' class='z-bt-save'}
                {formbutton commandName='cancel' __text='Cancel' class='z-bt-cancel'}
            </div>
        {/simplemediaFormFrame}
    {/form}
</div>
{include file='admin/footer.tpl'}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        Zikula.UI.Tooltips($$('.simplemedia-form-tooltips'));
        $('enableShrinking').observe('click', simmedCheckShrinkEntry)
                            .observe('keyup', simmedCheckShrinkEntry);
        $('useThumbCropper').observe('click', simmedCheckCropSizeEntry)
                            .observe('keyup', simmedCheckCropSizeEntry);
        simmedCheckShrinkEntry();
        simmedCheckCropSizeEntry();
    });
    function simmedCheckShrinkEntry()
    {
        if ($('enableShrinking').checked == true) {
            $('shrinkDimensionsRow').show();
        } else {
            $('shrinkDimensionsRow').hide();
        }
    }
    function simmedCheckCropSizeEntry()
    {
        if ($('useThumbCropper').checked == true) {
            $('cropSizeModeRow').show();
        } else {
            $('cropSizeModeRow').hide();
        }
    }
/* ]]> */
</script>
