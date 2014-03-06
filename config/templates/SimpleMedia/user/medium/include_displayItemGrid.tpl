{* purpose of this template: inclusion template for display of related media in user area *}
{* Initialize options *}
{if !isset($thumbWidth)}{assign var='thumbWidth' value=170}{/if}
{if !isset($thumbHeight)}{assign var='thumbHeight' value=150}{/if}
{if !isset($nolink)}{assign var='nolink' value=false}{/if}
{if !isset($clearFix)}{assign var='clearFix' value=true}{/if}

{* traverse all media and display relevant data *}
{if isset($items) && $items ne null && count($items) gt 0}
<div class="simplemedia-medium medium">
{foreach name='relLoop' item='medium' from=$items}
    <div class="simplemedia-medium-wrap" style="width:{$thumbWidth}px;">
        {*--- prepare thumbnail choice and how to display/download ---*}
        {assign var='previewImageUsed' value=false}
        {if $medium.theFileMeta.isImage}
            {* thumb image=$medium.theFileFullPath objectid="medium-`$medium.id`" preset=$mediumThumbPresetTheFile tag=true img_alt=$medium->getTitleFromDisplayPattern() *}
            {*thumb image=$medium.theFileFullPath module='SimpleMedia' objectid="medium-`$medium.id`" preset=$modvars.SimpleMedia.defaultImaginePreset width=$thumbWidth height=$thumbHeight assign="thumbnail"*}
            {thumb image=$medium.theFileFullPath module='SimpleMedia' objectid="medium-`$medium.id`" preset=$modvars.SimpleMedia.defaultImaginePreset assign="thumbnail"}
            {assign var="downloadLink" value=""}
        {else}
            {*--- use download link as standard action for non-images ---*}
            {gt text='Download %1$s (%2$s)' tag1=$medium.theFileMeta.extension tag2=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"}
            {if $medium.previewImage != 0}
				{* show the configure preview image for this non-image as thumbnail *}
                {modapifunc modname='SimpleMedia' type='selection' func='getEntity' objectType='medium' id=$medium.previewImage assign='previewImageMedium'}
                {if !empty($previewImageMedium) && $previewImageMedium.theFileMeta.isImage}
                    {thumb image=$previewImageMedium.theFileFullPath width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                    {assign var='previewImageUsed' value=true}
                {else}
                    {thumb image=modules/SimpleMedia/images/sm2_medium_doc_240x240.png width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                {/if}
            {else}
				{* --- Not an image and no preview image present, so display general thumbnail based on file extension --- *}
                {if $medium.theFileMeta.isDoc}
                    {if $medium.theFileMeta.isPdf}
                        {thumb image=modules/SimpleMedia/images/sm2_medium_pdf_240x240.png width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                    {else}
                        {thumb image=modules/SimpleMedia/images/sm2_medium_doc_240x240.png width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                    {/if}
                {elseif $medium.theFileMeta.isAudio}
                    {thumb image=modules/SimpleMedia/images/sm2_medium_audio_240x240.png width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                {* TODO review action here
                    {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                {elseif $medium.theFileMeta.isVideo}
                    {thumb image=modules/SimpleMedia/images/sm2_medium_video_240x240.png width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                {* TODO review action here
                    {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                {elseif $medium.theFileMeta.isRawImage}
                    {thumb image=modules/SimpleMedia/images/sm2_medium_rawimage_240x240.png width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                {* TODO review action here
                    {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                {elseif $medium.theFileMeta.isEbook}
                    {thumb image=modules/SimpleMedia/images/sm2_medium_ebook_240x240.png width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                {* TODO review action here
                    {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                {elseif $medium.theFileMeta.isGeo}
                    {thumb image=modules/SimpleMedia/images/sm2_medium_geo_240x240.png width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                {* TODO review action here
                    {gt text='Download (%s)' tag1=$medium.theFileMeta.size|simplemediaGetFileSize:$medium.theFileFullPath:false:false assign="downloadLink"} *}
                {else}
                    {* if not clasified above just display doc thumbnail *}
                    {thumb image=modules/SimpleMedia/images/sm2_medium_doc_240x240.png width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                {/if}
				{*--- General override here ---*}
                {thumb image="modules/SimpleMedia/images/freefileicons/512px/`$medium.theFileMeta.extension`.png" module='SimpleMedia' objectid="medium-`$medium.id`" preset=$modvars.SimpleMedia.defaultImaginePreset assign="thumbnail"}
            {/if}
        {/if}
        {*--- displaying medium ---*}
        <div class="simplemedia-medium-preview" style="width:{$thumbWidth}px;height:{$thumbHeight}px;">
            {if $previewImageUsed}
                <div class="simplemedia-medium-previewimagetext"
                     style="color:#ddd;background:#000;font-size:1.25em;font-weight:bold;padding:2px;position:absolute;z-index:100;bottom:60px;transform:rotate(315deg);-ms-transform:rotate(315deg); /* IE 9 */-webkit-transform: rotate(315deg); /* Safari and Chrome */">
                    {gt text='Preview image'}
                </div>
            {/if}
            <a href="{$medium.theFileFullPathURL}" title="{$medium->getTitleFromDisplayPattern()|replace:"\"":""}"{if $medium.theFileMeta.isImage} rel="imageviewer[media]"{/if}>
                <img src="{$thumbnail}" alt="{$medium.description}" class="simplemedia-img-rounded" />
            </a>
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
        <div class="simplemedia-medium-title">
            <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$medium.id}" title="{if !empty($medium.description)}{$medium.description}{else}{gt text="View detail page"}{/if}">
                {$medium.title|notifyfilters:'simplemedia.filterhook.media'}
            </a>
            {* &nbsp;<img src="images/icons/extrasmall/info.png" width=16 height=16 id='simplemedia-medium-metaimg-{$collection.id}' /> *}
        </div>
    </div>
{/foreach}
</div> {* simplemedia-medium medium *}
{/if}
{if $clearFix}
<div class="z-clearfix">&nbsp;</div>
{/if}
