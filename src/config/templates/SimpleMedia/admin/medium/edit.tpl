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
            {formlabel for='title' __text='Title' mandatorysym='1'}
            {formtextinput group='medium' id='title' mandatory=true readOnly=false __title='Enter the title of the medium' textMode='singleline' maxLength=255 cssClass='required' }
            {simplemediaValidationError id='title' class='required'}
        </div>
        
        <div class="z-formrow">
            {assign var='mandatorySym' value='1'}
            {if $mode ne 'create'}
                {assign var='mandatorySym' value='0'}
            {/if}
            {formlabel for='theFile' __text='The file' mandatorysym=$mandatorySym}<br />{* break required for Google Chrome *}
            {if $mode eq 'create'}
                {formuploadinput group='medium' id='theFile' mandatory=true readOnly=false cssClass='required validate-upload' }
            {else}
                {formuploadinput group='medium' id='theFile' mandatory=false readOnly=false cssClass=' validate-upload' }
                <p class="z-formnote"><a id="resetTheFileVal" href="javascript:void(0);" class="z-hide">{gt text='Reset to empty value'}</a></p>
            {/if}
            
                <div class="z-formnote">{gt text='Allowed file extensions:'} <span id="fileextensionstheFile">{$modvars.SimpleMedia.allowedExtensions}</span></div>
            {if $mode ne 'create'}
                {if $medium.theFile ne ''}
                    <div class="z-formnote">
                        {gt text='Current file'}:
                        <a href="{$medium.theFileFullPathUrl}" title="{$medium.title|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[medium]"{/if}>
                        {if $medium.theFileMeta.isImage}
                            <img src="{$medium.theFileFullPath|simplemediaImageThumb:80:50}" width="80" height="50" alt="{$medium.title|replace:"\"":""}" />
                        {else}
                            {gt text='Download'} ({$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false})
                        {/if}
                        </a>
                    </div>
                {/if}
            {/if}
            {simplemediaValidationError id='theFile' class='required'}
            {simplemediaValidationError id='theFile' class='validate-upload'}
        </div>
        
        <div class="z-formrow">
            {formlabel for='description' __text='Description'}
            {formtextinput group='medium' id='description' mandatory=false __title='Enter the description of the medium' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {formlabel for='mediaType' __text='Media type' mandatorysym='1'}
            {formdropdownlist group='medium' id='mediaType' mandatory=true __title='Choose the media type' selectionMode='single'}
        </div>
                
    </fieldset>

    <div class="z-panels" id="SimpleMedia_panel">
        
        {include file='admin/include_attributes_edit.tpl' obj=$medium panel=true}
        {include file='admin/include_categories_edit.tpl' obj=$medium groupName='mediumObj' panel=true}
        {include file='admin/include_metadata_edit.tpl' obj=$medium panel=true}
        {if $mode ne 'create'}
            {include file='admin/include_standardfields_edit.tpl' obj=$medium panel=true}
        {/if}
        
        {* include display hooks *}
        {if $mode eq 'create'}
            {notifydisplayhooks eventname='simplemedia.ui_hooks.media.form_edit' id=null assign='hooks'}
        {else}
            {notifydisplayhooks eventname='simplemedia.ui_hooks.media.form_edit' id=$medium.id assign='hooks'}
        {/if}
        {if is_array($hooks) && count($hooks)}
            {foreach key='providerArea' item='hook' from=$hooks}
                <h3 class="hook z-panel-header z-panel-indicator z-pointer">{$providerArea}</h3>
                <fieldset class="hook z-panel-content" style="display: none">{$hook}</div>
                    {$hook}
                </fieldset>
            {/foreach}
        {/if}
        
        {* include return control *}
        {if $mode eq 'create'}
            <fieldset>
                <legend>{gt text='Return control'}</legend>
                <div class="z-formrow">
                    {formlabel for='repeatcreation' __text='Create another item after save'}
                    {formcheckbox group='medium' id='repeatcreation' readOnly=false}
                </div>
            </fieldset>
        {/if}
        
        {* include possible submit actions *}
        <div class="z-buttons z-formbuttons">
            {if $mode eq 'edit'}
                {formbutton id='btnUpdate' commandName='update' __text='Update medium' class='z-bt-save'}
              {if !$inlineUsage}
                {gt text='Really delete this medium?' assign='deleteConfirmMsg'}
                {formbutton id='btnDelete' commandName='delete' __text='Delete medium' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
              {/if}
            {elseif $mode eq 'create'}
                {formbutton id='btnCreate' commandName='create' __text='Create medium' class='z-bt-ok'}
            {else}
                {formbutton id='btnUpdate' commandName='update' __text='OK' class='z-bt-ok'}
            {/if}
            {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
        </div>
        
    </div>
    {/simplemediaFormFrame}
{/form}

</div>
{include file='admin/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='deleteImageArray'}


<script type="text/javascript">
/* <![CDATA[ */
    var editImage = '<img src="{{$editImageArray.src}}" width="16" height="16" alt="" />';
    var removeImage = '<img src="{{$deleteImageArray.src}}" width="16" height="16" alt="" />';

    document.observe('dom:loaded', function() {

        simmedAddCommonValidationRules('medium', '{{if $mode eq 'create'}}{{else}}{{$medium.id}}{{/if}}');

        // observe button events instead of form submit
        var valid = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = valid.validate();
        {{/if}}

        {{if $mode eq 'create'}}$('btnCreate'){{else}}$('btnUpdate'){{/if}}.observe('click', function (event) {
            var result = valid.validate();
            if (!result) {
                // validation error, abort form submit
                Event.stop(event);
            } else {
                // hide form buttons to prevent double submits by accident
                $$('div.z-formbuttons input').each(function (btn) {
                    btn.addClassName('z-hide');
                });
            }
            return result;
        });

        var panel = new Zikula.UI.Panels('SimpleMedia_panel', {
            headerSelector: 'h3',
            headerClassName: 'z-panel-header z-panel-indicator',
            contentClassName: 'z-panel-content',
            active: 'z-panel-header-fields'
        });

        Zikula.UI.Tooltips($$('.simplemediaFormTooltips'));
        simmedInitUploadField('theFile');
    });

/* ]]> */
</script>
