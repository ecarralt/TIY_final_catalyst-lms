class ProgressReportMailer < ApplicationMailer
    default from: "from@example.com"
      layout 'mailer'

    def show_pr_email(student, pr)
      @student = student
      @pr = pr

      @pr_filename = "#{Date.today}_PR_#{@student.full_name}"
      @filesave_path = Rails.root.join('pdfs', "#{@pr_filename}")

      attachments["#{@pr_filename}"] = File.read("#{@filesave_path}")
      mail(to: @student.email, subject: 'You have received a new progress report!')
    end

end
