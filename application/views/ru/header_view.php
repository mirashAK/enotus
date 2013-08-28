<!-- application header [ -->
<header class="app-header container">


    <div class="app-header-inner">


        <!-- logo [ -->
        <div class="logo-wrap _iblock">
            <a href="{sub_url}" title="Енотус - Ваш деловой помошник" class="logo _unone _cfix">
                <img src="{res_img}/enotus-logo.png" width="59" height="60">
                <div class="logo-text _iblock">
                    Eнотус
                </div>
                <span class="tagline _iblock">
                    Ваш деловой помощник.
                </span>
            </a>

        </div>
        <!-- ] logo -->

        <div class="controlls _iblock">


            <?php if (!$link_out) { ?>
            <div class="controlls-addition _prel">
                <div class="lang-switcher">
                    <a href="<?php echo(sub_url('ru/'.uri_string(), false)); ?>" <?php if (lang()=='ru') echo('class="is-current"'); ?>>РУ</a>
                    <a href="<?php echo(sub_url('uk/'.uri_string(), false)); ?>" <?php if (lang()=='uk') echo('class="is-current"'); ?>>УКР</a>
                    <a href="<?php echo(sub_url('en/'.uri_string(), false)); ?>" <?php if (lang()=='en') echo('class="is-current"'); ?>>EN</a>
                </div>


                <!-- registration/autorization [ -->
                <?php if ($auth) { ?>


                <div class="user-link-wrap _fright">
                    <a class="user-link" href="#user-dropdown">possumwood</a>
                </div>
                <div class="user-block <?php if ($tariff === 'ok') echo 'tariff-ok'; ?>">
                    <div class="user-block-head">
                        Здравствуйте, <a class="user-link-block" href="#user-dropdown">possumwood</a><i class="user-block-arrow"></i>
                    </div>


                    <div class="user-block-subhead">
                        Новый месяц начинается через <i>7 дней</i>, не забудьте <a href="#">внести абонплату</a>.
                    </div>


                    <ul class="user-block-options">
                        <li><a href="#">Журнал</a></li>
                        <li class="<?php if ($tariff === 'ok') echo 'is-current'; ?>"><a href="#">Тарифный пакет</a></li>
                        <li><a href="#">История оплат</a></li>
                        <li><a href="#">Настройки</a></li>
                        <li class="-extra"><a href="#">Выход</a></li>
                    </ul>
                </div>


                <?php } else { ?>


                <a href="#modal-registration" data-toggle="modal" class="link-registration -dotted">Зарегистрироваться</a>

                <a href="#modal-login" data-toggle="modal" class="btn -special link-login _fright">
                    Войти
                    <i class="icon icon-access"></i>
                </a>


                <?php }; ?>
                <!-- ] registration/autorization -->


            </div>


            <nav class="main-nav _iblock"><!---item-1-->
                <ul class="main-nav-list">
                  {main_menu_items}
                    <li class="main-nav-item {position} {current}"><a href="{sub_url}/{menu_item_link}">{menu_item_name}</a></li>
                  {/main_menu_items}
                </ul>
            </nav>

            <?php } else { ?>
            <div class="link-out-info">
                Вам пришла ссылка на документ с сайта <span class="logo-text"><i>Е</i>нотус</span>, сервиса позволяющего создавать документы онлайн. После того, как ознакомитесь с пришедшим вам документом, вы сможете <a href="#">перейти на главную</a>, чтобы больше узнать о <span class="logo-text"><i>Е</i>нотусе</span>.
            </div>
            <?php }; ?>
        </div>
    </div>


</header>
<!-- ] application header --> 
