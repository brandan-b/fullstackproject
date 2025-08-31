ActiveAdmin.register Province do
  permit_params :name, :code, :gst, :pst, :hst
end
