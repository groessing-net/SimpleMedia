{* purpose of this template: reusable editing of entity attributes *}
{if isset($panel) && $panel eq true}
    <h3 class="categories z-panel-header z-panel-indicator z-pointer">{gt text='Categories'}</h3>
    <fieldset class="categories z-panel-content" style="display: none">
{else}
    <fieldset class="categories">
{/if}
    <legend>{gt text='Categories'}</legend>
    {formvolatile}
    {foreach key='registryId' item='registryCid' from=$registries}
        <div class="z-formrow">
            {formlabel for="category_`$registryId`" __text='Category'}
            {formcategoryselector id="category_`$registryId`" category=$registryCid
                                  dataField='categories' group=$groupName registryId=$registryId doctrine2=true}
        </div>
    {/foreach}
    {/formvolatile}
</fieldset>
