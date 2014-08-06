{* Initialize options *}
{if !isset($clearFix)}{assign var='clearFix' value=true}{/if}

{* Start grid collections in a wrapping div *}
{foreach item='collection' from=$collections}
    {* display only collections on the level requested *}
    {if empty($gridLevel) || $collection.lvl eq $gridLevel}
        <div class="simplemedia-collection-wrap">
            {* Collect the data for the preview image *}
            {if $collection.previewImage != 0}
                {modapifunc modname='SimpleMedia' type='selection' func='getEntity' objectType='medium' id=$collection.previewImage assign='previewImageMedium'}
                {if !empty($previewImageMedium) && $previewImageMedium.theFileMeta.isImage}
                    {thumb image=$previewImageMedium.theFileFullPath module='SimpleMedia' objectid="collection-`$collection.id`" preset=$modvars.SimpleMedia.collectionImaginePreset assign="thumbnail"}
                {else}
                    {thumb image='modules/SimpleMedia/images/sm2_collection_512x512.png' module='SimpleMedia' objectid="collection-`$collection.id`" preset=$modvars.SimpleMedia.collectionImaginePreset assign="thumbnail"}
                {/if}
            {else}
                {thumb image='modules/SimpleMedia/images/sm2_collection_512x512.png' module='SimpleMedia' objectid="collection-`$collection.id`" preset=$modvars.SimpleMedia.collectionImaginePreset assign="thumbnail"}
            {/if}
            <a href="{modurl modname='SimpleMedia' type='collection' func='display' id=$collection.id}" title="{if !empty($collection.description)}{$collection.description}{else}{gt text="View detail page"}{/if}">
            <div class="simplemedia-collection-preview"  id='simplemedia-collection-meta-{$collection.id}-trigger'>
                <img src="{$thumbnail}" alt="{$medium.description}" class="simplemedia-img-rounded" />
                <div class="simplemedia-collection-meta" style="display:none;" id="simplemedia-collection-meta-{$collection.id}">
                    {nocache} {* don't use caching for this info block *}
                    {usergetvar name='uname' uid=$collection.createdUserId assign='cr_uname'}
                    {usergetvar name='uname' uid=$collection.updatedUserId assign='lu_uname'}
                    {if !isset($directChildren) || $directChildren eq true}
                        {simplemediaTreeSelection objectType='collection' node=$collection target='directChildren' assign='directChildren'}
                        {if $directChildren ne null && count($directChildren) gt 0}
                            {simplemediaTreeSelection objectType='collection' node=$collection target='directChildren' assign='directChildren'}
                        {/if}
                    {/if}
                    <dl>
                        <dd>{if !empty($collection.description)}{$collection.description|safehtml}{else}{gt text='No description'}{/if}</dd>
                        <dd><img src="modules/SimpleMedia/images/sm2_16x16.png" width=16 height=16 alt="" /> {gt text='Media: %s' tag1=$collection.media|@count}</dd>
                        <dd><img src="images/icons/extrasmall/folder.png" width=16 height=16 alt="" /> {gt text='Collections: %s' tag1=$directChildren|@count}</dd>
                        <dd><img src="images/icons/extrasmall/14_layer_visible.png" width=16 height=16 alt="" /> {gt text='Views: %s' tag1=$collection.viewsCount}</dd>
                        <dd><img src="images/icons/extrasmall/cal.png" width=16 height=16 alt="" /> {gt text='%1$s by %2$s' tag1=$collection.createdDate|dateformat tag2=$cr_uname}</dd>
                        {* <dd>{assignedcategorieslist categories=$collection.categories doctrine2=true}</dd> *}
                    </dl>
                    {/nocache}
                </div>
            </div>
            </a>
            <div class="simplemedia-collection-title">
                <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$collection.id}" title="{if !empty($collection.description)}{$collection.description}{else}{gt text="View detail page"}{/if}">
                    {$collection.title|notifyfilters:'simplemedia.filterhook.collections'}
                </a>
                {* insert actions with a icon and context menu *}
                {if count($collection._actions) gt 0}
                <span id="itemActions{$collection.id}" headers="hItemActions" class="simplemedia-collection-actions">
                    {*<img src="images/icons/extrasmall/info.png" width=16 height=16 id='simplemedia-collection-metaimg-{$collection.id}' title="{gt text='More information'}" />*}
                    {if count($collection._actions) gt 0}
                        {foreach item='option' from=$collection._actions}
                            <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                        {/foreach}
                        {icon id="itemActions`$collection.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'}
                    {/if}
                </span>
                {/if}
            </div>
        </div>
    {/if}
{/foreach}
{if $clearFix}
<div class="z-clearfix">&nbsp;</div>
{/if}

<script type="text/javascript">
    // <![CDATA[
    document.observe('dom:loaded', function() {
    {{foreach item='collection' from=$collections}}
        simmedInitItemActions('collection', 'view', 'itemActions{{$collection.id}}');
        $('simplemedia-collection-meta-{{$collection.id}}-trigger').observe('mouseover', function() {
            $('simplemedia-collection-meta-{{$collection.id}}').show();
        });
        $('simplemedia-collection-meta-{{$collection.id}}-trigger').observe('mouseout', function() {
            $('simplemedia-collection-meta-{{$collection.id}}').hide();
        });
        $('simplemedia-collection-meta-{{$collection.id}}').hide();
    {{/foreach}}
    });
    // ]]>
</script>
{* End grid collections *}
