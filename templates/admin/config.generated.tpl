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
                    {formlabel for='pageSize' __text='Page size' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='pageSize' group='config' maxLength=255 __title='Enter the page size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Number of media on a page (frontend)' assign='toolTip'}
                    {formlabel for='mediaPageSize' __text='Media page size' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='mediaPageSize' group='config' maxLength=255 __title='Enter the media page size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Number of collections on a page (frontend)' assign='toolTip'}
                    {formlabel for='collectionsPageSize' __text='Collections page size' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='collectionsPageSize' group='config' maxLength=255 __title='Enter the collections page size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Use this Imagine system plugin preset for medium thumbnails in the frontend.' assign='toolTip'}
                    {formlabel for='mediumImaginePreset' __text='Medium imagine preset' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='mediumImaginePreset' group='config' maxLength=255 __title='Enter the medium imagine preset.'}
                </div>
                <div class="z-formrow">
                    {gt text='Use this Imagine system plugin preset for collection thumbnails in the frontend.' assign='toolTip'}
                    {formlabel for='collectionImaginePreset' __text='Collection imagine preset' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='collectionImaginePreset' group='config' maxLength=255 __title='Enter the collection imagine preset.'}
                </div>
                <div class="z-formrow">
                    {gt text='Enable shrinking to maximum image dimensions, original image not stored' assign='toolTip'}
                    {formlabel for='enableShrinking' __text='Enable shrinking' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formcheckbox id='enableShrinking' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='Maximum image dimensions after shrink (w x h)' assign='toolTip'}
                    {formlabel for='shrinkDimensions' __text='Shrink dimensions' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='shrinkDimensions' group='config' maxLength=255 __title='Enter the shrink dimensions.'}
                </div>
                <div class="z-formrow">
                    {gt text='Use cropper for the thumbnail image' assign='toolTip'}
                    {formlabel for='useThumbCropper' __text='Use thumb cropper' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formcheckbox id='useThumbCropper' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='Cropping size mode' assign='toolTip'}
                    {formlabel for='cropSizeMode' __text='Crop size mode' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='cropSizeMode' group='config' maxLength=255 __title='Enter the crop size mode. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Allowed file extensions for file upload' assign='toolTip'}
                    {formlabel for='allowedExtensions' __text='Allowed extensions' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formtextinput id='allowedExtensions' group='config' maxLength=255 __title='Enter the allowed extensions.'}
                </div>
                <div class="z-formrow">
                    {gt text='Maximum File Size during upload in kB. Default after install is 5 MB.' assign='toolTip'}
                    {formlabel for='maxUploadFileSize' __text='Max upload file size' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='maxUploadFileSize' group='config' maxLength=255 __title='Enter the max upload file size. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Minimum pixel width of an image to upload, to be able to generate thumbnails.' assign='toolTip'}
                    {formlabel for='minWidthForUpload' __text='Min width for upload' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='minWidthForUpload' group='config' maxLength=255 __title='Enter the min width for upload. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='The default Collection that is used for new Media.' assign='toolTip'}
                    {formlabel for='defaultCollection' __text='Default collection' cssClass='simplemedia-form-tooltips ' title=$toolTip}
                        {formintinput id='defaultCollection' group='config' maxLength=255 __title='Enter the default collection. Only digits are allowed.'}
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
    });
/* ]]> */
</script>
