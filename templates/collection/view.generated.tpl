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
            <a href="{modurl modname='SimpleMedia' type=$lct func='edit' ot='collection'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type=$lct func='view' ot='collection'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type=$lct func='view' ot='collection' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}
    {gt text='Switch to hierarchy view' assign='linkTitle'}
    <a href="{modurl modname='SimpleMedia' type=$lct func='view' ot='collection' tpl='tree'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>

    {include file='collection/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    {if $lct eq 'admin'}
    <form action="{modurl modname='SimpleMedia' type='collection' func='handleSelectedEntries' lct=$lct}" method="post" id="collectionsViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
    {/if}
        <table class="z-datatable">
            <colgroup>
                {if $lct eq 'admin'}
                    <col id="cSelect" />
                {/if}
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
                {if $lct eq 'admin'}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleCollections" />
                    </th>
                {/if}
                <th id="hTitle" scope="col" class="z-left">
                    {sortlink __linktext='Title' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='title' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize ot='collection'}
                </th>
                <th id="hDescription" scope="col" class="z-left">
                    {sortlink __linktext='Description' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='description' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize ot='collection'}
                </th>
                <th id="hPreviewImage" scope="col" class="z-right">
                    {sortlink __linktext='Preview image' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='previewImage' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize ot='collection'}
                </th>
                <th id="hViewsCount" scope="col" class="z-right">
                    {sortlink __linktext='Views count' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='viewsCount' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize ot='collection'}
                </th>
                <th id="hSortValue" scope="col" class="z-right">
                    {sortlink __linktext='Sort value' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='sortValue' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString workflowState=$workflowState searchterm=$searchterm pageSize=$pageSize ot='collection'}
                </th>
                <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
            </tr>
            </thead>
            <tbody>
        
        {foreach item='collection' from=$items}
            <tr class="{cycle values='z-odd, z-even'}">
                {if $lct eq 'admin'}
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$collection.id}" class="collections-checkbox" />
                    </td>
                {/if}
                <td headers="hTitle" class="z-left">
                    <a href="{modurl modname='SimpleMedia' type=$lct func='display' ot='collection'  id=$collection.id}" title="{gt text='View detail page'}">{$collection.title|notifyfilters:'simplemedia.filterhook.collections'}</a>
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
                        {icon id="itemActions`$collection.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                        {foreach item='option' from=$collection._actions}
                            <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                        {/foreach}
                    
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
            <tr class="z-{if $lct eq 'admin'}admin{else}data{/if}tableempty">
              <td class="z-left" colspan="{if $lct eq 'admin'}7{else}6{/if}">
            {gt text='No collections found.'}
              </td>
            </tr>
        {/foreach}
        
            </tbody>
        </table>
        
        {if !isset($showAllEntries) || $showAllEntries ne 1}
            {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='SimpleMedia' type='collection' func='view' lct=$lct}
        {/if}
    {if $lct eq 'admin'}
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
    {/if}

    
    {if $lct ne 'admin'}
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
