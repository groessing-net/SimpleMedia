{* purpose of this template: inclusion template for managing related collections in admin area *}
    {if isset($panel) && $panel eq true}
        <h3 class="collection z-panel-header z-panel-indicator z-pointer">{gt text='Collection'}</h3>
        <fieldset class="collection z-panel-content" style="display: none">
    {else}
        <fieldset class="collection">
    {/if}
    <legend>{gt text='Collection'}</legend>
    <div class="z-formrow">
        <div class="simmedRelationRightSide">
            <a id="{$idPrefix}AddLink" href="javascript:void(0);" class="z-hide">{gt text='Select collection'}</a>
            <div id="{$idPrefix}AddFields">
                <label for="{$idPrefix}Selector">{gt text='Find collection'}</label>
                <br />
                {icon type='search' size='extrasmall' __alt='Search collection'}
                <input type="text" name="{$idPrefix}Selector" id="{$idPrefix}Selector" value="" />
                <input type="hidden" name="{$idPrefix}Scope" id="{$idPrefix}Scope" value="0" />
                {img src='indicator_circle.gif' modname='core' set='ajax' alt='' id="`$idPrefix`Indicator" style='display: none'}
                <div id="{$idPrefix}SelectorChoices" class="simmedAutoComplete"></div>
                <input type="button" id="{$idPrefix}SelectorDoCancel" name="{$idPrefix}SelectorDoCancel" value="{gt text='Cancel'}" class="z-button simmedInlineButton" />
                <a id="{$idPrefix}SelectorDoNew" href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='collection'}" title="{gt text='Create new collection'}" class="z-button simmedInlineButton">{gt text='Create'}</a>
            </div>
            <noscript><p>{gt text='This function requires JavaScript activated!'}</p></noscript>
        </div>
        <div class="simmedRelationLeftSide">
            {if isset($userSelection.$aliasName) && $userSelection.$aliasName ne ''}
                {* the user has submitted something *}
                {include file='admin/collection/include_selectEditItemListOne.tpl'  item=$userSelection.$aliasName}
            {elseif $mode ne 'create' || isset($relItem.$aliasName)}
                {include file='admin/collection/include_selectEditItemListOne.tpl'  item=$relItem.$aliasName}
            {else}
                {include file='admin/collection/include_selectEditItemListOne.tpl' }
            {/if}
        </div>
        <br class="z-clearer" />
    </div>
</fieldset>
