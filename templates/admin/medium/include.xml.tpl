{* purpose of this template: media xml inclusion template in admin area *}
<medium id="{$item.id}" createdon="{$item.createdDate|dateformat}" updatedon="{$item.updatedDate|dateformat}">
    <id>{$item.id}</id>
    <title><![CDATA[{$item.title}]]></title>
    <theFile{if $item.theFile ne ''} extension="{$item.theFileMeta.extension}" size="{$item.theFileMeta.size}" isImage="{if $item.theFileMeta.isImage}true{else}false{/if}"{if $item.theFileMeta.isImage} width="{$item.theFileMeta.width}" height="{$item.theFileMeta.height}" format="{$item.theFileMeta.format}"{/if}{/if}>{$item.theFile}</theFile>
    <description><![CDATA[{$item.description}]]></description>
    <mediaType>{$item.mediaType|simplemediaGetListEntry:'medium':'mediaType'|safetext}</mediaType>
    <zipcode><![CDATA[{$item.zipcode}]]></zipcode>
    <previewImage>{$item.previewImage}</previewImage>
    <viewsCount>{$item.viewsCount}</viewsCount>
    <sortValue>{$item.sortValue}</sortValue>
    <latitude>{$item.latitude|simplemediaFormatGeoData}</latitude>
    <longitude>{$item.longitude|simplemediaFormatGeoData}</longitude>
    <workflowState>{$item.workflowState|simplemediaObjectState:false|lower}</workflowState>
    <collection>{if isset($item.Collection) && $item.Collection ne null}{$item.Collection->getTitleFromDisplayPattern()|default:''}{/if}</collection>
</medium>
