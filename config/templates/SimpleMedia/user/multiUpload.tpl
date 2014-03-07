{* purpose of this template: show output of multi upload action in user area *}
{include file='user/header.tpl'}

{pageaddvar name='javascript' value='jQuery'}
{pageaddvar name='javascript' value='prototype'}

<div class="simplemedia-multiupload simplemedia-multiupload">
    {gt text='Multi upload' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    <p>Please override this template by moving it from <em>/modules/SimpleMedia/templates/user/multiUpload.tpl</em> to either your <em>/themes/YourTheme/templates/modules/SimpleMedia/user/multiUpload.tpl</em> or <em>/config/templates/SimpleMedia/user/multiUpload.tpl</em>.</p>



</div>
{include file='user/footer.tpl'}
