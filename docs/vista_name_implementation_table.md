# Vista + Vista Graphics Name/Implementation Table

| name | implementation |
|---|---|
| `resolve_icon_src` | `src/vista/modules/01-faces.art:7`; resolves icon shorthand like `log-in` |
| `icon_svg_source_path` | `src/vista/modules/01-faces.art:29` |
| `icon_svg_markup` | `src/vista/modules/01-faces.art:47` |
| `icon_uses_current_color?` | `src/vista/modules/01-faces.art:61` |
| `button` | `src/vista/modules/01-faces.art:72`; supports .icon via `image_face` + bundled icons |
| `key_button` | `src/vista/modules/01-faces.art:104` |
| `text` | `src/vista/modules/01-faces.art:132` |
| `semantic_text_tag` | `src/vista/modules/01-faces.art:137` |
| `bound_text_face` | `src/vista/modules/01-faces.art:146` |
| `text_face` | `src/vista/modules/01-faces.art:165` |
| `title` | `src/vista/modules/01-faces.art:180` |
| `subtitle` | `src/vista/modules/01-faces.art:196` |
| `field` | `src/vista/modules/01-faces.art:212` |
| `label_text_with_suffix` | `src/vista/modules/01-faces.art:216` |
| `label` | `src/vista/modules/01-faces.art:221` |
| `label_face` | `src/vista/modules/01-faces.art:226` |
| `box` | `src/vista/modules/01-faces.art:241` |
| `panel_face` | `src/vista/modules/01-faces.art:247` |
| `summary_face` | `src/vista/modules/01-faces.art:258` |
| `details_face` | `src/vista/modules/01-faces.art:271` |
| `dialog_face` | `src/vista/modules/01-faces.art:287` |
| `template_face` | `src/vista/modules/01-faces.art:306` |
| `grid_face` | `src/vista/modules/01-faces.art:312` |
| `spacer_face` | `src/vista/modules/01-faces.art:322` |
| `table_face` | `src/vista/modules/01-faces.art:327` |
| `table_row_face` | `src/vista/modules/01-faces.art:333` |
| `table_cell_face` | `src/vista/modules/01-faces.art:343` |
| `table_head_face` | `src/vista/modules/01-faces.art:353` |
| `table_body_face` | `src/vista/modules/01-faces.art:359` |
| `table_foot_face` | `src/vista/modules/01-faces.art:365` |
| `table_header_cell_face` | `src/vista/modules/01-faces.art:371` |
| `toolbar_face` | `src/vista/modules/01-faces.art:377` |
| `menubar_face` | `src/vista/modules/01-faces.art:383` |
| `tool_group_face` | `src/vista/modules/01-faces.art:389` |
| `script_face` | `src/vista/modules/01-faces.art:395` |
| `canvas_face` | `src/vista/modules/01-faces.art:404` |
| `canvas_draw_script` | `src/vista/modules/01-faces.art:410` |
| `divider_face` | `src/vista/modules/01-faces.art:432` |
| `split_face` | `src/vista/modules/01-faces.art:438` |
| `text_list` | `src/vista/modules/01-faces.art:459` |
| `text_list_bind` | `src/vista/modules/01-faces.art:485` |
| `list_face_bind` | `src/vista/modules/01-faces.art:511` |
| `row` | `src/vista/modules/01-faces.art:544` |
| `col` | `src/vista/modules/01-faces.art:550` |
| `group` | `src/vista/modules/01-faces.art:556` |
| `sensor_face` | `src/vista/modules/01-faces.art:561` |
| `form` | `src/vista/modules/01-faces.art:583` |
| `checkbox` | `src/vista/modules/01-faces.art:596` |
| `toggle` | `src/vista/modules/01-faces.art:616` |
| `input_field` | `src/vista/modules/01-faces.art:637` |
| `slider_field` | `src/vista/modules/01-faces.art:650` |
| `rotary_field` | `src/vista/modules/01-faces.art:663` |
| `textarea_field` | `src/vista/modules/01-faces.art:676` |
| `select_field` | `src/vista/modules/01-faces.art:685` |
| `radio_group` | `src/vista/modules/01-faces.art:715` |
| `image_face` | `src/vista/modules/01-faces.art:796`; renders inline SVG for `vista-button-icon` to follow text color |
| `audio_face` | `src/vista/modules/01-faces.art:809` |
| `video_face` | `src/vista/modules/01-faces.art:822` |
| `progress_face` | `src/vista/modules/01-faces.art:835` |
| `auth_splash` | `src/vista/modules/06-auth-ui.art:3` |
| `auth_login` | `src/vista/modules/06-auth-ui.art:12`; uses iconized buttons (e.g., `log-in`, `user-plus`, `shield-check`) |
| `auth_signup` | `src/vista/modules/06-auth-ui.art:32`; uses iconized buttons (e.g., `log-in`, `user-plus`, `shield-check`) |
| `auth_account` | `src/vista/modules/06-auth-ui.art:48`; uses iconized buttons (e.g., `log-in`, `user-plus`, `shield-check`) |
| `auth_app` | `src/vista/modules/06-auth-ui.art:80`; uses iconized buttons (e.g., `log-in`, `user-plus`, `shield-check`) |
| `auth-splash` | `src/vista/modules/06-auth-ui.art:141` |
| `auth-login` | `src/vista/modules/06-auth-ui.art:142` |
| `auth-signup` | `src/vista/modules/06-auth-ui.art:143` |
| `auth-account` | `src/vista/modules/06-auth-ui.art:144` |
| `auth-app` | `src/vista/modules/06-auth-ui.art:145` |
| `vg_normalize_block` | `src/vista/graphics/parsing.art:5` |
| `vg_js_escape_single` | `src/vista/graphics/utils.art:4` |
| `draw_js_token` | `src/vista/graphics/utils.art:12` |
| `vg_point` | `src/vista/graphics/utils.art:31` |
| `vg_color_value` | `src/vista/graphics/colors.art:157` |
| `draw_gradient_stops` | `src/vista/graphics/drawing.art:3` |
| `draw_matrix_values` | `src/vista/graphics/drawing.art:24` |
| `draw_to_canvas` | `src/vista/graphics/drawing.art:41`; graphics rendering API (no face-level icon system) |
| `draw` | `src/vista/graphics/drawing.art:693` |
| `svg_escape_attr` | `src/vista/graphics/drawing.art:698` |
| `svg_color_value` | `src/vista/graphics/drawing.art:708` |
| `svg_state_copy` | `src/vista/graphics/drawing.art:735` |
| `svg_shape_attrs` | `src/vista/graphics/drawing.art:747` |
| `svg_points_attr` | `src/vista/graphics/drawing.art:767` |
| `draw_to_svg` | `src/vista/graphics/drawing.art:784`; graphics rendering API (no face-level icon system) |
| `draw_svg` | `src/vista/graphics/drawing.art:1161`; graphics rendering API (no face-level icon system) |
| `draw_preload_list_js` | `src/vista/graphics/drawing.art:1165` |
| `draw_script` | `src/vista/graphics/drawing.art:1195` |
| `draw_script_preload` | `src/vista/graphics/drawing.art:1203` |
| `chart_min` | `src/vista/graphics/charts.art:17` |
| `chart_default_palette` | `src/vista/graphics/charts.art:22` |
| `chart_default_opts` | `src/vista/graphics/charts.art:34` |
| `chart_opts` | `src/vista/graphics/charts.art:62` |
| `chart_palette` | `src/vista/graphics/charts.art:77` |
| `chart_plot_rect` | `src/vista/graphics/charts.art:84` |
| `chart_min_max_values` | `src/vista/graphics/charts.art:98` |
| `chart_min_max_points` | `src/vista/graphics/charts.art:119` |
| `chart_scale_y` | `src/vista/graphics/charts.art:151` |
| `chart_scale_x` | `src/vista/graphics/charts.art:157` |
| `chart_grid_draw` | `src/vista/graphics/charts.art:163` |
| `chart_axes_draw` | `src/vista/graphics/charts.art:182` |
| `chart_text` | `src/vista/graphics/charts.art:193` |
| `chart_format_value` | `src/vista/graphics/charts.art:204` |
| `chart_axes_labels_numeric` | `src/vista/graphics/charts.art:208` |
| `chart_line` | `src/vista/graphics/charts.art:227` |
| `chart_area` | `src/vista/graphics/charts.art:290` |
| `chart_bar` | `src/vista/graphics/charts.art:363` |
| `chart_stacked_bar` | `src/vista/graphics/charts.art:423` |
| `chart_inc_count` | `src/vista/graphics/charts.art:504` |
| `chart_histogram` | `src/vista/graphics/charts.art:517` |
| `chart_scatter` | `src/vista/graphics/charts.art:552` |
| `chart_funnel` | `src/vista/graphics/charts.art:579` |
| `chart_donut` | `src/vista/graphics/charts.art:636` |
| `chart_index_of` | `src/vista/graphics/charts.art:683` |
| `chart_heatmap_palette` | `src/vista/graphics/charts.art:695` |
| `chart_heatmap` | `src/vista/graphics/charts.art:702` |
| `chart_cohort` | `src/vista/graphics/charts.art:780` |
