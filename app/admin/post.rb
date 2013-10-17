ActiveAdmin.register Post do
  filter :moderation_state, as: :select

  index do
    column :title
    column :created_at
    default_actions

    actions do |post|
      link_to "Accept", accept_admin_post_path(post), :class => "member_link", method: :put
      link_to "Reject", reject_admin_post_path(post), :class => "member_link", method: :put
    end
  end

  member_action :accept, :method => :put do
    post = Post.find(params[:id])
    post.accept
    redirect_to :action => :show, :notice => "Accepted!"
  end

  member_action :reject, :method => :put do
    post = Post.find(params[:id])
    post.reject
    redirect_to :action => :show, :notice => "Rejected!"
  end
end
