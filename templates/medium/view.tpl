{* purpose of this template: media list view *}
{assign var='lct' value='user'}
{if isset($smarty.get.lct) && $smarty.get.lct eq 'admin'}
    {assign var='lct' value='admin'}
{/if}
{include file="`$lct`/header.tpl"}
<div class="simplemedia-medium simplemedia-view">
    {gt text='Medium list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    {if $lct eq 'admin'}
        <div class="z-admin-content-pagetitle">
            {icon type='view' size='small' alt=$templateTitle}
            <h3>{$templateTitle}</h3>
        </div>
    {else}
        <h2>{$templateTitle}</h2>
    {/if}

    <p class="z-informationmsg">{gt text='Media of all sorts'}</p>

    {if $canBeCreated}
        {checkpermissionblock component='SimpleMedia:Medium:' instance='::' level='ACCESS_EDIT'}
            {gt text='Create medium' assign='createTitle'}
            <a href="{modurl modname='SimpleMedia' type=$lct func='edit' ot='medium'}" title="{$createTitle}" class="z-icon-es-add">{$createTitle}</a>
        {/checkpermissionblock}
    {/if}
    {assign var='own' value=0}
    {if isset($showOwnEntries) && $showOwnEntries eq 1}
        {assign var='own' value=1}
    {/if}
    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type=$lct func='view' ot='medium'}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='SimpleMedia' type=$lct func='view' ot='medium' all=1}" title="{$linkTitle}" class="z-icon-es-view">{$linkTitle}</a>
    {/if}

    {include file='medium/view_quickNav.tpl' all=$all own=$own workflowStateFilter=false}{* see template file for available options *}

    {if $lct eq 'admin'}
    <form action="{modurl modname='SimpleMedia' type='medium' func='handleSelectedEntries' lct=$lct}" method="post" id="mediaViewForm" class="z-form">
        <div>
            <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />
    {/if}
        <table class="z-datatable">
            <colgroup>
                {if $lct eq 'admin'}
                    <col id="cSelect" />
                {/if}
                <col id="cTitle" />
                <col id="cTheFile" />
                <col id="cDescription" />
                <col id="cMediaType" />
                <col id="cZipcode" />
                <col id="cPreviewImage" />
                <col id="cViewsCount" />
                <col id="cSortValue" />
                <col id="cCollection" />
                <col id="cItemActions" />
            </colgroup>
            <thead>
            <tr>
                {assign var='catIdListMainString' value=','|implode:$catIdList.Main}
                {if $lct eq 'admin'}
                    <th id="hSelect" scope="col" align="center" valign="middle">
                        <input type="checkbox" id="toggleMedia" />
                    </th>
                {/if}
                <th id="hTitle" scope="col" class="z-left">
                    {sortlink __linktext='Title' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='title' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize ot='medium'}
                </th>
                <th id="hTheFile" scope="col" class="z-left">
                    {sortlink __linktext='The file' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='theFile' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize ot='medium'}
                </th>
                <th id="hDescription" scope="col" class="z-left">
                    {sortlink __linktext='Description' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='description' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize ot='medium'}
                </th>
                <th id="hMediaType" scope="col" class="z-left">
                    {sortlink __linktext='Media type' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='mediaType' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize ot='medium'}
                </th>
                <th id="hZipcode" scope="col" class="z-left">
                    {sortlink __linktext='Zipcode' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='zipcode' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize ot='medium'}
                </th>
                <th id="hPreviewImage" scope="col" class="z-right">
                    {sortlink __linktext='Preview image' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='previewImage' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize ot='medium'}
                </th>
                <th id="hViewsCount" scope="col" class="z-right">
                    {sortlink __linktext='Views count' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='viewsCount' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize ot='medium'}
                </th>
                <th id="hSortValue" scope="col" class="z-right">
                    {sortlink __linktext='Sort value' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='sortValue' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize ot='medium'}
                </th>
                <th id="hCollection" scope="col" class="z-left">
                    {sortlink __linktext='Collection' currentsort=$sort modname='SimpleMedia' type=$lct func='view' sort='collection' sortdir=$sdir all=$all own=$own catidMain=$catIdListMainString collection=$collection workflowState=$workflowState mediaType=$mediaType searchterm=$searchterm pageSize=$pageSize ot='medium'}
                </th>
                <th id="hItemActions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
            </tr>
            </thead>
            <tbody>
        
        {foreach item='medium' from=$items}
            <tr class="{cycle values='z-odd, z-even'}">
                {if $lct eq 'admin'}
                    <td headers="hselect" align="center" valign="top">
                        <input type="checkbox" name="items[]" value="{$medium.id}" class="media-checkbox" />
                    </td>
                {/if}
                <td headers="hTitle" class="z-left">
                    <a href="{modurl modname='SimpleMedia' type=$lct func='display' ot='medium'  id=$medium.id slug=$medium.slug}" title="{gt text='View detail page'}">{$medium.title|notifyfilters:'simplemedia.filterhook.media'}</a>
                </td>
                <td headers="hTheFile" class="z-left">
                      <a href="{$medium.theFileFullPathURL}" title="{$medium->getTitleFromDisplayPattern()|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[medium]"{/if}>
                      {if $medium.theFileMeta.isImage}
                          {thumb image=$medium.theFileFullPath objectid="medium-`$medium.id`" preset=$mediumThumbPresetTheFile tag=true img_alt=$medium->getTitleFromDisplayPattern()}
                      {else}
                          {gt text='Download'} ({$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false})
                      {/if}
                      </a>
                </td>
                <td headers="hDescription" class="z-left">
                    {$medium.description}
                </td>
                <td headers="hMediaType" class="z-left">
                    {$medium.mediaType|simplemediaGetListEntry:'medium':'mediaType'|safetext}
                </td>
                <td headers="hZipcode" class="z-left">
                    {$medium.zipcode}
                </td>
                <td headers="hPreviewImage" class="z-right">
                    {$medium.previewImage}
                </td>
                <td headers="hViewsCount" class="z-right">
                    {$medium.viewsCount}
                </td>
                <td headers="hSortValue" class="z-right">
                    {$medium.sortValue}
                </td>
                <td headers="hCollection" class="z-left">
                    {if isset($medium.Collection) && $medium.Collection ne null}
                        <a href="{modurl modname='SimpleMedia' type=$lct func='display' ot='collection'  id=$medium.Collection.id}">{strip}
                          {$medium.Collection->getTitleFromDisplayPattern()|default:""}
                        {/strip}</a>
                        <a id="collectionItem{$medium.id}_rel_{$medium.Collection.id}Display" href="{modurl modname='SimpleMedia' type=$lct func='display' ot='collection'  id=$medium.Collection.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
                        <script type="text/javascript">
                        /* <![CDATA[ */
                            document.observe('dom:loaded', function() {
                                simmedInitInlineWindow($('collectionItem{{$medium.id}}_rel_{{$medium.Collection.id}}Display'), '{{$medium.Collection->getTitleFromDisplayPattern()|replace:"'":""}}');
                            });
                        /* ]]> */
                        </script>
                    {else}
                        {gt text='Not set.'}
                    {/if}
                </td>
                <td id="itemActions{$medium.id}" headers="hItemActions" class="z-right z-nowrap z-w02">
                    {if count($medium._actions) gt 0}
                        {icon id="itemActions`$medium.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                        {foreach item='option' from=$medium._actions}
                            <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                        {/foreach}
                    
                        <script type="text/javascript">
                        /* <![CDATA[ */
                            document.observe('dom:loaded', function() {
                                simmedInitItemActions('medium', 'view', 'itemActions{{$medium.id}}');
                            });
                        /* ]]> */
                        </script>
                    {/if}
                </td>
            </tr>
        {foreachelse}
            <tr class="z-{if $lct eq 'admin'}admin{else}data{/if}tableempty">
              <td class="z-left" colspan="{if $lct eq 'admin'}11{else}10{/if}">
            {gt text='No media found.'}
              </td>
            </tr>
        {/foreach}
        
            </tbody>
        </table>
        
        {if !isset($showAllEntries) || $showAllEntries ne 1}
            {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page' modname='SimpleMedia' type='medium' func='view' lct=$lct}
        {/if}
    {if $lct eq 'admin'}
            <fieldset>
                <label for="simpleMediaAction">{gt text='With selected media'}</label>
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
        {notifydisplayhooks eventname='simplemedia.ui_hooks.media.display_view' urlobject=$currentUrlObject assign='hooks'}
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
            if ($('toggleMedia') != undefined) {
                $('toggleMedia').observe('click', function (e) {
                    Zikula.toggleInput('mediaViewForm');
                    e.stop()
                });
            }
        {{/if}}
    });
/* ]]> */
</script>
