if @organization.persisted?
  json.response "organization submitted"
else
  json.form render(partial: "organizations/form", formats: :html, locals: { organization: @organization })
end
