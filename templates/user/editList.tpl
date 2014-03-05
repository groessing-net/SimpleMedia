{* purpose of this template: show output of edit list action in user area *}
{include file='user/header.tpl'}
<div class="simplemedia-editlist simplemedia-editlist">
    {gt text='Edit list' assign='templateTitle'}
    {pagesetvar name='title' value=$templateTitle}
    <h2>{$templateTitle}</h2>

    <p>Please override this template by moving it from <em>/modules/SimpleMedia/templates/user/editList.tpl</em> to either your <em>/themes/YourTheme/templates/modules/SimpleMedia/user/editList.tpl</em> or <em>/config/templates/SimpleMedia/user/editList.tpl</em>.</p>
</div>
{include file='user/footer.tpl'}
