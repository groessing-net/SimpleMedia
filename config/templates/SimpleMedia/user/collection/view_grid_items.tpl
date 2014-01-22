    {* Initialize options *}
    {if !isset($gridLevel)}
        {assign var='gridLevel' value=0}
    {/if}
    {if !isset($thumbWidth)}
        {assign var='thumbWidth' value=170}
    {/if}
    {if !isset($thumbHeight)}
        {assign var='thumbHeight' value=150}
    {/if}
    {if !isset($wrapWidth)}
        {assign var='wrapWidth' value=220}
    {/if}
    {if !isset($wrapHeight)}
        {assign var='wrapHeight' value=200}
    {/if}
    {if !isset($thumbIcon)}
        {assign var='thumbIcon' value='large'}
    {/if}
    {* Start grid collections *}
    {foreach item='collection' from=$collections}
        {if $collection.lvl eq $gridLevel} {* display only items requested here *}
        <div class="simplemedia-collection-wrap" style="width:{$wrapWidth}px;height:{$wrapHeight}px">
            <div class="simplemedia-collection-title">
                <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$collection.id}" title="{if !empty($collection.description)}{$collection.description}{else}{gt text="View detail page"}{/if}">
                    {$collection.title|notifyfilters:'simplemedia.filterhook.collections'}
                </a>
            </div>
            <div class="simplemedia-collection-preview">
                {if $collection.previewImage != 0}
                    {modapifunc modname='SimpleMedia' type='selection' func='getEntity' objectType='medium' id=$collection.previewImage assign='previewImageMedium'}
                    {if !empty($previewImageMedium) && $previewImageMedium.theFileMeta.isImage}
                        {thumb image=$previewImageMedium.theFileFullPath width=$thumbWidth height=$thumbHeight assign="thumbnail"}
                        {assign var="imgClass" value="simplemedia-img-rounded"}
                    {else}
                        {assign_concat name='thumbnail' 1=$baseurl 2 ="modules/SimpleMedia/images/sm2_collection_$thumbIcon.png"}
                        {assign var="imgClass" value="simplemedia-img-plain"}
                    {/if}
                {else}
                    {assign_concat name='thumbnail' 1=$baseurl 2 ="modules/SimpleMedia/images/sm2_collection_$thumbIcon.png"}
                    {assign var="imgClass" value="simplemedia-img-plain"}
                {/if}
                <a href="{modurl modname='SimpleMedia' type='user' func='display' ot='collection' id=$collection.id}" title="{if !empty($collection.description)}{$collection.description}{else}{gt text="View detail page"}{/if}">
                    <img src="{$thumbnail}" alt="{$collection.description}" class="{$imgClass}" />
                </a>
            </div>
            <div class="simplemedia-collection-actions" id="simplemedia-collection-actions-{$collection.id}">
                <img src="images/icons/extrasmall/info.png" width=16 height=16 id='simplemedia-collection-metaimg-{$collection.id}' title="{gt text='More information'}" />
                {if count($collection._actions) gt 0}
                    {foreach item='option' from=$collection._actions}
                        <a href="{$option.url.type|simplemediaActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>{icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}</a>
                    {/foreach}
                {*icon id="itemActions`$collection.id`Trigger" type='options' size='extrasmall' __alt='Actions' class='z-pointer z-hide'*}
                {/if}
            </div>
            <div class="simplemedia-collection-meta" style="display:none;" id="simplemedia-collection-meta-{$collection.id}">
                {usergetvar name='uname' uid=$collection.createdUserId assign='cr_uname'}
                {usergetvar name='uname' uid=$collection.updatedUserId assign='lu_uname'}
                {if !isset($directChildren) || $directChildren eq true}
                    {simplemediaTreeSelection objectType='collection' node=$collection target='directChildren' assign='directChildren'}
                    {if $directChildren ne null && count($directChildren) gt 0}
                        {simplemediaTreeSelection objectType='collection' node=$collection target='directChildren' assign='directChildren'}
                    {/if}
                {/if}
                <dl>
                    <dd>{*<img src="images/icons/extrasmall/info.png" width=16 height=16 alt="" /> *}{if !empty($collection.description)}{$collection.description|safehtml}{else}{gt text='No description'}{/if}</dd>
                    <dd><img src="images/icons/extrasmall/cal.png" width=16 height=16 alt="" /> {gt text='%1$s by %2$s' tag1=$collection.createdDate|dateformat tag2=$cr_uname}</dd>
                    <dd><img src="modules/SimpleMedia/images/sm2_16x16.png" width=16 height=16 alt="" /> {gt text='Media: %s' tag1=$collection.media|@count}</dd>
                    <dd><img src="images/icons/extrasmall/folder.png" width=16 height=16 alt="" /> {gt text='Collections: %s' tag1=$directChildren|@count}</dd>
                    {* <dd>{assignedcategorieslist categories=$collection.categories doctrine2=true}</dd> *}
                </dl>
            </div>
        </div>
        {/if}
    {/foreach}
    <div class="z-clearfix">&nbsp;</div>
    <script type="text/javascript">
        // <![CDATA[
        document.observe('dom:loaded', function() {
            //simmedInitItemActions('collection', 'view', 'itemActions{{$collection.id}}');
            {{foreach item='collection' from=$collections}}
            $('simplemedia-collection-metaimg-{{$collection.id}}').observe('mouseover', function() {
                $('simplemedia-collection-meta-{{$collection.id}}').show();
            });
            $('simplemedia-collection-metaimg-{{$collection.id}}').observe('mouseout', function() {
                $('simplemedia-collection-meta-{{$collection.id}}').hide();
            });
            $('simplemedia-collection-meta-{{$collection.id}}').hide();
            {{/foreach}}
        });
        // ]]>
    </script>
    {* End grid collections *}