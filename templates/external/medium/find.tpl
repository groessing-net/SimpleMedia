{* Purpose of this template: Display a popup selector of media for scribite integration *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{lang}" lang="{lang}">
<head>
    <title>{gt text='SimpleMedia - Insert media'}</title>
    <link type="text/css" rel="stylesheet" href="{$baseurl}style/core.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/SimpleMedia/style/style.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/SimpleMedia/style/finder.css" />
    {assign var='ourEntry' value=$modvars.ZConfig.entrypoint}
    <script type="text/javascript">/* <![CDATA[ */
        if (typeof(Zikula) == 'undefined') {var Zikula = {};}
        Zikula.Config = {'entrypoint': '{{$ourEntry|default:'index.php'}}', 'baseURL': '{{$baseurl}}'}; /* ]]> */</script>
        <script type="text/javascript" src="{$baseurl}javascript/ajax/proto_scriptaculous.combined.min.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/livepipe/livepipe.combined.min.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.UI.js"></script>
        <script type="text/javascript" src="{$baseurl}javascript/helpers/Zikula.ImageViewer.js"></script>
    <script type="text/javascript" src="{$baseurl}modules/SimpleMedia/javascript/SimpleMedia_finder.js"></script>
{if $editorName eq 'tinymce'}
    <script type="text/javascript" src="{$baseurl}modules/Scribite/includes/tinymce/tiny_mce_popup.js"></script>
{/if}
</head>
<body>
    <p class="z-clearfix">
        <img src="{$baseurl}modules/SimpleMedia/images/sm2_16x16.png" width='16' height='16' class="z-floatright" />
        {gt text='<strong>SimpleMedia</strong> :: Switch to select'}
        <a href="{modurl modname='SimpleMedia' type='external' func='finder' objectType='collection' editor=$editorName}" title="{gt text='Search and select collection'}">{gt text='Collections'}</a>
    </p>

    {* Insert a tab interface for selecting/inserting media and direct uploading *}
    <ul id="tabs_simplemedia_find" class="z-tabs">
        <li class="tab"><a href="#SelectMedium">Select Media</a></li>
        <li class="tab"><a href="#UploadMedia">Upload Media</a></li>
    </ul>
    
    <div id="SelectMedium">
        <form action="{$ourEntry|default:'index.php'}" id="simpleMediaSelectorForm" method="get" class="z-form">
        <input type="hidden" name="module" value="SimpleMedia" />
        <input type="hidden" name="type" value="external" />
        <input type="hidden" name="func" value="finder" />
        <input type="hidden" name="objectType" value="{$objectType}" />
        <input type="hidden" name="editor" id="editorName" value="{$editorName}" />

        <div class="z-w25 z-floatleft">
            <div class="z-linear">
                <label for="simpleMediaPasteAs"><strong>{gt text='Insert Medium as'}</strong></label><br />
                <select id="simpleMediaPasteAs" name="pasteas">
                    <option value="1">{gt text='Medium thumbnail'}</option>
                    <option value="2">{gt text='Medium Full'}</option>
                    <option value="3">{gt text='Link to the medium'}</option>
                    <option value="4">{gt text='ID of medium'}</option>
                </select>
            </div>

            <strong>{gt text='Selection filter'}</strong>
            {if $properties ne null && is_array($properties)}
                {gt text='All' assign='lblDefault'}
                {nocache}
                {foreach key='propertyName' item='propertyId' from=$properties}
                    <div class="z-linear categoryselector">
                        {modapifunc modname='SimpleMedia' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
                        {gt text='Category' assign='categoryLabel'}
                        {assign var='categorySelectorId' value='catid'}
                        {assign var='categorySelectorName' value='catid'}
                        {assign var='categorySelectorSize' value='1'}
                        {if $hasMultiSelection eq true}
                            {gt text='Categories' assign='categoryLabel'}
                            {assign var='categorySelectorName' value='catids'}
                            {assign var='categorySelectorId' value='catids__'}
                            {assign var='categorySelectorSize' value='8'}
                        {/if}
                        <label for="{$categorySelectorId}{$propertyName}">{$categoryLabel}</label><br />
                            {selector_category name="`$categorySelectorName``$propertyName`" field='id' selectedValue=$catIds.$propertyName categoryRegistryModule='SimpleMedia' categoryRegistryTable=$objectType categoryRegistryProperty=$propertyName defaultText=$lblDefault editLink=false multipleSize=$categorySelectorSize}
                            <span class="z-sub z-formnote">{gt text='This is an optional filter.'}</span>
                    </div>
                {/foreach}
                {/nocache}
            {/if}

            <div class="z-linear">
                <label for="simpleMediaSort">{gt text='Sort by'}:</label><br />
                <select id="simpleMediaSort" name="sort" style="width: 150px" class="z-floatleft" style="margin-right: 10px">
                <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
                <option value="workflowState"{if $sort eq 'workflowState'} selected="selected"{/if}>{gt text='Workflow state'}</option>
                <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
                <option value="theFile"{if $sort eq 'theFile'} selected="selected"{/if}>{gt text='The file'}</option>
                <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
                    <option value="mediaType"{if $sort eq 'mediaType'} selected="selected"{/if}>{gt text='Media type'}</option>
                <option value="zipcode"{if $sort eq 'zipcode'} selected="selected"{/if}>{gt text='Zipcode'}</option>
                <option value="previewImage"{if $sort eq 'previewImage'} selected="selected"{/if}>{gt text='Preview image'}</option>
                    <option value="viewsCount"{if $sort eq 'viewsCount'} selected="selected"{/if}>{gt text='Views count'}</option>
                <option value="sortValue"{if $sort eq 'sortValue'} selected="selected"{/if}>{gt text='Sort value'}</option>
                <option value="mediaType"{if $sort eq 'mediaType'} selected="selected"{/if}>{gt text='Media type'}</option>
                <option value="viewsCount"{if $sort eq 'viewsCount'} selected="selected"{/if}>{gt text='Views count'}</option>
                <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
                <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
                </select>
                <select id="simpleMediaSortDir" name="sortdir" style="width: 100px">
                    <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                    <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
                </select>
            </div>

            <div class="z-linear">
                <label for="simpleMediaPageSize">{gt text='Page size'}:</label><br />
                <select id="simpleMediaPageSize" name="num" style="width: 50px; text-align: right">
                    <option value="5"{if $pager.itemsperpage eq 5} selected="selected"{/if}>5</option>
                    <option value="10"{if $pager.itemsperpage eq 10} selected="selected"{/if}>10</option>
                    <option value="15"{if $pager.itemsperpage eq 15} selected="selected"{/if}>15</option>
                    <option value="20"{if $pager.itemsperpage eq 20} selected="selected"{/if}>20</option>
                    <option value="30"{if $pager.itemsperpage eq 30} selected="selected"{/if}>30</option>
                    <option value="50"{if $pager.itemsperpage eq 50} selected="selected"{/if}>50</option>
                    <option value="100"{if $pager.itemsperpage eq 100} selected="selected"{/if}>100</option>
                </select>
            </div>

            <div class="z-linear">
                <label for="simpleMediaSearchTerm">{gt text='Search for'}:</label><br />
                <input type="text" id="simpleMediaSearchTerm" name="searchterm" style="width: 150px" class="z-floatleft" style="margin-right: 10px" />
                <input type="button" id="simpleMediaSearchGo" name="gosearch" value="{gt text='Filter'}" style="width: 80px" />
            </div>
        </div>
        
        <div class="z-w70 z-floatright">
            <fieldset>
                <legend>{gt text='List of available Media'}</legend>
                <div class="z-linear">
                    {*<label for="simpleMediaObjectId">{gt text='Medium'}:</label>*}
                        <div id="simplemediaItemContainer">
                            <ul>
                            {foreach item='medium' from=$items}
                                <li>
                                    <a href="#" onclick="simplemedia.finder.selectItem({$medium.id})" onkeypress="simplemedia.finder.selectItem({$medium.id})">{$medium->getTitleFromDisplayPattern()}</a>
                                    <input type="hidden" id="url{$medium.id}" value="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$medium.id slug=$medium.slug fqurl=true}" />
                                    <input type="hidden" id="title{$medium.id}" value="{$medium->getTitleFromDisplayPattern()|replace:"\"":""}" />
                                    <input type="hidden" id="desc{$medium.id}" value="{capture assign='description'}{if $medium.description ne ''}{$medium.description}{/if}
                                    {/capture}{$description|strip_tags|replace:"\"":""}" />
                                </li>
                            {foreachelse}
                                <li>{gt text='No entries found.'}</li>
                            {/foreach}
                            </ul>
                        </div>
                </div>
                <div class="z-linear">
                    <strong>{gt text='Display'}:</strong>
                    <label for="simpleMediaShowMetaName">{gt text='Name'}</label>
                    <input type="checkbox" id="simpleMediaShowMetaName" name="showmetaname" {if $showmetaname eq '1'}checked{/if} value="1" />
                    <label for="simpleMediaShowMetaSize">{gt text='Size'}</label>
                    <input type="checkbox" id="simpleMediaShowMetaSize" name="showmetasize" {if $showmetasize eq '1'}checked{/if} value="1" />
                    <label for="simpleMediaShowMetaDate">{gt text='Date'}</label>
                    <input type="checkbox" id="simpleMediaShowMetaDate" name="showmetadate" {if $showmetadate eq '1'}checked{/if} value="1" />
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <strong>{gt text='Display images as'}:</strong>
                    <label for="simpleMediaShowImageList">{gt text='List'}</label>
                    <input type="radio" id="simpleMediaShowImageList" name="displayimagesas" {if $displayimagesas eq 'list'}checked{/if} value="list" />
                    <label for="simpleMediaShowImageThumbs">{gt text='Thumbnails'}</label>
                    <input type="radio" id="simpleMediaShowImageThumbs" name="displayimagesas"{if $displayimagesas eq 'thumbnails'}checked{/if} value="thumbnails" />
                </div>
                <div style="margin-left: 6em">
                    {pager display='page' rowcount=$pager.numitems limit=$pager.itemsperpage posvar='pos' template='pagercss.tpl' maxpages='10'}
                </div>
            </fieldset>
        </div>
        <div class="z-clearfix">&nbsp;</div>
        <input type="submit" id="simpleMediaSubmit" name="submitButton" value="{gt text='Change selection'}" />
        <input type="button" id="simpleMediaCancel" name="cancelButton" value="{gt text='Cancel'}" />
        </form>
    </div>

    <div id="UploadMedia">
        <p>Fusce eu magna nec tortor libero, egestas dignissim, imperdiet tempor, pulvinar felis,
        consequat pharetra. Morbi placerat pharetra varius. In quis justo. Vivamus justo. Nulla in wisi. Proin in ultricies eu, neque. 
        Pellentesque dolor. Vestibulum tempus nulla. Morbi mattis. Nunc elementum. Nam rhoncus, dui sodales nibh nulla in consequat ipsum primis 
        in magna iaculis odio et dui. Vivamus posuere quis, libero. Aliquam erat vel leo. Donec interdum vitae, cursus mauris ac sapien. Praesent 
        justo. Vivamus diam mollis nunc sit amet, elementum vitae, ligula. Aliquam erat blandit eros, sagittis luctus nibh, interdum faucibus, 
        fermentum nec, sem. Cras non neque dui, porta ligula.</p>
    </div>
    
    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            simplemedia.finder.onLoad();
            var tabs = new Zikula.UI.Tabs('tabs_simplemedia_find');
        });
    /* ]]> */
    </script>

    {*
    <div class="simplemedia-finderform">
        <fieldset>
            {modfunc modname='SimpleMedia' type='admin' func='edit'}
        </fieldset>
    </div>
    *}
</body>
</html>
