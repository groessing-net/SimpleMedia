{* purpose of this template: build the Form to edit an instance of collection *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/SimpleMedia/javascript/SimpleMedia_editFunctions.js'}
{pageaddvar name='javascript' value='modules/SimpleMedia/javascript/SimpleMedia_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit collection' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create collection' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit collection' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="simplemedia-collection simplemedia-edit">
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type=$adminPageIcon size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>
{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {simplemediaFormFrame}

    {formsetinitialfocus inputId='title'}


    {formvolatile}
        {assign var='useOnlyCurrentLocale' value=true}
        {if $modvars.ZConfig.multilingual}
            {if $supportedLocales ne '' && is_array($supportedLocales) && count($supportedLocales) > 1}
                {assign var='useOnlyCurrentLocale' value=false}
                {nocache}
                {lang assign='currentLanguage'}
                {foreach item='locale' from=$supportedLocales}
                    {if $locale eq $currentLanguage}
                        <fieldset>
                            <legend>{$locale|getlanguagename|safehtml}</legend>
                            
                            <div class="z-formrow">
                                {formlabel for='title' __text='Title' mandatorysym='1'}
                                {formtextinput group='collection' id='title' mandatory=true readOnly=false __title='Enter the title of the collection' textMode='singleline' maxLength=255 cssClass='required' }
                                {simplemediaValidationError id='title' class='required'}
                            </div>
                            
                            <div class="z-formrow">
                                {formlabel for='description' __text='Description'}
                                {formtextinput group='collection' id='description' mandatory=false __title='Enter the description of the collection' textMode='multiline' rows='6' cols='50' cssClass='' }
                            </div>
                        </fieldset>
                    {/if}
                {/foreach}
                {foreach item='locale' from=$supportedLocales}
                    {if $locale ne $currentLanguage}
                        <fieldset>
                            <legend>{$locale|getlanguagename|safehtml}</legend>
                            
                            <div class="z-formrow">
                                {formlabel for="title`$locale`" __text='Title' mandatorysym='1'}
                                {formtextinput group="collection`$locale`" id="title`$locale`" mandatory=true readOnly=false __title='Enter the title of the collection' textMode='singleline' maxLength=255 cssClass='required' }
                                {simplemediaValidationError id="title`$locale`" class='required'}
                            </div>
                            
                            <div class="z-formrow">
                                {formlabel for="description`$locale`" __text='Description'}
                                {formtextinput group="collection`$locale`" id="description`$locale`" mandatory=false __title='Enter the description of the collection' textMode='multiline' rows='6' cols='50' cssClass='' }
                            </div>
                        </fieldset>
                    {/if}
                {/foreach}
                {/nocache}
            {/if}
        {/if}
        {if $useOnlyCurrentLocale eq true}
            {lang assign='locale'}
            <fieldset>
                <legend>{$locale|getlanguagename|safehtml}</legend>
                
                <div class="z-formrow">
                    {formlabel for='title' __text='Title' mandatorysym='1'}
                    {formtextinput group='collection' id='title' mandatory=true readOnly=false __title='Enter the title of the collection' textMode='singleline' maxLength=255 cssClass='required' }
                    {simplemediaValidationError id='title' class='required'}
                </div>
                
                <div class="z-formrow">
                    {formlabel for='description' __text='Description'}
                    {formtextinput group='collection' id='description' mandatory=false __title='Enter the description of the collection' textMode='multiline' rows='6' cols='50' cssClass='' }
                </div>
            </fieldset>
        {/if}
    {/formvolatile}
    <fieldset>
        <legend>{gt text='Further properties'}</legend>
        
        <div class="z-formrow">
            {gt text='The representing thumbnail image. Does not have to be within the collection itself.' assign='toolTip'}
            {formlabel for='previewImage' __text='Preview image' class='simplemediaFormTooltips' title=$toolTip}
            {formintinput group='collection' id='previewImage' mandatory=false __title='Enter the preview image of the collection' maxLength=11 cssClass=' validate-digits' }
            {simplemediaValidationError id='previewImage' class='validate-digits'}
        </div>
        
        <div class="z-formrow">
            {gt text='Used for sorting collections within a parent collection.' assign='toolTip'}
            {formlabel for='sortValue' __text='Sort value' class='simplemediaFormTooltips' title=$toolTip}
            {formintinput group='collection' id='sortValue' mandatory=false __title='Enter the sort value of the collection' maxLength=11 cssClass=' validate-digits' }
            {simplemediaValidationError id='sortValue' class='validate-digits'}
        </div>
    </fieldset>
    
    {include file='admin/include_categories_edit.tpl' obj=$collection groupName='collectionObj'}
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$collection}
    {/if}
    
    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.collections.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.collections.form_edit' id=$collection.id assign='hooks'}
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
                {formlabel for='repeatcreation' __text='Create another item after save'}
                {formcheckbox group='collection' id='repeatcreation' readOnly=false}
            </div>
        </fieldset>
    {/if}
    
    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
        {if $mode eq 'edit'}
            {formbutton id='btnUpdate' commandName='update' __text='Update collection' class='z-bt-save'}
          {if !$inlineUsage}
            {gt text='Really delete this collection?' assign='deleteConfirmMsg'}
            {formbutton id='btnDelete' commandName='delete' __text='Delete collection' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
          {/if}
        {elseif $mode eq 'create'}
            {formbutton id='btnCreate' commandName='create' __text='Create collection' class='z-bt-ok'}
        {else}
            {formbutton id='btnUpdate' commandName='update' __text='OK' class='z-bt-ok'}
        {/if}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
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
    var relationHandler = new Array();

    document.observe('dom:loaded', function() {

        simmedAddCommonValidationRules('collection', '{{if $mode eq 'create'}}{{else}}{{$collection.id}}{{/if}}');

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

        Zikula.UI.Tooltips($$('.simplemediaFormTooltips'));
    });

/* ]]> */
</script>
