{* purpose of this template: media view csv view in admin area *}
{simplemediaTemplateHeaders contentType='text/comma-separated-values; charset=iso-8859-15' asAttachment=true filename='Media.csv'}
{strip}"{gt text='Title'}";"{gt text='The file'}";"{gt text='Description'}";"{gt text='Zipcode'}";"{gt text='Preview image'}";"{gt text='Sort value'}";"{gt text='Media type'}";"{gt text='Views count'}";"{gt text='Latitude'}";"{gt text='Longitude'}";"{gt text='Workflow state'}"
;"{gt text='Collection'}"
{/strip}
{foreach item='medium' from=$items}
{strip}
    "{$medium.title}";"{$medium.theFile}";"{$medium.description}";"{$medium.zipcode}";"{$medium.previewImage}";"{$medium.sortValue}";"{$medium.mediaType|simplemediaGetListEntry:'medium':'mediaType'|safetext}";"{$medium.viewsCount}";"{$medium.latitude|simplemediaFormatGeoData}";"{$medium.longitude|simplemediaFormatGeoData}";"{$item.workflowState|simplemediaObjectState:false|lower}"
    ;"{if isset($medium.Collection) && $medium.Collection ne null}{$medium.Collection->getTitleFromDisplayPattern()|default:''}{/if}"
{/strip}
{/foreach}
