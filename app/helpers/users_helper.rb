module UsersHelper
  
  #  common in user and user_mailer
  def show_selection(field, label)
    img = "<img class='check' src='/images/icons/check.png' />" if @user.send(field)
    haml_tag :p do
      haml_concat "#{label}#{img}"
    end
  end
  
  def show_field(field, label, &block)
    val = @user.send(field) 
    value = block ? block.call(val) : val 
    return false if value.blank?
    haml_tag :p, { class: "b" } do
      haml_concat label
    end
    haml_tag :p do 
      haml_concat value
    end
  end
end