ActiveAdmin.register Post do
  filter :moderation_state, as: :select

  index do
    column :title
    column :created_at
    default_actions
  end

  action_item :only => :show do
    link_to('View on site', post_path(post))
  end

  action_item :only => :show do
    link_to('Accept', accept_admin_post_path(post), method: :put)
  end

  action_item :only => :show do
    link_to('Reject', reject_admin_post_path(post), method: :put)
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
