{* Purpose of this template: Display image gallery *}
{pageaddvar name='javascript' value='zikula.imageviewer'}
{assign var='isNicolaus' value=0}
{if $baseurl eq 'http://nicolaus.be/' || $baseurl eq 'http://nicolaus.guite.info/'}
{assign var='isNicolaus' value=1}
{/if}
{assign var='showDefaultGallery' value=true}
{if $isNicolaus eq 1}
    {if isset($smarty.get.pid) && $smarty.get.pid eq 1 && count($items) gt 0}
        {assign var='showDefaultGallery' value=false}
<div class="smgallery">
    {assign var='nivoSliderPath' value='themes/Nicolaus/javascript/nivo-slider-3.1/'}
    {*pageaddvar name='stylesheet' value="`$nivoSliderPath`themes/default/default.css"}
    {pageaddvar name='stylesheet' value="`$nivoSliderPath`themes/light/light.css"}
    {pageaddvar name='stylesheet' value="`$nivoSliderPath`themes/dark/dark.css"}
    {pageaddvar name='stylesheet' value="`$nivoSliderPath`themes/bar/bar.css"*}
    {pageaddvar name='stylesheet' value="`$nivoSliderPath`nivo-slider.css"}
    {pageaddvar name='javascript' value='jquery'}
    {pageaddvar name='javascript' value="`$nivoSliderPath`jquery.nivo.slider.js'}
    {assign var='thumbSize' value=$modvars.SimpleMedia.thumbDimensions[3]}
    <div class="slider-wrapper theme-default">
        <div id="slider" class="nivoSlider">
{foreach item='item' from=$items}
{if $item.theFileMeta.isImage}
            <img src="{$item.theFile|simplemediaImageThumb:$item.theFileFullPath:$thumbSize.width:$thumbSize.height}" width="{$thumbSize.width}" height="{$thumbSize.height}" alt="{$item.title|replace:"\"":""}" />
{/if}
{/foreach}
        </div>
    </div>
</div>
    {else}
        {* nothing, show normal gallery on other pages *}
    {/if}
{/if}
{if $showDefaultGallery}
<p class="smgallery">
{foreach item='item' from=$items}
{if $item.theFileMeta.isImage || $item.theFileMeta.extension eq 'JPG' || $item.theFileMeta.extension eq 'PNG'}
    <a href="{$item.theFileFullPathURL}" title="{$item.title|replace:"\"":""}{if $item.description} - {$item.description|safetext|replace:"\"":""}{/if}" rel="imageviewer[medium]"><img src="{$item.theFile|simplemediaImageThumb:$item.theFileFullPath:60:60}" width="60" height="60" alt="{$item.title|replace:"\"":""}" /></a>
{*getinlinesnippet medium=$item thumbnr=$thumbnr*}
{*<a href="{modurl modname='SimpleMedia' type='user' func='display' ot=$objectType id=$item.id}">{gt text='Read more'}</a>*}
{/if}
{/foreach}
&nbsp;</p>
{/if}
