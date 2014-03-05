{* purpose of this template: media display view in user area *}
{include file='user/header.tpl'}
<div class="simplemedia-medium simplemedia-display">
    {gt text='Medium' assign='templateTitle'}
    {assign var='templateTitle' value=$medium->getTitleFromDisplayPattern()|default:$templateTitle}
    {pagesetvar name='title' value=$templateTitle|@html_entity_decode}
    <h2>{$templateTitle|notifyfilters:'simplemedia.filter_hooks.media.filter'}{icon id='itemActionsTrigger' type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}</h2>

    <dl>
        <dt>{gt text='Title'}</dt>
        <dd>{$medium.title}</dd>
        <dt>{gt text='The file'}</dt>
        <dd>  <a href="{$medium.theFileFullPathURL}" title="{$medium->getTitleFromDisplayPattern()|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[medium]"{/if}>
          {if $medium.theFileMeta.isImage}
              {thumb image=$medium.theFileFullPath objectid="medium-`$medium.id`" preset=$mediumThumbPresetTheFile tag=true img_alt=$medium->getTitleFromDisplayPattern()}
          {else}
              {gt text='Download'} ({$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false})
          {/if}
          </a>
        </dd>
        <dt>{gt text='Description'}</dt>
        <dd>{$medium.description}</dd>
        <dt>{gt text='Media type'}</dt>
        <dd>{$medium.mediaType|simplemediaGetListEntry:'medium':'mediaType'|safetext}</dd>
        <dt>{gt text='Zipcode'}</dt>
        <dd>{$medium.zipcode}</dd>
        <dt>{gt text='Preview image'}</dt>
        <dd>{$medium.previewImage}</dd>
        <dt>{gt text='Views count'}</dt>
        <dd>{$medium.viewsCount}</dd>
        <dt>{gt text='Sort value'}</dt>
        <dd>{$medium.sortValue}</dd>
        <dt>{gt text='Latitude'}</dt>
        <dd>{$medium.latitude|simplemediaFormatGeoData}</dd>
        <dt>{gt text='Longitude'}</dt>
        <dd>{$medium.longitude|simplemediaFormatGeoData}</dd>
        <dt>{gt text='Collection'}</dt>
        <dd>
        {if isset($medium.Collection) && $medium.Collection ne null}
          {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
          <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$medium.Collection.id}">{strip}
            {$medium.Collection->getTitleFromDisplayPattern()|default:""}
          {/strip}</a>
          <a id="collectionItem{$medium.Collection.id}Display" href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$medium.Collection.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
          <script type="text/javascript">
          /* <![CDATA[ */
              document.observe('dom:loaded', function() {
                  simmedInitInlineWindow($('collectionItem{{$medium.Collection.id}}Display'), '{{$medium.Collection->getTitleFromDisplayPattern()|replace:"'":""}}');
              });
          /* ]]> */
          </script>
          {else}
            {$medium.Collection->getTitleFromDisplayPattern()|default:""}
          {/if}
        {else}
            {gt text='Not set.'}
        {/if}
        </dd>
        
    </dl>
    <h3 class="simplemedia-map">{gt text='Map'}</h3>
    {pageaddvarblock name='header'}
        <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
        <script type="text/javascript" src="{$baseurl}plugins/Mapstraction/lib/vendor/mxn/mxn.js?(googlev3)"></script>
        <script type="text/javascript">
        /* <![CDATA[ */
            var mapstraction;
            Event.observe(window, 'load', function() {
                mapstraction = new mxn.Mapstraction('mapContainer', 'googlev3');
                mapstraction.addControls({
                    pan: true,
                    zoom: 'small',
                    map_type: true
                });
    
                var latlon = new mxn.LatLonPoint({{$medium.latitude|simplemediaFormatGeoData}}, {{$medium.longitude|simplemediaFormatGeoData}});
    
                mapstraction.setMapType(mxn.Mapstraction.SATELLITE);
                mapstraction.setCenterAndZoom(latlon, 18);
                mapstraction.mousePosition('position');
    
                // add a marker
                var marker = new mxn.Marker(latlon);
                mapstraction.addMarker(marker, true);
            });
        /* ]]> */
        </script>
    {/pageaddvarblock}
    <div id="mapContainer" class="simplemedia-mapcontainer">
    </div>
    {include file='user/include_attributes_display.tpl' obj=$medium}
    {include file='user/include_categories_display.tpl' obj=$medium}
    {include file='user/include_metadata_display.tpl' obj=$medium}
    {include file='user/include_standardfields_display.tpl' obj=$medium}

    {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        {* include display hooks *}
        {notifydisplayhooks eventname='simplemedia.ui_hooks.media.display_view' id=$medium.id urlobject=$currentUrlObject assign='hooks'}
        {foreach key='providerArea' item='hook' from=$hooks}
            {$hook}
        {/foreach}
        {if count($medium._actions) gt 0}
            <p id="itemActions">
            {foreach item='option' from=$medium._actions}
                <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">{$option.linkText|safetext}</a>
            {/foreach}
            </p>
            <script type="text/javascript">
            /* <![CDATA[ */
                document.observe('dom:loaded', function() {
                    simmedInitItemActions('medium', 'display', 'itemActions');
                });
            /* ]]> */
            </script>
        {/if}
    {/if}
</div>
{include file='user/footer.tpl'}
