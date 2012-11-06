{* purpose of this template: media display view in admin area *}
{include file='admin/header.tpl'}
<div class="simplemedia-medium simplemedia-display">
{gt text='Medium' assign='templateTitle'}
{assign var='templateTitle' value=$medium.title|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-admin-content-pagetitle">
    {icon type='display' size='small' __alt='Details'}
    <h3>{$templateTitle|notifyfilters:'simplemedia.filter_hooks.media.filter'}{icon id='itemactionstrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h3>
</div>


{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
<div class="z-panels" id="SimpleMedia_panel">
    <h3 id="z-panel-header-fields" class="z-panel-header z-panel-indicator z-pointer z-panel-active">{gt text='Fields'}</h3>
    <div class="z-panel-content z-panel-active" style="overflow: visible">
{/if}
<dl>
    <dt>{gt text='The file'}</dt>
    <dd>  <a href="{$medium.theFileFullPathURL}" title="{$medium.title|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[medium]"{/if}>
      {if $medium.theFileMeta.isImage}
          <img src="{$medium.theFileFullPath|simplemediaImageThumb:'medium':'theFile':250:150}" width="250" height="150" alt="{$medium.title|replace:"\"":""}" />
      {else}
          {gt text='Download'} ({$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false})
      {/if}
      </a>
    </dd>
    <dt>{gt text='Description'}</dt>
    <dd>{$medium.description}</dd>
    <dt>{gt text='Additional data'}</dt>
    <dd>{$medium.additionalData}</dd>
    <dt>{gt text='Sort value'}</dt>
    <dd>{$medium.sortValue}</dd>
    <dt>{gt text='Media type'}</dt>
    <dd>{$medium.mediaType|simplemediaGetListEntry:'medium':'mediaType'|safetext}</dd>
    <dt>{gt text='Collection'}</dt>
    <dd>
    {if isset($medium.Collection) && $medium.Collection ne null}
      {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
      <a href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$medium.Collection.id}">
        {$medium.Collection.title|default:""}
      </a>
      <a id="collectionItem{$medium.Collection.id}Display" href="{modurl modname='SimpleMedia' type='admin' func='display' ot='collection' id=$medium.Collection.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">
          {icon type='view' size='extrasmall' __alt='Quick view'}
      </a>
      <script type="text/javascript">
      /* <![CDATA[ */
          document.observe('dom:loaded', function() {
              simmedInitInlineWindow($('collectionItem{{$medium.Collection.id}}Display'), '{{$medium.Collection.title|replace:"'":""}}');
          });
      /* ]]> */
      </script>
      {else}
    {$medium.Collection.title|default:""}
      {/if}
    {else}
        {gt text='No set.'}
    {/if}
    </dd>
    
</dl>
{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    </div>
{/if}
{include file='admin/include_attributes_display.tpl' obj=$medium panel=true}
{include file='admin/include_categories_display.tpl' obj=$medium panel=true}
{include file='admin/include_metadata_display.tpl' obj=$medium panel=true}
{include file='admin/include_standardfields_display.tpl' obj=$medium panel=true}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    {* include display hooks *}
    {notifydisplayhooks eventname='simplemedia.ui_hooks.media.display_view' id=$medium.id urlobject=$currentUrlObject assign='hooks'}
    {foreach key='providerArea' item='hook' from=$hooks}
        <h3 class="z-panel-header z-panel-indicator z-pointer">{$providerArea}</h3>
        <div class="z-panel-content" style="display: none">{$hook}</div>
    {/foreach}
    {if count($medium._actions) gt 0}
        <p id="itemactions">
        {foreach item='option' from=$medium._actions}
            <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
        {/foreach}
        </p>
        <script type="text/javascript">
        /* <![CDATA[ */
            document.observe('dom:loaded', function() {
                simmedInitItemActions('medium', 'display', 'itemactions');
            });
        /* ]]> */
        </script>
    {/if}
{/if}

</div>
{include file='admin/footer.tpl'}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            var panel = new Zikula.UI.Panels('SimpleMedia_panel', {
                headerSelector: 'h3',
                headerClassName: 'z-panel-header z-panel-indicator',
                contentClassName: 'z-panel-content',
                active: ['z-panel-header-fields']
            });
        });
    /* ]]> */
    </script>
{/if}
