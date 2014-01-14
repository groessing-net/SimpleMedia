{* purpose of this template: collections view view in user area *}
{include file='user/header.tpl'}
<div class="simplemedia-collection simplemedia-view">
    {gt text='Collection list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    <p class="z-informationmsg">Collections are nested trees that can contain media items and sub-collections.</p>

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
    {gt text='Switch to hierarchy view' assign='linkTitle'}
    <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='collection' tpl='tree'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>

    {include file='user/collection/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <table class="z-datatable">
        <colgroup>
            <col id="cTitle" />
            <col id="cDescription" />
            <col id="cPreviewImage" />
            <col id="cSortValue" />
            <col id="cViewsCount" />
            <col id="cItemActions" />
        </colgroup>
        <thead>
        <tr>
            {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
            <th id="hTitle" scope="col" class="z-left">
                {sortlink __linktext='Title' currentsort=$sort modname='SimpleMedia' type='user' func='view' ot='collection' sort='title' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hDescription" scope="col" class="z-left">
                {sortlink __linktext='Description' currentsort=$sort modname='SimpleMedia' type='user' func='view' ot='collection' sort='description' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hPreviewImage" scope="col" class="z-right">
                {sortlink __linktext='Preview image' currentsort=$sort modname='SimpleMedia' type='user' func='view' ot='collection' sort='previewImage' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hSortValue" scope="col" class="z-right">
                {sortlink __linktext='Sort value' currentsort=$sort modname='SimpleMedia' type='user' func='view' ot='collection' sort='sortValue' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hViewsCount" scope="col" class="z-right">
                {sortlink __linktext='Views count' currentsort=$sort modname='SimpleMedia' type='user' func='view' ot='collection' sort='viewsCount' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
            </th>
            <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
        </tr>
        </thead>
        <tbody>
    
    {foreach item='collection' from=$items}
        <tr class="{cycle values='z-odd, z-even'}">
            <td headers="hTitle" class="z-left">
                <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$collection.id}" title="{gt text='View detail page'}">{$collection.title|notifyfilters:'simplemedia.filterhook.collections'}</a>
            </td>
            <td headers="hDescription" class="z-left">
                {$collection.description}
            </td>
            <td headers="hPreviewImage" class="z-right">
                {$collection.previewImage}
            </td>
            <td headers="hSortValue" class="z-right">
                {$collection.sortValue}
            </td>
            <td headers="hViewsCount" class="z-right">
                {$collection.viewsCount}
            </td>
            <td id="itemActions{$collection.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                {if count($collection._actions) gt 0}
                    {foreach item='option' from=$collection._actions}
                        <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                    {/foreach}
                    {icon id="itemActions`$collection.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                    <script type="text/javascript">
                    /* <![CDATA[ */
                        document.observe('dom:loaded', function() {
                            simmedInitItemActions('collection', 'view', 'itemActions{{$collection.id}}');
                        });
                    /* ]]> */
                    </script>
                {/if}
            </td>
        </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="6">
        {gt text='No collections found.'}
          </td>
        </tr>
    {/foreach}
    
        </tbody>
    </table>
    
    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='SimpleMedia' type='user' func='view' ot='collection'}
    {/if}

    
    {notifydisplayhooks eventname='simplemedia.ui_hooks.collections.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
{include file='user/footer.tpl'}