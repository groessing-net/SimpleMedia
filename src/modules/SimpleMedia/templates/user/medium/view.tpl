{* purpose of this template: media view view in user area *}
{include file='user/header.tpl'}
<div class="simplemedia-medium simplemedia-view">
{gt text='Medium list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>

{assign var='own' value=0}
{if isset($showOwnEntries) && $showOwnEntries eq 1}
    {assign var='own' value=1}
{/if}
{assign var='all' value=0}
{if isset($showAllEntries) && $showAllEntries eq 1}
    {gt text='Back to paginated view' assign='linkTitle'}
    <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='medium'}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
    {assign var='all' value=1}
{else}
    {gt text='Show all entries' assign='linkTitle'}
    <a href="{modurl modname='SimpleMedia' type='user' func='view' ot='medium' all=1}" title="{$linkTitle}" class="z-icon-es-view">
        {$linkTitle}
    </a>
{/if}

{include file='user/medium/view_quickNav.tpl'}{* see template file for available options *}

<table class="z-datatable">
    <colgroup>
        <col id="ctitle" />
        <col id="cthefile" />
        <col id="cdescription" />
        <col id="cadditionaldata" />
        <col id="cmediatype" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="htitle" scope="col" class="z-left">
            {sortlink __linktext='Title' sort='title' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Collection=$Collection mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='user' func='view' ot='medium'}
        </th>
        <th id="hthefile" scope="col" class="z-left">
            {sortlink __linktext='The file' sort='theFile' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Collection=$Collection mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='user' func='view' ot='medium'}
        </th>
        <th id="hdescription" scope="col" class="z-left">
            {sortlink __linktext='Description' sort='description' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Collection=$Collection mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='user' func='view' ot='medium'}
        </th>
        <th id="hadditionaldata" scope="col" class="z-left">
            {sortlink __linktext='Additional data' sort='additionalData' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Collection=$Collection mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='user' func='view' ot='medium'}
        </th>
        <th id="hmediatype" scope="col" class="z-left">
            {sortlink __linktext='Media type' sort='mediaType' currentsort=$sort sortdir=$sdir all=$all own=$own catid=$catId Collection=$Collection mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='user' func='view' ot='medium'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

{foreach item='medium' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="htitle" class="z-left">
            {$medium.title|notifyfilters:'simplemedia.filterhook.media'}
        </td>
        <td headers="hthefile" class="z-left">
              <a href="{$medium.theFileFullPathURL}" title="{$medium.title|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[medium]"{/if}>
              {if $medium.theFileMeta.isImage}
                  <img src="{$medium.theFileFullPath|simplemediaImageThumb:32:20}" width="32" height="20" alt="{$medium.title|replace:"\"":""}" />
              {else}
                  {gt text='Download'} ({$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false})
              {/if}
              </a>
        </td>
        <td headers="hdescription" class="z-left">
            {$medium.description}
        </td>
        <td headers="hadditionaldata" class="z-left">
            {$medium.additionalData}
        </td>
        <td headers="hmediatype" class="z-left">
            {$medium.mediaType|simplemediaGetListEntry:'medium':'mediaType'|safetext}
        </td>
        <td id="itemactions{$medium.id}" headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($medium._actions) gt 0}
                {foreach item='option' from=$medium._actions}
                    <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                {/foreach}
                {icon id="itemactions`$medium.id`trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                <script type="text/javascript">
                /* <![CDATA[ */
                    document.observe('dom:loaded', function() {
                        simmedInitItemActions('medium', 'view', 'itemactions{{$medium.id}}');
                    });
                /* ]]> */
                </script>
            {/if}
        </td>
    </tr>
{foreachelse}
    <tr class="z-datatableempty">
      <td class="z-left" colspan="6">
    {gt text='No media found.'}
      </td>
    </tr>
{/foreach}

    </tbody>
</table>

{if !isset($showAllEntries) || $showAllEntries ne 1}
    {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
{/if}

{notifydisplayhooks eventname='simplemedia.ui_hooks.media.display_view' urlobject=$currentUrlObject assign='hooks'}
{foreach key='providerArea' item='hook' from=$hooks}
    {$hook}
{/foreach}
</div>
</div>
{include file='user/footer.tpl'}

