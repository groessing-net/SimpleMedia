{* purpose of this template: collections view view in admin area *}
{include file='admin/header.tpl'}
<div class="simplemedia-collection simplemedia-view">
{gt text='Collection list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='view' size='small' alt=$templateTitle}
    <h3>{$templateTitle}</h3>
</div>

<p class="sectiondesc">{gt text='Collections form a nested tree that contain one or more media items and nested collections.'}</p>

{checkpermissionblock component='SimpleMedia:Collection:' instance='.*' level='ACCESS_ADD'}
    {gt text='Create collection' assign='createTitle'}
    <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='collection'}" title="{$createTitle}" class="z-icon-es-add">
        {$createTitle}
    </a>
{/checkpermissionblock}
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
    <a href="{modurl modname='SimpleMedia' type='admin' func='view' ot='collection' all=1}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
{/if}
{gt text='Switch to hierarchy view' assign='linkTitle'}
<a href="{modurl modname='SimpleMedia' type='admin' func='view' ot='collection' tpl='tree'}" title="{$linkTitle}" class="z-icon-es-view">
    {$linkTitle}
</a>

{include file='admin/collection/view_quickNav.tpl'}{* see template file for available options *}

<table class="z-datatable">
    <colgroup>
        <col id="ctitle" />
        <col id="cdescription" />
        <col id="cparent" />
        <col id="cpreviewimage" />
        <col id="csortvalue" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="htitle" scope="col" class="z-left">
            {sortlink __linktext='Title' sort='title' currentsort=$sort sortdir=$sdir all=$all own=$own catidMain=$catIdList.Main searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='admin' func='view' ot='collection'}
        </th>
        <th id="hdescription" scope="col" class="z-left">
            {sortlink __linktext='Description' sort='description' currentsort=$sort sortdir=$sdir all=$all own=$own catidMain=$catIdList.Main searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='admin' func='view' ot='collection'}
        </th>
        <th id="hparent" scope="col" class="z-left">
            {sortlink __linktext='Parent' sort='parent' currentsort=$sort sortdir=$sdir all=$all own=$own catidMain=$catIdList.Main searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='admin' func='view' ot='collection'}
        </th>
        <th id="hpreviewimage" scope="col" class="z-right">
            {sortlink __linktext='Preview image' sort='previewImage' currentsort=$sort sortdir=$sdir all=$all own=$own catidMain=$catIdList.Main searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='admin' func='view' ot='collection'}
        </th>
        <th id="hsortvalue" scope="col" class="z-right">
            {sortlink __linktext='Sort value' sort='sortValue' currentsort=$sort sortdir=$sdir all=$all own=$own catidMain=$catIdList.Main searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='admin' func='view' ot='collection'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

{foreach item='collection' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="htitle" class="z-left">
            {'-'|str_repeat:$collection.lvl} {$collection.title|notifyfilters:'simplemedia.filterhook.collections'}
        </td>
        <td headers="hdescription" class="z-left">
            {$collection.description}
        </td>
        <td headers="hparent" class="z-right">
            {if isset($collection.parent) && $collection.parent ne null}
                <a href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$collection.parent.id}">
                  {$collection.parent.title|default:""}
                </a>
                <a id="collectionItem{$collection.id}_rel_{$collection.parent.id}Display" href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$collection.parent.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">
                    {icon type='view' size='extrasmall' __alt='Quick view'}
                </a>
                <script type="text/javascript">
                /* <![CDATA[ */
                    document.observe('dom:loaded', function() {
                        simmedInitInlineWindow($('collectionItem{{$collection.id}}_rel_{{$collection.parent.id}}Display'), '{{$collection.parent.title|replace:"'":""}}');
                    });
                /* ]]> */
                </script>
            {else}
                <em>{gt text='none'}</em>
            {/if}
        </td>
        <td headers="hpreviewimage" class="z-right">
            {$collection.previewImage}
        </td>
        <td headers="hsortvalue" class="z-right">
            {$collection.sortValue}
        </td>
        <td id="itemactions{$collection.id}" headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($collection._actions) gt 0}
                {foreach item='option' from=$collection._actions}
                    <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                {/foreach}
                {icon id="itemactions`$collection.id`trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                <script type="text/javascript">
                /* <![CDATA[ */
                    document.observe('dom:loaded', function() {
                        simmedInitItemActions('collection', 'view', 'itemactions{{$collection.id}}');
                    });
                /* ]]> */
                </script>
            {/if}
        </td>
    </tr>
{foreachelse}
    <tr class="z-admintableempty">
      <td class="z-left" colspan="5">
    {gt text='No collections found.'}
      </td>
    </tr>
{/foreach}

    </tbody>
</table>

{if !isset($showAllEntries) || $showAllEntries ne 1}
    {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
{/if}
</div>
{include file='admin/footer.tpl'}