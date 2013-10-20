ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    panel "Statistics" do
      para "Total posts: #{Post.count}"
      para "Total users: #{User.count}"
      para "Users today: #{User.today.count}"
    end
  end
end
