{* purpose of this template: reusable editing of entity attributes *}
    {if isset($panel) && $panel eq true}
        <h3 class="attributes z-panel-header z-panel-indicator z-pointer">{gt text='Attributes'}</h3>
        <fieldset class="attributes z-panel-content" style="display: none">
    {else}
        <fieldset class="attributes">
    {/if}
    <legend>{gt text='Attributes'}</legend>
    {formvolatile}
    {foreach key='fieldName' item='fieldValue' from=$attributes}
    <div class="z-formrow">
        {formlabel for="attributes`$fieldName`"' text=$fieldName}
        {formtextinput id="attributes`$fieldName`" group='attributes' dataField=$fieldName maxLength=255}
    </div>
    {/foreach}
    {/formvolatile}
</fieldset>
