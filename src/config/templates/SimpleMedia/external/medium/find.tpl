{* Purpose of this template: Display a popup selector of media for scribite integration *}
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="{lang}" lang="{lang}">
<head>
    <title>{gt text='SimpleMedia search and select medium'}</title>
    <link type="text/css" rel="stylesheet" href="{$baseurl}style/core.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/SimpleMedia/style/style.css" />
    <link type="text/css" rel="stylesheet" href="{$baseurl}modules/SimpleMedia/style/finder.css" />
    {assign var='ourEntry' value=$modvars.ZConfig.entrypoint}
    <script type="text/javascript">/* <![CDATA[ */
        if (typeof(Zikula) == 'undefined') {var Zikula = {};}
        Zikula.Config = {'entrypoint': '{{$ourEntry|default:'index.php'}}', 'baseURL': '{{$baseurl}}'}; /* ]]> */</script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/prototype.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/scriptaculous.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/dragdrop.js"></script>
    <script type="text/javascript" src="{$baseurl}javascript/ajax/original_uncompressed/effects.js"></script>
    <script type="text/javascript" src="{$baseurl}modules/SimpleMedia/javascript/SimpleMedia_finder.js"></script>
</head>
<body>
    <p class="z-clearfix">
    <img src="{$baseurl}modules/SimpleMedia/images/admin.png" class="z-floatright" />
    {gt text='Switch to search and select'}:
    <a href="{modurl modname='SimpleMedia' type='external' func='finder' objectType='collection' editor=$editorName}" title="{gt text='Search and select collection'}">{gt text='Collections'}</a>
    </p>

    <form action="{$ourEntry|default:'index.php'}" id="selectorForm" method="get" class="z-form">
    <div class="z-w40">
    </div>
    <div class="z-w60">
    </div>

