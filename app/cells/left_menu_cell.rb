class LeftMenuCell < Cell::Rails

  def doc_mgmt(args)
    @doc_masters_path = args[:doc_masters_path]
    @doc_template_masters_path = args[:doc_template_masters_path]
    render
  end

  def rule_mgmt(args)
    @rules_path = args[:rules_path]
    render
  end

  def recruitment(args)
    @interview_types_path = args[:interview_types_path]
    @ratings_path = args[:ratings_path]
    @rating_scales_path = args[:rating_scales_path]
    @vacancy_masters_path = args[:vacancy_masters_path]
    @vacancy_schedulings_path = args[:vacancy_schedulings_path]
    render
  end

  def company(args)
    @company_masters_path = args[:company_masters_path]
    @clients_path = args[:clients_path]
    render
  end

  def admin_tools(args)
    @administration = args[:administration]
    render
  end

end
