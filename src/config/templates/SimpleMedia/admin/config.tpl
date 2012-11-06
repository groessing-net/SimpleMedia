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
            <fieldset>
                <legend>{gt text='Here you can manage all basic settings for SimpleMedia'}</legend>
            
                <div class="z-formrow">
                    {gt text='Number of items on a page (backend)' assign='toolTip'}
                    {formlabel for='pageSize' __text='Page size' class='simplemediaFormTooltips' title=$toolTip}
                    {formintinput id='pageSize' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Number of media on a page (frontend)' assign='toolTip'}
                    {formlabel for='mediaPageSize' __text='Media page size' class='simplemediaFormTooltips' title=$toolTip}
                    {formintinput id='mediaPageSize' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Number of collections on a page (frontend)' assign='toolTip'}
                    {formlabel for='collectionsPageSize' __text='Collections page size' class='simplemediaFormTooltips' title=$toolTip}
                    {formintinput id='collectionsPageSize' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Contains an array of thumbnail widthxheight dimensions array ( array ( width => 200, height => 150 ) )' assign='toolTip'}
                    {formlabel for='thumb1width' __text='Thumb dimensions (w x h)' class='simplemediaFormTooltips' title=$toolTip}
                    {* formtextinput id='thumbDimensions' group='config' maxLength=255 __title='Enter this setting.' *}
                    <ol style="margin-left: 320px">
                    {formvolatile}
                    {foreach name='thumbLoop' item='thumbSize' from=$modvars.SimpleMedia.thumbDimensions}
                        <li>
                            {formintinput group='thumbSizes' id="thumb`$smarty.foreach.thumbLoop.iteration`width" size='6' maxLength='4' text=$thumbSize.width style='width: 60px'} x
                            {formintinput group='thumbSizes' id="thumb`$smarty.foreach.thumbLoop.iteration`height" size='6' maxLength='4' text=$thumbSize.height style='width: 60px'} {gt text='pixels'}
                        </li>
                    {/foreach}
                        <li>
                            {formintinput group='thumbSizes' id="thumb`$smarty.foreach.thumbLoop.iteration+1`width" size='6' maxLength='4' text='' style='width: 60px'} x
                            {formintinput group='thumbSizes' id="thumb`$smarty.foreach.thumbLoop.iteration+1`height" size='6' maxLength='4' text='' style='width: 60px'} {gt text='pixels'}
                        </li>
                    {/formvolatile}
                    </ol>
                </div>
                <div class="z-formrow">
                    {gt text='The default thumbnail that is used from the set of Thumbdimensions' assign='toolTip'}
                    {formlabel for='defaultThumbNumber' __text='Default thumb number' class='simplemediaFormTooltips' title=$toolTip}
                    {formintinput id='defaultThumbNumber' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {gt text='Enable shrinking to maximum image dimensions, original image not stored' assign='toolTip'}
                    {formlabel for='enableShrinking' __text='Enable shrinking' class='simplemediaFormTooltips' title=$toolTip}
                    {formcheckbox id='enableShrinking' group='config'}
                </div>
                <div class="z-formrow" id="shrinkDimensionsRow">
                    {* gt text='Maximum image dimensions after shrink (w x h)' assign='toolTip'}
                    {formlabel for='shrinkDimensions' __text='Shrink dimensions' class='simplemediaFormTooltips' title=$toolTip}
                    {formtextinput id='shrinkDimensions' group='config' maxLength=255 __title='Enter this setting.' *}
                    {gt text='Maximum image dimensions after shrink (w x h)' assign='toolTip'}
                    {formlabel for='shrinkWidth' __text='Shrink to max dimensions (w x h)' class='simplemediaFormTooltips' title=$toolTip}
                    <div>
                        {formintinput group='maxSize' id='shrinkWidth' size='8' maxLength='4' text=$modvars.SimpleMedia.shrinkDimensions.width} x
                        {formintinput group='maxSize' id='shrinkHeight' size='8' maxLength='4' text=$modvars.SimpleMedia.shrinkDimensions.height} {gt text='pixels'}
                    </div>
                </div>
                <div class="z-formrow">
                    {gt text='Use cropper for the thumbnail image' assign='toolTip'}
                    {formlabel for='useThumbCropper' __text='Use thumb cropper' class='simplemediaFormTooltips' title=$toolTip}
                    {formcheckbox id='useThumbCropper' group='config'}
                </div>
                <div class="z-formrow" id="cropSizeModeRow">
                    {gt text='Cropping size mode' assign='toolTip'}
                    {formlabel for='cropSizeMode' __text='Crop size mode' class='simplemediaFormTooltips' title=$toolTip}
                    {* formintinput id='cropSizeMode' group='config' maxLength=255 __title='Enter this setting. Only digits are allowed.' *}
                    {formdropdownlist id='cropSizeMode' group='config'}
                </div>
                <div class="z-formrow">
                    {gt text='Allowed file extensions for file upload' assign='toolTip'}
                    {formlabel for='allowedExtensions' __text='Allowed extensions' class='simplemediaFormTooltips' title=$toolTip}
                    {formtextinput id='allowedExtensions' group='config' maxLength=255 __title='Enter this setting.'}
                </div>
                {* hard coded for now <div class="z-formrow">
                    {gt text='The location under userdata/SimpleMedia where the uploaded files are stored.' assign='toolTip'}
                    {formlabel for='mediaDir' __text='Media dir' class='simplemediaFormTooltips' title=$toolTip}
                    {formtextinput id='mediaDir' group='config' maxLength=255 __title='Enter this setting.'}
                </div>
                <div class="z-formrow">
                    {gt text='Media thumbnail folder' assign='toolTip'}
                    {formlabel for='mediaThumbDir' __text='Media thumb dir' class='simplemediaFormTooltips' title=$toolTip}
                    {formtextinput id='mediaThumbDir' group='config' maxLength=255 __title='Enter this setting.'}
                </div>
                <div class="z-formrow">
                    {gt text='Media thumbnail suffix' assign='toolTip'}
                    {formlabel for='mediaThumbExt' __text='Media thumb ext' class='simplemediaFormTooltips' title=$toolTip}
                    {formtextinput id='mediaThumbExt' group='config' maxLength=255 __title='Enter this setting.'}
                </div> *}
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
        $('enableShrinking').observe('click', SiMeCheckShrinkEntry)
                            .observe('keyup', SiMeCheckShrinkEntry);
        $('useThumbCropper').observe('click', SiMeCheckCropSizeEntry)
                            .observe('keyup', SiMeCheckCropSizeEntry);
        SiMeCheckShrinkEntry();
        SiMeCheckCropSizeEntry();
        Zikula.UI.Tooltips($$('.simplemediaFormTooltips'));
    });

    function SiMeCheckShrinkEntry()
    {
        if ($('enableShrinking').checked == true) {
            $('shrinkDimensionsRow').show();
        } else {
            $('shrinkDimensionsRow').hide();
        }
    }

    function SiMeCheckCropSizeEntry()
    {
        if ($('useThumbCropper').checked == true) {
            $('cropSizeModeRow').show();
        } else {
            $('cropSizeModeRow').hide();
        }
    }
/* ]]> */
</script>