{*    <div>*}
        <input type="hidden" name="module" value="SimpleMedia" />
        <input type="hidden" name="type" value="external" />
        <input type="hidden" name="func" value="finder" />
        <input type="hidden" name="objectType" value="{$objectType}" />
        <input type="hidden" name="editor" id="editorName" value="{$editorName}" />

        <fieldset>
            <legend>{gt text='Search and select medium'}</legend>

    <div class="z-w30 z-floatleft">

            <div class="z-formrow">
                <label for="SimpleMedia_pasteas">{gt text='Paste as'}:</label>
                <select id="SimpleMedia_pasteas" name="pasteas">
                    <option value="1">{gt text='Link to the medium'}</option>
                    <option value="2">{gt text='ID of medium'}</option>
                </select>
            </div>

            <div class="z-formrow">
                <label for="SimpleMedia_showimagesas">{gt text='Images as'}:</label>
                <select id="SimpleMedia_showimagesas" name="showimagesas">
                    <option value="1">{gt text='Thumbnails'}</option>
                    <option value="2">{gt text='List'}</option>
                </select>
            </div>

            {if $properties ne null && is_array($properties)}
                {gt text='All' assign='lblDefault'}
                {nocache}
                {foreach key='propertyName' item='propertyId' from=$properties}
                    <div class="z-formrow">
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
                        <label for="{$categorySelectorId}{$propertyName}">{$categoryLabel}</label>
                        {selector_category name="`$categorySelectorName``$propertyName`" field='id' selectedValue=$catIds.$propertyName categoryRegistryModule='SimpleMedia' categoryRegistryTable=$objectType categoryRegistryProperty=$propertyName defaultText=$lblDefault editLink=false multipleSize=$categorySelectorSize}
                        <div class="z-sub z-formnote">{gt text='This is an optional filter.'}</div>
                    </div>
                {/foreach}
                {/nocache}
            {/if}

            <div class="z-formrow">
                <label for="SimpleMedia_sort">{gt text='Sort by'}:</label>
                <select id="SimpleMedia_sort" name="sort" style="width: 150px" class="z-floatleft" style="margin-right: 10px">
                <option value="id"{if $sort eq 'id'} selected="selected"{/if}>{gt text='Id'}</option>
                <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
                <option value="theFile"{if $sort eq 'theFile'} selected="selected"{/if}>{gt text='The file'}</option>
                <option value="description"{if $sort eq 'description'} selected="selected"{/if}>{gt text='Description'}</option>
                {* <option value="additionalData"{if $sort eq 'additionalData'} selected="selected"{/if}>{gt text='Additional data'}</option> *}
                <option value="sortValue"{if $sort eq 'sortValue'} selected="selected"{/if}>{gt text='Sort value'}</option>
                <option value="mediaType"{if $sort eq 'mediaType'} selected="selected"{/if}>{gt text='Media type'}</option>
                <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                <option value="createdUserId"{if $sort eq 'createdUserId'} selected="selected"{/if}>{gt text='Creator'}</option>
                <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
                </select><br />
                <select id="SimpleMedia_sortdir" name="sortdir" style="width: 150px">
                    <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='Ascending'}</option>
                    <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='Descending'}</option>
                </select>
            </div>

            <div class="z-formrow">
                <label for="SimpleMedia_pagesize">{gt text='Page size'}:</label>
                <select id="SimpleMedia_pagesize" name="num" style="width: 50px; text-align: right">
                    <option value="5"{if $pager.itemsperpage eq 5} selected="selected"{/if}>5</option>
                    <option value="10"{if $pager.itemsperpage eq 10} selected="selected"{/if}>10</option>
                    <option value="15"{if $pager.itemsperpage eq 15} selected="selected"{/if}>15</option>
                    <option value="20"{if $pager.itemsperpage eq 20} selected="selected"{/if}>20</option>
                    <option value="30"{if $pager.itemsperpage eq 30} selected="selected"{/if}>30</option>
                    <option value="50"{if $pager.itemsperpage eq 50} selected="selected"{/if}>50</option>
                    <option value="100"{if $pager.itemsperpage eq 100} selected="selected"{/if}>100</option>
                </select>
            </div>

            <div class="z-formrow">
                <label for="SimpleMedia_searchterm">{gt text='Search for'}:</label>
                <input type="text" id="SimpleMedia_searchterm" name="searchterm" style="width: 150px" class="z-floatleft" style="margin-right: 10px" />
                <br /><br />
                <input type="button" id="SimpleMedia_gosearch" name="gosearch" value="{gt text='Filter'}" style="width: 80px" />
            </div>

    </div>
    
    <div class="z-w66  z-floatright">
            <div class="z-linear">
                <label for="SimpleMedia_objectid" style="width:15%"><strong>{gt text='Medium'}:</strong></label>
                <div id="simmeditemcontainer">
                    <ul>
                    {foreach item='medium' from=$objectData}
                        <li>
                            <a href="#" onclick="simplemedia.finder.selectItem({$medium.id})" onkeypress="simplemedia.finder.selectItem({$medium.id})">
                                {$medium.title}
                            </a>
                            <input type="hidden" id="url{$medium.id}" value="{modurl modname='SimpleMedia' type='user' func='display' ot='medium' id=$medium.id slug=$medium.slug fqurl=true}" />
                            <input type="hidden" id="title{$medium.id}" value="{$medium.title|replace:"\"":""}" />
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
                <strong>{gt text='Show'}:</strong>
                <label for="SimpleMedia_metaname">{gt text='Name'}</label>
                <input type="checkbox" id="SimpleMedia_metaname" name="SimpleMedia_metaname" checked value="Name" />
                <label for="SimpleMedia_metasize">{gt text='Size'}</label>
                <input type="checkbox" id="SimpleMedia_metasize" name="SimpleMedia_metasize" value="Size" />
                <label for="SimpleMedia_metadate">{gt text='Date'}</label>
                <input type="checkbox" id="SimpleMedia_metadate" name="SimpleMedia_metadate" value="Date" />
            </div>
            <div style="margin-left: 6em">
                {pager display='page' rowcount=$pager.numitems limit=$pager.itemsperpage posvar='pos' template='pagercss.tpl' maxpages='10'}
            </div>
    </div>
    <div class="z-clearfix">&nbsp;</div>
            <input type="submit" id="SimpleMedia_submit" name="submitButton" value="{gt text='Change selection'}" />
            <input type="button" id="SimpleMedia_cancel" name="cancelButton" value="{gt text='Cancel'}" />
        </fieldset>
    </div>
    </form>

    <script type="text/javascript">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            simplemedia.finder.onLoad();
        });
    /* ]]> */
    </script>

    {*
    <div class="simmedform">
        <fieldset>
            {modfunc modname='SimpleMedia' type='admin' func='edit'}
        </fieldset>
    </div>
    *}
</body>
</html>
