# Preview all emails at http://localhost:3000/rails/mailers/progress_report_mailer
class ProgressReportMailerPreview < ActionMailer::Preview

  def show_pr_email
    @student = User.find_by(first_name: "George")
    @pr = Progressreport.all.select{|pr1| pr1.student_id == 2}.last

    # @pr_filename = "#{Date.today}_PR_#{@student.full_name}"
    # @filesave_path = Rails.root.join('pdfs', "#{@pr_filename}")

    # attachments["#{@pr_filename}"] = File.read("#{@filesave_path}")
    ProgressReportMailer.show_pr_email(@student, @pr)
  end

end