<?php



/*
Plugin Name:  Test de plugin de IAW
Plugin URI:   https://coder.iesavellaneda.es
Description:  Por algo hay que empezar, este es un test simple
Version:      1.0
Author:       Álvaro González Sotillo
Author URI:   https://coder.iesavellaneda.es
License:      CC
*/

require_once plugin_dir_path(__FILE__) . 'include/lib.php';


add_action( 'admin_menu', 'iaw_add_sys_info_to_admin_link' );
add_action('wp_enqueue_scripts', 'iaw_add_resources_to_page');
add_filter('the_content', 'iaw_add_disclaimer');
add_action('wp_dashboard_setup', 'iaw_custom_dashboard_widget');


add_action('admin_init', 'iaw_custom_plugin_settings');

