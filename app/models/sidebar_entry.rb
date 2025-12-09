class SidebarEntry
  class << self
    include Rails.application.routes.url_helpers
  end

  def self.all
    [
      # {
      #   group_title: '',
      #   children: [
      #     {
      #       href: '#',
      #       title: 'Application Intel',
      #       icon: 'fa-info-circle',
      #       children: [
      #         {
      #           href: intel_intel_analytics_dashboard_path,
      #           title: 'Analytics Dashboard'
      #         }
      #       ]
      #     }
      #   ]
      # },
      # 用戶管理分組
      {
        group_title: '用戶管理',
        children: [
          {
            href: '#',
            title: 'Shopline 客戶',
            icon: 'fa-users',
            children: [
              {
                href: admin_shopline_customers_path(membership_level: "黑卡"),
                title: '客戶列表'
              },
              {
                href: new_admin_shopline_import_path,
                title: '匯入客戶資料',
                subtitle: 'Excel',
                subtitle_class: 'dl-ref label bg-success-500 ml-2'
              }
            ]
          }
        ]
      },
      # 訂單管理作為獨立分組
      {
        group_title: '訂單管理',
        children: [
          {
            href: '#',
            title: 'Shopline 訂單',
            icon: 'fa-shopping-cart',
            children: [
              {
                href: admin_shopline_orders_path,
                title: '訂單列表'
              },
              {
                href: new_admin_shopline_order_import_path,
                title: '匯入訂單資料',
                subtitle: 'Excel',
                subtitle_class: 'dl-ref label bg-success-500 ml-2'
              }
            ]
          }
        ]
      }
      # {
      #   group_title: 'Plugins & Addons',
      #   children: [
      #     {
      #       href: '#',
      #       title: 'Notifications',
      #       icon: 'fa-exclamation-circle',
      #       children: [
      #         {
      #           href: notifications_notifications_sweetalert2_path,
      #           title: 'SweetAlert2',
      #           subtitle: '40 KB',
      #           subtitle_class: 'dl-ref label bg-primary-500 ml-2'
      #         }
      #       ]
      #     },
      #     {
      #       href: '#',
      #       title: 'Form Plugins',
      #       icon: 'fa-credit-card-front',
      #       children: [
      #         {
      #           href: form_plugins_form_plugins_datepicker_path,
      #           title: 'Date Picker'
      #         },
      #         {
      #           href: form_plugins_form_plugins_daterange_picker_path,
      #           title: 'Date Range Picker'
      #         },
      #         {
      #           href: form_plugins_form_plugin_summernote_path,
      #           title: 'Summernote',
      #           tags: 'texteditor editor'
      #         }
      #       ]
      #     },
      #     {
      #       href: '#',
      #       title: 'Miscellaneous',
      #       icon: 'fa-globe',
      #       children: [
      #         {
      #           href: miscellaneous_miscellaneous_fullcalendar_path,
      #           title: 'FullCalendar'
      #         }
      #       ]
      #     }
      #   ]
      # },
      # {
      #   group_title: 'Layouts & Apps',
      #   children: [
      #     {
      #       href: '#',
      #       title: 'Page Views',
      #       icon: 'fa-plus-circle',
      #       children: [
      #         {
      #           href: 'javascript:void(0);',
      #           title: 'Authentication',
      #           children: [
      #             {
      #               href: pages_page_forget_path,
      #               title: 'Forget Password'
      #             },
      #             {
      #               href: pages_page_locked_path,
      #               title: 'Locked Screen'
      #             },
      #             {
      #               href: pages_page_login_path,
      #               title: 'Login'
      #             },
      #             {
      #               href: pages_page_login_alt_path,
      #               title: 'Login Alt'
      #             },
      #             {
      #               href: pages_page_register_path,
      #               title: 'Register'
      #             },
      #             {
      #               href: pages_page_confirmation_path,
      #               title: 'Confirmation'
      #             }
      #           ]
      #         },
      #         {
      #           href: pages_page_profile_path,
      #           title: 'Profile'
      #         }
      #       ]
      #     }
      #   ]
      # }
    ]
  end
end