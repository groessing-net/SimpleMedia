{* purpose of this template: inclusion template for display of related media in user area *}
{* Initialize options *}
{if !isset($nolink)}{assign var='nolink' value=false}{/if}
{if !isset($clearFix)}{assign var='clearFix' value=true}{/if}

{* traverse all media and display relevant data *}
{if isset($items) && $items ne null && count($items) gt 0}
<div class="simplemedia-medium medium">
{foreach name='relLoop' item='medium' from=$items}
    <div class="simplemedia-medium-wrap">
        {*--- prepare thumbnail choice and how to display/download ---*}
        {assign var='previewImageUsed' value=false}
        {if $medium.theFileMeta.isImage}
            {*--- regular image ---*}
            {thumb image=$medium.theFileFullPath module='SimpleMedia' objectid="medium-`$medium.id`" preset=$modvars.SimpleMedia.defaultImaginePreset assign="thumbnail"}
            {assign var="downloadLink" value=""}
        {else}
            {*--- use download link as standard action for non-images files ---*}
            {gt text='Download %1$s (%2$s)' tag1=$medium.theFileMeta.extension tag2=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"}
            {if $medium.previewImage != 0}
				{*--- show the configure preview image for this non-image as thumbnail ---*}
                {modapifunc modname='SimpleMedia' type='selection' func='getEntity' objectType='medium' id=$medium.previewImage assign='previewImageMedium'}
                {if !empty($previewImageMedium) && $previewImageMedium.theFileMeta.isImage}
                    {thumb image=$previewImageMedium.theFileFullPath width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                    {assign var='previewImageUsed' value=true}
                {else}
                    {thumb image="modules/SimpleMedia/images/freefileicons/512px/`$medium.theFileMeta.extension`.png" module='SimpleMedia' objectid="medium-`$medium.id`" preset=$modvars.SimpleMedia.defaultImaginePreset assign="thumbnail"}
                {/if}
            {else}
				{* --- Not an image and no preview image present, so display general thumbnail based on file extension --- *}
                {if $medium.theFileMeta.isDoc}
                    {if $medium.theFileMeta.isPdf}
                        {* TODO review action here
                            {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                    {else}
                        {* TODO review action here
                            {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                    {/if}
                {elseif $medium.theFileMeta.isAudio}
                {* TODO review action here
                    {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                {elseif $medium.theFileMeta.isVideo}
                {* TODO review action here
                    {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                {elseif $medium.theFileMeta.isRawImage}
                {* TODO review action here
                    {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                {elseif $medium.theFileMeta.isEbook}
                {* TODO review action here
                    {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                {elseif $medium.theFileMeta.isGeo}
                {* TODO review action here
                    {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                {else}
                    {* if not clasified above just display doc thumbnail *}
                {/if}
				{*--- General override here ---*}
                {thumb image="modules/SimpleMedia/images/freefileicons/512px/`$medium.theFileMeta.extension`.png" module='SimpleMedia' objectid="medium-`$medium.id`" preset=$modvars.SimpleMedia.defaultImaginePreset assign="thumbnail"}
            {/if}
        {/if}
        {*--- displaying medium ---*}
        <div class="simplemedia-medium-preview">
            {if $previewImageUsed}
                <div class="simplemedia-medium-previewimagetext">
                    {gt text='Preview image'}
                </div>
            {/if}
            <a href="{$medium.theFileFullPathURL}" title="{$medium->getTitleFromDisplayPattern()|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[media]"{/if}>
                <img src="{$thumbnail}" alt="{$medium.description}" class="simplemedia-img-rounded" />
            </a>
        </div>
        <div class="simplemedia-medium-title">
            <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$medium.id}" title="{if !empty($medium.description)}{$medium.description}{else}{gt text="View detail page"}{/if}">
                {$medium.title|notifyfilters:'simplemedia.filterhook.media'}
            </a>
            {* &nbsp;<img src="images/icons/extrasmall/info.png" width=16 height=16 id='simplemedia-medium-metaimg-{$collection.id}' /> *}
        </div>
        <div class="simplemedia-medium-download">
            {if !empty($downloadLink)}
                <a href="{$medium.theFileFullPathURL}" title="{$medium->getTitleFromDisplayPattern()|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[media]"{/if}>
                    {$downloadLink}
                </a>
            {else}
                &nbsp;
            {/if}
        </div>
    </div>
{/foreach}
</div> {* simplemedia-medium medium *}
{/if}
{if $clearFix}
<div class="z-clearfix">&nbsp;</div>
{/if}