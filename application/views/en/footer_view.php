<!-- footer [ -->
<footer class="app-footer">


    <div class="app-footer-inner container">


        <!-- logo [ -->
        <div class="copy-info _iblock">
            © 2013 Енотус

            <p>
                Будем рады ответить на ваши
                вопросы: <a href="mailto:enotus@enotus.com.ua">enotus@enotus.com.ua</a>
            </p>
        </div>
        <!-- ] logo -->

        <div class="controlls _iblock">
            <nav class="second-nav _iblock">
                <ul class="second-nav-list">
                  {main_menu_items}
                    <li class="second-nav-item {position}"><a href="{sub_url}/{menu_item_link}">{menu_item_name}</a></li><?php //if ($current == 1) { echo " is-current"; } ?>
                  {/main_menu_items}
                </ul>
            </nav>
        </div>


   </div>


</footer>
<!-- ] footer --> 
