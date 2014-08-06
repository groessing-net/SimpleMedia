{* purpose of this template: collections list view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="simplemedia-collection simplemedia-view">
    {gt text='Collection list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='view' size='small' alt=$templateTitle}
            <h3>{$templateTitle}</h3>
        </div>
    {else}
        <h2>{$templateTitle}</h2>
    {/if}

    <p class="z-informationmsg">{gt text='Collections are nested trees that can contain media items and sub-collections.'}</p>

    {if $canBeCreated}
        {checkpermissionblock component='SimpleMedia:Collection:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create collection' assign='createTitle'}
            <a href="{modurl modname='SimpleMedia' type='collection' func='edit'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type='collection' func='view'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type='collection' func='view' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}
    {*gt text='Switch to hierarchy view' assign='linkTitle'}
    <a href="{modurl modname='SimpleMedia' type='collection' func='view' tpl='tree'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>*}

    {include file='collection/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    {* display the collections in a grid *}
    {include file='collection/view_items.tpl' collections=$items gridLevel=0}

    {* pager *}
        {if !isset($showAllEntries) || $showAllEntries ne 1}
            {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='SimpleMedia' type='collection' func='view' lct=$lct}
    {/if}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.collections.display_view' urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
    {/if}
</div>
{include file="`$lct`/footer.tpl"}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        {{if $lct eq 'admin'}}
            {{* init the "toggle all" functionality *}}
            if ($('toggleCollections') != undefined) {
                $('toggleCollections').observe('click', function (e) {
                    Zikula.toggleInput('collectionsViewForm');
                    e.stop()
                });
            }
        {{/if}}
    });
/* ]]> */
</script>
