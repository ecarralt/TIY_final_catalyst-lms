class ProgressReportMailer < ApplicationMailer
    default from: "from@example.com"
      layout 'mailer'

    def show_pr_email(student, pr)
      @student = student
      @pr = pr
      mail(to: @student.email, subject: 'You have received a new progress report!')
    end



end
