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
                <legend>{gt text='Here you can manage all basic settings for SimpleMedia.'}</legend>
            
                <div class="z-formrow">
                    {formlabel for='pageSize' __text='Number of items on a page'}
                    {formintinput id='pageSize' group='config' maxLength=255 width=20em __title='Input this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='thumb1width' __text='Thumbnail dimensions (w x h)'}
                    {*formtextinput id='thumbDimensions' group='config' maxLength=255 width=20em __title='Input this setting.'*}
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
                {* <div class="z-formrow">
                    {formlabel for='thumbDimensions' __text='Thumb dimensions'}
                    {formtextinput id='thumbDimensions' group='config' maxLength=255 __title='Input this setting.'}
                </div> *}
                <div class="z-formrow">
                    {formlabel for='defaultThumbNumber' __text='Default thumbnail dimension number'}
                    {formintinput id='defaultThumbNumber' group='config' maxLength=255 width=20em __title='Input this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='enableShrinking' __text='Enable shrinking to maximum image dimensions, original image not stored'}
                    {formcheckbox id='enableShrinking' group='config'}
                </div>
                <div class="z-formrow" id="shrinkDimensionsRow">
                    {formlabel for='shrinkWidth' __text='Maximum image dimensions after shrink (w x h)'}
                    <div>
                        {formintinput group='maxSize' id='shrinkWidth' size='8' maxLength='4' text=$modvars.SimpleMedia.shrinkDimensions.width} x
                        {formintinput group='maxSize' id='shrinkHeight' size='8' maxLength='4' text=$modvars.SimpleMedia.shrinkDimensions.height} {gt text='pixels'}
                    </div>
                </div>
                {* <div class="z-formrow">
                    {formlabel for='shrinkDimensions' __text='Shrink dimensions'}
                    {formtextinput id='shrinkDimensions' group='config' maxLength=255 __title='Input this setting.'}
                </div> *}
                <div class="z-formrow">
                    {formlabel for='useThumbCropper' __text='Use cropper for the thumbnail image'}
                    {formcheckbox id='useThumbCropper' group='config'}
                </div>
                <div class="z-formrow" id="cropSizeModeRow">
                    {formlabel for='cropSizeMode' __text='Cropping size mode'}
                    {formdropdownlist id='cropSizeMode' group='config'}
                </div>
                {* <div class="z-formrow">
                    {formlabel for='cropSizeMode' __text='Cropping size mode'}
                    {formintinput id='cropSizeMode' group='config' maxLength=255 __title='Input this setting. Only digits are allowed.'}
                </div> *}
                <div class="z-formrow">
                    {formlabel for='allowedExtensions' __text='Allowed file extensions for upload'}
                    {formtextinput id='allowedExtensions' group='config' maxLength=255 __title='Input this setting.'}
                </div>
                {* Hard coded for now <div class="z-formrow">
                    {formlabel for='mediaDir' __text='Media folder'}
                    {formtextinput id='mediaDir' group='config' maxLength=255 __title='Input this setting.'}
                    <em class="z-sub z-formnote">{gt text='normally located under userdata/SimpleMedia.'}</em>
                </div>
                <div class="z-formrow">
                    {formlabel for='mediaThumbDir' __text='Media thumb dir'}
                    {formtextinput id='mediaThumbDir' group='config' maxLength=255 __title='Input this setting.'}
                </div>
                 <div class="z-formrow">
                    {formlabel for='mediaThumbExt' __text='Media thumb ext'}
                    {formtextinput id='mediaThumbExt' group='config' maxLength=255 __title='Input this setting.'}
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


<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */

    document.observe('dom:loaded', function() {

        $('enableShrinking').observe('click', SiMeCheckShrinkEntry)
                            .observe('keyup', SiMeCheckShrinkEntry);
        $('useThumbCropper').observe('click', SiMeCheckCropSizeEntry)
                            .observe('keyup', SiMeCheckCropSizeEntry);
        SiMeCheckShrinkEntry();
        SiMeCheckCropSizeEntry();
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

