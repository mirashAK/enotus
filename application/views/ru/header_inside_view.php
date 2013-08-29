<div class="controlls-addition _prel">
    <div class="lang-switcher">
        <a href="<? echo(sub_url('ru/'.uri_string(), false)); ?>" <? if (lang()=='ru') echo('class="is-current"'); ?>>РУ</a>
        <a href="<? echo(sub_url('uk/'.uri_string(), false)); ?>" <? if (lang()=='uk') echo('class="is-current"'); ?>>УКР</a>
        <a href="<? echo(sub_url('en/'.uri_string(), false)); ?>" <? if (lang()=='en') echo('class="is-current"'); ?>>EN</a>
    </div><!--<div class="lang-switcher">-->
    {user_controls_panel}
</div><!--<div class="controlls-addition _prel">-->
<nav class="main-nav _iblock">
    <ul class="main-nav-list">
      {main_menu_items}
        <li class="main-nav-item {position} {current}"><a href="{sub_url}/{menu_item_link}">{menu_item_name}</a></li>
      {/main_menu_items}
    </ul><!--<ul class="main-nav-list">-->
</nav>
