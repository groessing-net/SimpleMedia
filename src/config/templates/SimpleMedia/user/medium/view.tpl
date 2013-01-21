{* purpose of this template: media view view in user area *}
{include file='user/header.tpl'}
<div class="simplemedia-medium simplemedia-view">
{gt text='Medium list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>

<p class="sectiondesc">Various kind of media</p>

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

{include file='user/medium/view_quickNav.tpl' categoryFilter=true sorting=true pageSizeSelector=true}{* see template file for available options *}

<table class="z-datatable">
    <colgroup>
        <col id="ctitle" />
        <col id="cthefile" />
        <col id="cdescription" />
        <col id="cadditionaldata" />
        <col id="cmediatype" />
        <col id="ccollection" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="htitle" scope="col" class="z-left">
            {sortlink __linktext='Title' sort='title' currentsort=$sort sortdir=$sdir all=$all own=$own catidMain=$catIdList.Main collection=$collection mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='user' func='view' ot='medium'}
        </th>
        <th id="hthefile" scope="col" class="z-left">
            {sortlink __linktext='The file' sort='theFile' currentsort=$sort sortdir=$sdir all=$all own=$own catidMain=$catIdList.Main collection=$collection mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='user' func='view' ot='medium'}
        </th>
        <th id="hdescription" scope="col" class="z-left">
            {gt text='Description'}
            {*sortlink __linktext='Description' sort='description' currentsort=$sort sortdir=$sdir all=$all own=$own catidMain=$catIdList.Main collection=$collection mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='user' func='view' ot='medium'*}
        </th>
        <th id="hadditionaldata" scope="col" class="z-left">
            {gt text='Additional data'}
            {*sortlink __linktext='Additional data' sort='additionalData' currentsort=$sort sortdir=$sdir all=$all own=$own catidMain=$catIdList.Main collection=$collection mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='user' func='view' ot='medium'*}
        </th>
        <th id="hmediatype" scope="col" class="z-left">
            {sortlink __linktext='Media type' sort='mediaType' currentsort=$sort sortdir=$sdir all=$all own=$own catidMain=$catIdList.Main collection=$collection mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='user' func='view' ot='medium'}
        </th>
        <th id="hcollection" scope="col" class="z-left">
            {sortlink __linktext='Collection' sort='collection' currentsort=$sort sortdir=$sdir all=$all own=$own catidMain=$catIdList.Main collection=$collection mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize modname='SimpleMedia' type='user' func='view' ot='medium'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

{foreach item='medium' from=$items}
    <tr class="{cycle values='z-odd, z-even'}" title="{$medium.description|replace:"\"":""}">
        <td headers="htitle" class="z-left">
            {$medium.title|notifyfilters:'simplemedia.filterhook.media'}
        </td>
        <td headers="hthefile" class="z-left">
            {getinlinesnippet medium=$medium}
              {* 
              <a href="{$medium.theFileFullPathURL}" title="{$medium.title|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[medium]"{/if}>
              {if $medium.theFileMeta.isImage}
                  <img src="{$medium.theFileFullPath|simplemediaImageThumb:'medium':'theFile':32:20}" width="32" height="20" alt="{$medium.title|replace:"\"":""}" />
              {else}
                  {gt text='Download'} ({$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false})
              {/if}
              </a>
              *}
        </td>
        <td headers="hdescription" class="z-left">
            {$medium.description}
        </td>
        <td headers="hadditionaldata" class="z-left">
            {foreach item=additionalVal key=additionalKey from=$medium.additionalData name=additionalData}
            {$additionalKey}: {$additionalVal|default:"-"}{if !$smarty.foreach.additionalData.last}<br />{/if}
            {foreachelse}
            -
            {/foreach}
        </td>
        <td headers="hmediatype" class="z-left">
            {$medium.mediaType|simplemediaGetListEntry:'medium':'mediaType'|safetext}
        </td>
        <td headers="hcollection" class="z-left">
            {if isset($medium.Collection) && $medium.Collection ne null}
                <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$medium.Collection.id}">
                  {$medium.Collection.title|default:""}
                </a>
                <a id="collectionItem{$medium.id}_rel_{$medium.Collection.id}Display" href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$medium.Collection.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">
                    {icon type='view' size='extrasmall' __alt='Quick view'}
                </a>
                <script type="text/javascript">
                /* <![CDATA[ */
                    document.observe('dom:loaded', function() {
                        simmedInitInlineWindow($('collectionItem{{$medium.id}}_rel_{{$medium.Collection.id}}Display'), '{{$medium.Collection.title|replace:"'":""}}');
                    });
                /* ]]> */
                </script>
            {else}
                {gt text='Not set.'}
            {/if}
        </td>
 
        <td id="itemactions{$medium.id}" headers="hitemactions" class="z-right z-nowrap z-w02">
            {* if count($medium._actions) gt 0}
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
            {/if *}
            <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$medium.id}">
                {icon type='display' size='extrasmall' __alt='Details'}
            </a>
    {checkpermissionblock component='SimpleMedia::' instance='.*' level='ACCESS_EDIT'}
            <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='medium' id=$medium.id returnTo='userView'}" title="{gt text='Edit'}">
                {icon type='edit' size='extrasmall' __alt='Edit'}
            </a>
        {if $medium.theFileMeta.isImage && $modvars.SimpleMedia.useThumbCropper eq true}
            {assign var='thumbnr' value=$modvars.SimpleMedia.defaultThumbNumber}
            {if isset($smarty.get.thumbnr) && $smarty.get.thumbnr ne 0}
                {assign var='thumbnr' value=$smarty.get.thumbnr}
            {/if}
            <a href="{modurl modname='SimpleMedia' type='admin' func='editthumb' id=$medium.id thumbnr=$thumbnr returnTo='userView'}" title="{gt text='Crop thumbnail image'}">
                {img src='cropthumb.png' modname='SimpleMedia' __alt='Crop thumbnail image'}
            </a>
        {/if}
{*            <a href="{modurl modname='SimpleMedia' type='admin' func='edit' ot='medium' astemplate=$medium.id}" title="{gt text='Reuse for new item'}">
                {icon type='saveas' size='extrasmall' __alt='Reuse'}
            </a>*}
    {/checkpermissionblock}
        </td>
    </tr>
{foreachelse}
    <tr class="z-datatableempty">
      <td class="z-left" colspan="8">
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
{* include file='user/footer.tpl' *}

