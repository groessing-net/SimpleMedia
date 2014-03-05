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

    <fieldset>
        <legend>{gt text='Content'}</legend>
        
        <div class="z-formrow">
            {gt text='Collection title' assign='toolTip'}
            {formlabel for='title' __text='Title' mandatorysym='1' cssClass='simplemedia-form-tooltips' title=$toolTip}
            {formtextinput group='collection' id='title' mandatory=true readOnly=false __title='Enter the title of the collection' textMode='singleline' maxLength=255 cssClass='required' }
            {simplemediaValidationError id='title' class='required'}
        </div>
        
        <div class="z-formrow">
            {gt text='Extensive description of the collection' assign='toolTip'}
            {formlabel for='description' __text='Description' cssClass='simplemedia-form-tooltips' title=$toolTip}
            {formtextinput group='collection' id='description' mandatory=false __title='Enter the description of the collection' textMode='multiline' rows='6' cols='50' cssClass='' }
        </div>
        
        <div class="z-formrow">
            {gt text='The representing thumbnail image. Does not have to be within the collection itself.' assign='toolTip'}
            {formlabel for='previewImage' __text='Preview image' cssClass='simplemedia-form-tooltips' title=$toolTip}
            {formintinput group='collection' id='previewImage' mandatory=false __title='Enter the preview image of the collection' maxLength=11 cssClass=' validate-digits' }
            {simplemediaValidationError id='previewImage' class='validate-digits'}
        </div>
        
        <div class="z-formrow">
            {gt text='The number of views for this collection' assign='toolTip'}
            {formlabel for='viewsCount' __text='Views count' cssClass='simplemedia-form-tooltips' title=$toolTip}
            {formintinput group='collection' id='viewsCount' mandatory=false __title='Enter the views count of the collection' maxLength=11 cssClass=' validate-digits' }
            {simplemediaValidationError id='viewsCount' class='validate-digits'}
        </div>
        
        <div class="z-formrow">
            {gt text='Used for sorting collections within a parent collection.' assign='toolTip'}
            {formlabel for='sortValue' __text='Sort value' cssClass='simplemedia-form-tooltips' title=$toolTip}
            {formintinput group='collection' id='sortValue' mandatory=false __title='Enter the sort value of the collection' maxLength=11 cssClass=' validate-digits' }
            {simplemediaValidationError id='sortValue' class='validate-digits'}
        </div>
    </fieldset>
    
    {include file='admin/include_categories_edit.tpl' obj=$collection groupName='collectionObj'}
    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$collection}
    {/if}
    
    {* include display hooks *}
    {if $mode ne 'create'}
        {assign var='hookId' value=$collection.id}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.collections.form_edit' id=$hookId assign='hooks'}
    {else}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.collections.form_edit' id=null assign='hooks'}
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
                    {formcheckbox group='collection' id='repeatCreation' readOnly=false}
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
            {gt text='Really delete this collection?' assign='deleteConfirmMsg'}
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

        simmedAddCommonValidationRules('collection', '{{if $mode ne 'create'}}{{$collection.id}}{{/if}}');
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
    });

/* ]]> */
</script>
