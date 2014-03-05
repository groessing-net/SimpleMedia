{* purpose of this template: collections view view in user area *}
{include file='user/header.tpl'}
<div class="simplemedia-collection simplemedia-view">
    {gt text='Collections' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    {* always display paginated view, disabled showallentries
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='collection'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='collection' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}
    *}
    {*
    {gt text='Switch to hierarchy view' assign='linkTitle'}
    <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='collection' tpl='tree'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    *}

    {* filtering and sorting menu *}
    {include file='user/collection/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    {* display the collections in a grid *}
    {include file='user/collection/view_grid_items.tpl' collections=$items gridLevel=0 thumbWidth=175 thumbHeight=150}

    {* pager *}
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='SimpleMedia' type='user' func='view' ot='collection'}
    {/if}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    {* include display hooks *}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.collections.display_view' urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
    {/if}
</div>
{include file='user/footer.tpl'}