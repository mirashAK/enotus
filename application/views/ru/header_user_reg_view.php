<div class="user-link-wrap _fright">
    <a class="user-link" href="#user-dropdown">{user_public:u_name}</a>&nbsp;
</div>
<div class="user-block tariff-ok">
    <div class="user-block-head">
        Здравствуйте, <a class="user-link-block" href="#user-dropdown">{user_public:u_name}</a>&nbsp;<i class="user-block-arrow"></i>
    </div>


    <div class="user-block-subhead">
        Новый месяц начинается через <i>7 дней</i>, не забудьте <a href="#">внести абонплату</a>.
    </div>


    <ul class="user-block-options">
      {user_menu_items}
        <li class="{position} {current}"><a href="{sub_url}/{menu_item_link}">{menu_item_name}</a></li>
      {/user_menu_items}
        <li class="-extra"><a href="{sub_url}/auth/logout">Выход</a></li>
    </ul>
</div>
