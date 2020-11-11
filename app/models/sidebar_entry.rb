class SidebarEntry
  class << self
    include Rails.application.routes.url_helpers
  end

  def self.all
    [
      {
        group_title: '',
        children: [
          {
            href: '#',
            title: 'Application Intel',
            icon: 'fa-info-circle',
            children: [
              {
                href: intel_intel_analytics_dashboard_path,
                title: 'Analytics Dashboard'
              },
              {
                href: intel_intel_marketing_dashboard_path,
                title: 'Marketing Dashboard'
              },
              {
                href: intel_intel_introduction_path,
                title: 'Introduction'
              },
              {
                href: intel_intel_privacy_path,
                title: 'Privacy'
              },
              {
                href: intel_intel_build_notes_path,
                title: 'Build Notes',
                subtitle: "v#{Rails.configuration.version}"
              }
            ]
          },
          {
            href: '#',
            title: 'Theme Settings',
            icon: 'fa-cog',
            children: [
              {
                href: settings_settings_how_it_works_path,
                title: 'How it works'
              },
              {
                href: settings_settings_layout_options_path,
                title: 'Layout Options'
              },
              {
                href: settings_settings_skin_options_path,
                title: 'Skin Options'
              },
              {
                href: settings_settings_saving_db_path,
                title: 'Saving to Database'
              }
            ]
          },
          {
            href: '#',
            title: 'Package Info',
            icon: 'fa-tag',
            children: [
              {
                href: info_info_app_docs_path,
                title: 'Documentation'
              },
              {
                href: info_info_app_licensing_path,
                title: 'Product Licensing'
              },
              {
                href: info_info_app_flavors_path,
                title: 'Different Flavors'
              }
            ]
          }
        ]
      },
      {
        group_title: 'Tools & Components',
        children: [
          {
            href: '#',
            title: 'UI Components',
            icon: 'fa-window',
            children: [
              {
                href: ui_ui_alerts_path,
                title: 'Alerts'
              },
              {
                href: ui_ui_accordion_path,
                title: 'Accordions'
              },
              {
                href: ui_ui_badges_path,
                title: 'Badges'
              },
              {
                href: ui_ui_breadcrumbs_path,
                title: 'Breadcrumbs'
              },
              {
                href: ui_ui_buttons_path,
                title: 'Buttons'
              },
              {
                href: ui_ui_button_group_path,
                title: 'Button Group'
              },
              {
                href: ui_ui_cards_path,
                title: 'Cards'
              },
              {
                href: ui_ui_carousel_path,
                title: 'Carousel'
              },
              {
                href: ui_ui_collapse_path,
                title: 'Collapse'
              },
              {
                href: ui_ui_dropdowns_path,
                title: 'Dropdowns'
              },
              {
                href: ui_ui_list_filter_path,
                title: 'List Filter'
              },
              {
                href: ui_ui_modal_path,
                title: 'Modal'
              },
              {
                href: ui_ui_navbars_path,
                title: 'Navbars'
              },
              {
                href: ui_ui_panels_path,
                title: 'Panels'
              },
              {
                href: ui_ui_pagination_path,
                title: 'Pagination'
              },
              {
                href: ui_ui_popovers_path,
                title: 'Popovers'
              },
              {
                href: ui_ui_progress_bars_path,
                title: 'Progress Bars'
              },
              {
                href: ui_ui_scrollspy_path,
                title: 'ScrollSpy'
              },
              {
                href: ui_ui_side_panel_path,
                title: 'Side Panel'
              },
              {
                href: ui_ui_spinners_path,
                title: 'Spinners'
              },
              {
                href: ui_ui_tabs_pills_path,
                title: 'Tabs & Pills'
              },
              {
                href: ui_ui_toasts_path,
                title: 'Toasts'
              },
              {
                href: ui_ui_tooltips_path,
                title: 'Tooltips'
              }
            ]
          },
          {
            href: '#',
            title: 'Utilities',
            icon: 'fa-bolt',
            children: [
              {
                href: utilities_utilities_borders_path,
                title: 'Borders'
              },
              {
                href: utilities_utilities_clearfix_path,
                title: 'Clearfix'
              },
              {
                href: utilities_utilities_color_pallet_path,
                title: 'Color Pallet'
              },
              {
                href: utilities_utilities_display_property_path,
                title: 'Display Property'
              },
              {
                href: utilities_utilities_fonts_path,
                title: 'Fonts'
              },
              {
                href: utilities_utilities_flexbox_path,
                title: 'Flexbox'
              },
              {
                href: utilities_utilities_helpers_path,
                title: 'Helpers'
              },
              {
                href: utilities_utilities_position_path,
                title: 'Position'
              },
              {
                href: utilities_utilities_responsive_grid_path,
                title: 'Responsive Grid'
              },
              {
                href: utilities_utilities_sizing_path,
                title: 'Sizing'
              },
              {
                href: utilities_utilities_spacing_path,
                title: 'Spacing'
              },
              {
                href: utilities_utilities_typography_path,
                title: 'Typography',
                tags: 'fonts headings bold lead colors sizes link text states list styles truncate alignment'
              },
              {
                href: 'javascript:void(0);',
                title: 'Menu child',
                children: [
                  {
                    href: 'javascript:void(0);',
                    title: 'Sublevel Item'
                  },
                  {
                    href: 'javascript:void(0);',
                    title: 'Another Item'
                  }
                ]
              },
              {
                href: 'javascript:void(0);',
                title: 'Disabled item',
                disabled: true
              }
            ]
          },
          {
            href: '#',
            title: 'Font Icons',
            subtitle: '2,500+',
            subtitle_class: 'dl-ref bg-primary-500 hidden-nav-function-minify hidden-nav-function-top',
            icon: 'fa-map-marker-alt',
            children: [
              {
                href: 'javascript:void(0);',
                title: 'FontAwesome Pro',
                children: [
                  {
                    href: icons_icons_fontawesome_light_path,
                    title: 'Light'
                  },
                  {
                    href: icons_icons_fontawesome_regular_path,
                    title: 'Regular'
                  },
                  {
                    href: icons_icons_fontawesome_solid_path,
                    title: 'Solid'
                  },
                  {
                    href: icons_icons_fontawesome_brand_path,
                    title: 'Brand'
                  }
                ]
              },
              {
                href: 'javascript:void(0);',
                title: 'NextGen Icons',
                children: [
                  {
                    href: icons_icons_nextgen_general_path,
                    title: 'General'
                  },
                  {
                    href: icons_icons_nextgen_base_path,
                    title: 'Base'
                  }
                ]
              },
              {
                href: 'javascript:void(0);',
                title: 'Stack Icons',
                children: [
                  {
                    href: icons_icons_stack_showcase_path,
                    title: 'Showcase'
                  },
                  {
                    href: icons_icons_stack_generate_path,
                    title: 'Generate Stack'
                  }
                ]
              }
            ]
          },
          {
            href: '#',
            title: 'Tables',
            icon: 'fa-th-list',
            children: [
              {
                href: tables_tables_basic_path,
                title: 'Basic Tables'
              },
              {
                href: tables_tables_generate_style_path,
                title: 'Generate Table Style'
              }
            ]
          },
          {
            href: '#',
            title: 'Form Stuff',
            icon: 'fa-edit',
            children: [
              {
                href: form_form_basic_inputs_path,
                title: 'Basic Inputs'
              },
              {
                href: form_form_checkbox_radio_path,
                title: 'Checkbox & Radio'
              },
              {
                href: form_form_input_groups_path,
                title: 'Input Groups'
              },
              {
                href: form_form_validation_path,
                title: 'Validation'
              }
            ]
          }
        ]
      },
      {
        group_title: 'Plugins & Addons',
        children: [
          {
            href: '#',
            title: 'Core Plugins',
            icon: 'fa-shield-alt',
            children: [
              {
                href: plugins_plugin_faq_path,
                title: 'Plugins FAQ'
              },
              {
                href: plugins_plugin_waves_path,
                title: 'Waves',
                subtitle: '9 KB',
                subtitle_class: 'dl-ref label bg-primary-400 ml-2'
              },
              {
                href: plugins_plugin_pacejs_path,
                title: 'PaceJS',
                subtitle: '13 KB',
                subtitle_class: 'dl-ref label bg-primary-500 ml-2'
              },
              {
                href: plugins_plugin_smartpanels_path,
                title: 'SmartPanels',
                subtitle: '9 KB',
                subtitle_class: 'dl-ref label bg-primary-600 ml-2'
              },
              {
                href: plugins_plugin_bootbox_path,
                title: 'BootBox',
                subtitle: '15 KB',
                subtitle_class: 'dl-ref label bg-primary-600 ml-2',
                tags: 'alert sound'
              },
              {
                href: plugins_plugin_slimscroll_path,
                title: 'Slimscroll',
                subtitle: '5 KB',
                subtitle_class: 'dl-ref label bg-primary-700 ml-2'
              },
              {
                href: plugins_plugin_throttle_path,
                title: 'Throttle',
                subtitle: '1 KB',
                subtitle_class: 'dl-ref label bg-primary-700 ml-2'
              },
              {
                href: plugins_plugin_navigation_path,
                title: 'Navigation',
                subtitle: '2 KB',
                subtitle_class: 'dl-ref label bg-primary-700 ml-2'
              },
              {
                href: plugins_plugin_i18next_path,
                title: 'i18next',
                subtitle: '10 KB',
                subtitle_class: 'dl-ref label bg-primary-700 ml-2'
              },
              {
                href: plugins_plugin_appcore_path,
                title: 'App.Core',
                subtitle: '14 KB',
                subtitle_class: 'dl-ref label bg-success-700 ml-2'
              }
            ]
          },
          {
            href: '#',
            title: 'Datatables',
            icon: 'fa-table',
            subtitle: '235 KB',
            subtitle_class: 'dl-ref bg-primary-500 hidden-nav-function-minify hidden-nav-function-top',
            tags: 'datagrid',
            children: [
              {
                href: datatables_datatables_basic_path,
                title: 'Basic'
              },
              {
                href: datatables_datatables_autofill_path,
                title: 'Autofill'
              },
              {
                href: datatables_datatables_buttons_path,
                title: 'Buttons'
              },
              {
                href: datatables_datatables_export_path,
                title: 'Export',
                tags: 'tables pdf excel print csv'
              },
              {
                href: datatables_datatables_colreorder_path,
                title: 'ColReorder'
              },
              {
                href: datatables_datatables_columnfilter_path,
                title: 'ColumnFilter'
              },
              {
                href: datatables_datatables_fixedcolumns_path,
                title: 'FixedColumns'
              },
              {
                href: datatables_datatables_fixedheader_path,
                title: 'FixedHeader'
              },
              {
                href: datatables_datatables_keytable_path,
                title: 'KeyTable'
              },
              {
                href: datatables_datatables_responsive_path,
                title: 'Responsive'
              },
              {
                href: datatables_datatables_responsive_alt_path,
                title: 'Responsive Alt'
              },
              {
                href: datatables_datatables_rowgroup_path,
                title: 'RowGroup'
              },
              {
                href: datatables_datatables_rowreorder_path,
                title: 'RowReorder'
              },
              {
                href: datatables_datatables_scroller_path,
                title: 'Scroller'
              },
              {
                href: datatables_datatables_select_path,
                title: 'Select'
              },
              {
                href: datatables_datatables_alteditor_path,
                title: 'AltEditor'
              }
            ]
          },
          {
            href: '#',
            title: 'Statistics',
            icon: 'fa-chart-pie',
            tags: 'chart graphs',
            children: [
              {
                href: statistics_statistics_flot_path,
                title: 'Flot',
                subtitle: '36 KB',
                subtitle_class: 'dl-ref label bg-primary-500 ml-2',
                tags: 'bar pie'
              },
              {
                href: statistics_statistics_chartjs_path,
                title: 'Chart.js',
                subtitle: '205 KB',
                subtitle_class: 'dl-ref label bg-primary-500 ml-2',
                tags: 'bar pie'
              },
              {
                href: statistics_statistics_chartist_path,
                title: 'Chartist.js',
                subtitle: '39 KB',
                subtitle_class: 'dl-ref label bg-primary-600 ml-2'
              },
              {
                href: statistics_statistics_c3_path,
                title: 'C3 Charts',
                subtitle: '197 KB',
                subtitle_class: 'dl-ref label bg-primary-600 ml-2'
              },
              {
                href: statistics_statistics_peity_path,
                title: 'Peity',
                subtitle: '4 KB',
                subtitle_class: 'dl-ref label bg-primary-700 ml-2',
                tags: 'small'
              },
              {
                href: statistics_statistics_sparkline_path,
                title: 'Sparkline',
                subtitle: '42 KB',
                subtitle_class: 'dl-ref label bg-primary-500 ml-2',
                tags: 'small tiny'
              },
              {
                href: statistics_statistics_easypiechart_path,
                title: 'Easy Pie Chart',
                subtitle: '4 KB',
                subtitle_class: 'dl-ref label bg-primary-500 ml-2'
              },
              {
                href: statistics_statistics_dygraph_path,
                title: 'Dygraph',
                subtitle: '120 KB',
                subtitle_class: 'dl-ref label bg-primary-500 ml-2',
                tags: 'complex'
              },
            ]
          },
          {
            href: '#',
            title: 'Notifications',
            icon: 'fa-exclamation-circle',
            children: [
              {
                href: notifications_notifications_sweetalert2_path,
                title: 'SweetAlert2',
                subtitle: '40 KB',
                subtitle_class: 'dl-ref label bg-primary-500 ml-2'
              },
              {
                href: notifications_notifications_toastr_path,
                title: 'Toastr',
                subtitle: '5 KB',
                subtitle_class: 'dl-ref label bg-primary-600 ml-2'
              }
            ]
          },
          {
            href: '#',
            title: 'Form Plugins',
            icon: 'fa-credit-card-front',
            children: [
              {
                href: form_plugins_form_plugins_colorpicker_path,
                title: 'Color Picker'
              },
              {
                href: form_plugins_form_plugins_datepicker_path,
                title: 'Date Picker'
              },
              {
                href: form_plugins_form_plugins_daterange_picker_path,
                title: 'Date Range Picker'
              },
              {
                href: form_plugins_form_plugins_dropzone_path,
                title: 'Dropzone'
              },
              {
                href: form_plugins_form_plugins_ionrangeslider_path,
                title: 'Ion.RangeSlider'
              },
              {
                href: form_plugins_form_plugins_inputmask_path,
                title: 'Inputmask'
              },
              {
                href: form_plugins_form_plugin_imagecropper_path,
                title: 'Image Cropper'
              },
              {
                href: form_plugins_form_plugin_select2_path,
                title: 'Select2'
              },
              {
                href: form_plugins_form_plugin_summernote_path,
                title: 'Summernote',
                tags: 'texteditor editor'
              }
            ]
          },
          {
            href: '#',
            title: 'Miscellaneous',
            icon: 'fa-globe',
            children: [
              {
                href: miscellaneous_miscellaneous_fullcalendar_path,
                title: 'FullCalendar'
              },
              {
                href: miscellaneous_miscellaneous_lightgallery_path,
                title: 'Light Gallery',
                subtitle: '61 KB',
                subtitle_class: 'dl-ref label bg-primary-500 ml-2'
              }
            ]
          }
        ]
      },
      {
        group_title: 'Layouts & Apps',
        children: [
          {
            href: '#',
            title: 'Page Views',
            icon: 'fa-plus-circle',
            children: [
              {
                href: pages_page_chat_path,
                title: 'Chat'
              },
              {
                href: pages_page_contacts_path,
                title: 'Contacts'
              },
              {
                href: pages_page_faq_path,
                title: 'FAQ'
              },
              {
                href: 'javascript:void(0);',
                title: 'Forum',
                children: [
                  {
                    href: pages_page_forum_list_path,
                    title: 'List'
                  },
                  {
                    href: pages_page_forum_threads_path,
                    title: 'Threads'
                  },
                  {
                    href: pages_page_forum_discussion_path,
                    title: 'Discussion'
                  },
                ]
              },
              {
                href: 'javascript:void(0);',
                title: 'Inbox',
                children: [
                  {
                    href: pages_page_inbox_general_path,
                    title: 'General'
                  },
                  {
                    href: pages_page_inbox_read_path,
                    title: 'Read'
                  },
                  {
                    href: pages_page_inbox_write_path,
                    title: 'Write'
                  },
                ]
              },
              {
                href: pages_page_invoice_path,
                title: 'Invoice (printable)'
              },
              {
                href: 'javascript:void(0);',
                title: 'Authentication',
                children: [
                  {
                    href: pages_page_forget_path,
                    title: 'Forget Password'
                  },
                  {
                    href: pages_page_locked_path,
                    title: 'Locked Screen'
                  },
                  {
                    href: pages_page_login_path,
                    title: 'Login'
                  },
                  {
                    href: pages_page_login_alt_path,
                    title: 'Login Alt'
                  },
                  {
                    href: pages_page_register_path,
                    title: 'Register'
                  },
                  {
                    href: pages_page_confirmation_path,
                    title: 'Confirmation'
                  }
                ]
              },
              {
                href: 'javascript:void(0);',
                title: 'Error Pages',
                children: [
                  {
                    href: pages_page_error_path,
                    title: 'General Error'
                  },
                  {
                    href: pages_page_error_404_path,
                    title: 'Server Error'
                  },
                  {
                    href: pages_page_error_announced_path,
                    title: 'Announced Error'
                  }
                ]
              },
              {
                href: pages_page_profile_path,
                title: 'Profile'
              },
              {
                href: pages_page_search_path,
                title: 'Search Results'
              }
            ]
          }
        ]
      }
    ]
  end
end