{* purpose of this template: inclusion template for display of related media in user area *}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{if !isset($thumbIcon)}
    {assign var='thumbIcon' value='large'}
{/if}
{if isset($items) && $items ne null && count($items) gt 0}
<div class="simplemedia-medium medium">
{foreach name='relLoop' item='medium' from=$items}
    <div class="simplemedia-medium-wrap" style="width:{$wrapWidth}px;height:{$wrapHeight}px">
        <div class="simplemedia-medium-title">
            <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$medium.id}" title="{if !empty($medium.description)}{$medium.description}{else}{gt text="View detail page"}{/if}">
                {$medium.title|notifyfilters:'simplemedia.filterhook.media'}
            </a>
            {* &nbsp;<img src="images/icons/extrasmall/info.png" width=16 height=16 id='simplemedia-medium-metaimg-{$collection.id}' /> *}
        </div>
        <div class="simplemedia-medium-preview">
            {if $medium.theFileMeta.isImage}
                {thumb image=$medium.theFileFullPath width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                {assign var="imgClass" value="simplemedia-img-rounded"}
                {assign var="download" value=""}
                {* thumb image=$medium.theFileFullPath objectid="medium-`$medium.id`" preset=$mediumThumbPresetTheFile tag=true img_alt=$medium->getTitleFromDisplayPattern() *}
            {elseif $medium.theFileMeta.isDoc}
                {assign_concat name='thumbnail' 1=$baseurl 2 ="modules/SimpleMedia/images/sm2_medium_doc_96x96.png"}
                {assign var="imgClass" value="simplemedia-img-plain"}
                {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="download"}
            {else}
                {assign_concat name='thumbnail' 1=$baseurl 2 ="modules/SimpleMedia/images/sm2_medium_doc_96x96.png"}
                {assign var="imgClass" value="simplemedia-img-plain"}
                {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="download"}
            {/if}
            <a href="{$medium.theFileFullPathURL}" title="{$medium->getTitleFromDisplayPattern()|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[medium]"{/if}>
                <img src="{$thumbnail}" alt="{$medium.description}" class="{$imgClass}" />
                {if !empty($download)}{$download}{/if}
            </a>
        </div>
    </div>
{/foreach}
<div class="z-clearfix">&nbsp;</div>
</div>
{/if}
