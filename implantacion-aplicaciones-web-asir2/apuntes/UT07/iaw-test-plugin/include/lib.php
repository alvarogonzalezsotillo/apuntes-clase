<?php



function iaw_add_sys_info_to_admin_link(){

    add_menu_page(
         'Página del plugin', // Title of the page
         'Página informativa del plugin de disclaimer', // Text to show on the menu link
         'manage_options', // Capability requirement to see the link
         plugin_dir_path(__FILE__) . 'pagina-admin.php' // se añade a /wp-admin
    );

    add_options_page('IAW Custom Plugin Settings', 'IAW Custom Plugin', 'manage_options', 'iaw-custom-plugin', 'iaw_custom_plugin_options_page');
}


function iaw_add_disclaimer($content){
    if( !get_option("enabledisclaimer") ){
        return $content;
    }
    
    if ( is_single() || !get_option("enabledisclaimeronsinglepages") ) { 
 

        $content .= '<p class="iaw-disclaimer">
        Las opiniones de este post son exclusivamente de su autor
        </p>';
 
    }
    // Return the content
    return $content;     
}



function iaw_add_resources_to_page() {
    // ACABAN SIENDO LINKS EN EL HEADER
    wp_enqueue_style("iaw-custom-style", plugin_dir_url(__FILE__) . 'iaw-style.css');
}


function iaw_custom_dashboard_widget() {
    wp_add_dashboard_widget(
        'my_custom_widget', // Widget slug
        'Plugin de IAW', // Title
        'iaw_custom_widget_display' // Display function
    );
}

function iaw_custom_widget_display() {
    echo '<h3>Estado del plugin de <i>Disclaimer</i></h3>';
    if( get_option('enabledisclaimer') ){
        echo '<p>Activado</p>';
    }
    else{
        echo '<p>Desactivado</p>';
    }
    echo '<h3>Solo visible en entradas individuales</h3>';
    if( get_option('enabledisclaimeronsinglepages') ){
        echo '<p>Si</p>';
    }
    else{
        echo '<p>No</p>';
    }
}



function iaw_custom_plugin_settings() {
    // Register a new setting for the plugin
    register_setting('iaw_custom_plugin_options_group', 'enabledisclaimer');
    register_setting('iaw_custom_plugin_options_group', 'enabledisclaimeronsinglepages');
}



// Display the settings page
function iaw_custom_plugin_options_page() {
    ?>
    <div class="wrap">
        <h1>IAW Custom Plugin Settings</h1>
        <form method="post" action="options.php">
            <script>
            function iaw_update_single_page(check){
                console.log(check);
                document.getElementById("iaw_enabledisclaimeronsinglepages").disabled = !check.checked;
            }
            </script>
            <?php settings_fields('iaw_custom_plugin_options_group'); ?>
            <h2>Disclaimer Settings</h2>
            <table class="form-table">
                <tr valign="top">
                    <th scope="row">Enable Disclaimer</th>
                    <td>
                        <input type="checkbox" name="enabledisclaimer" value="1" <?php checked(1, get_option('enabledisclaimer'), true); ?> onclick="iaw_update_single_page(this)"/>
                        <label for="enabledisclaimer">Check to enable the disclaimer</label>
                    </td>
                    <th scope="row">Disclaimer only on single pages</th>
                    <td>
                        <input id="iaw_enabledisclaimeronsinglepages" type="checkbox" name="enabledisclaimeronsinglepages" value="1" <?php checked(1, get_option('enabledisclaimeronsinglepages'), true); ?>
                             <?= get_option('enabledisclaimer') ? "" : "disabled" ?> />
                        <label for="enabledisclaimeronsinglepages">Check to enable the disclaimer only on single pages</label>
                    </td>
                </tr>
            </table>
            <?php submit_button(); ?>
        </form>
    </div>
    <?php
}
