# Preview all emails at http://localhost:3000/rails/mailers/progress_report_email
class ProgressReportEmailPreview < ActionMailer::Preview

  def show_pr_email
   ProgressReportEmail.show_pr_email(User.first)
  end

end
