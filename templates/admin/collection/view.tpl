{* purpose of this template: collections view view in admin area *}
{include file='admin/header.tpl'}
<div class="simplemedia-collection simplemedia-view">
    {gt text='Collection list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <div class="z-admin-content-pagetitle">
        {icon type='view' size='small' alt=$templateTitle}
        <h3>{$templateTitle}</h3>
    </div>

    <p class="z-informationmsg">{gt text='Collections are nested trees that can contain media items and sub-collections.'}</p>

    {if $canBeCreated}
        {checkpermissionblock component='SimpleMedia:Collection:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create collection' assign='createTitle'}
            <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='collection'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type='admin' func='view' ot='collection'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type='admin' func='view' ot='collection' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}
    {gt text='Switch to hierarchy view' assign='linkTitle'}
    <a href="{modurl modname='SimpleMedia' type='admin' func='view' ot='collection' tpl='tree'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>

    {include file='admin/collection/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    <form action="{modurl modname='SimpleMedia' type='admin' func='handleSelectedEntries'}" method="post" id="collectionsViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
            <input type="hidden" name="ot" value="collection" />
            <table class="z-datatable">
                <colgroup>
                    <col id="cSelect" />
                    <col id="cTitle" />
                    <col id="cDescription" />
                    <col id="cPreviewImage" />
                    <col id="cViewsCount" />
                    <col id="cSortValue" />
                    <col id="cItemActions" />
                </colgroup>
                <thead>
                <tr>
                    {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleCollections" />
                    </th>
                    <th id="hTitle" scope="col" class="z-left">
                        {sortlink __linktext='Title' currentsort=$sort modname='SimpleMedia' type='admin' func='view' ot='collection' sort='title' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hDescription" scope="col" class="z-left">
                        {sortlink __linktext='Description' currentsort=$sort modname='SimpleMedia' type='admin' func='view' ot='collection' sort='description' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hPreviewImage" scope="col" class="z-right">
                        {sortlink __linktext='Preview image' currentsort=$sort modname='SimpleMedia' type='admin' func='view' ot='collection' sort='previewImage' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hViewsCount" scope="col" class="z-right">
                        {sortlink __linktext='Views count' currentsort=$sort modname='SimpleMedia' type='admin' func='view' ot='collection' sort='viewsCount' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hSortValue" scope="col" class="z-right">
                        {sortlink __linktext='Sort value' currentsort=$sort modname='SimpleMedia' type='admin' func='view' ot='collection' sort='sortValue' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize}
                    </th>
                    <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
                </tr>
                </thead>
                <tbody>
            
            {foreach item='collection' from=$items}
                <tr class="{cycle values='z-odd, z-even'}">
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$collection.id}" class="collections-checkbox" />
                    </td>
                    <td headers="hTitle" class="z-left">
                        <a href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$collection.id}" title="{gt text='View detail page'}">{$collection.title|notifyfilters:'simplemedia.filterhook.collections'}</a>
                    </td>
                    <td headers="hDescription" class="z-left">
                        {$collection.description}
                    </td>
                    <td headers="hPreviewImage" class="z-right">
                        {$collection.previewImage}
                    </td>
                    <td headers="hViewsCount" class="z-right">
                        {$collection.viewsCount}
                    </td>
                    <td headers="hSortValue" class="z-right">
                        {$collection.sortValue}
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
                <tr class="z-admintableempty">
                  <td class="z-left" colspan="7">
                {gt text='No collections found.'}
                  </td>
                </tr>
            {/foreach}
            
                </tbody>
            </table>
            
            {if !isset($showAllEntries) || $showAllEntries ne 1}
                {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='SimpleMedia' type='admin' func='view' ot='collection'}
            {/if}
            <fieldset>
                <label for="simpleMediaAction">{gt text='With selected collections'}</label>
                <select id="simpleMediaAction" name="action">
                    <option value="">{gt text='Choose action'}</option>
                    <option value="delete" title="{gt text='Delete content permanently.'}">{gt text='Delete'}</option>
                </select>
                <input type="submit" value="{gt text='Submit'}" />
            </fieldset>
        </div>
    </form>

</div>
{include file='admin/footer.tpl'}

<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{* init the "toggle all" functionality *}}
    if ($('toggleCollections') != undefined) {
        $('toggleCollections').observe('click', function (e) {
            Zikula.toggleInput('collectionsViewForm');
            e.stop()
        });
    }
    });
/* ]]> */
</script>
