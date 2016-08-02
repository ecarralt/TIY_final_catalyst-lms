class ProgressReportEmail < ApplicationMailer
    default from: "from@example.com"
      layout 'mailer'

    def show_pr_email(user)
      @user = User.find_by usertype: "student"
      mail(to: user.email, subject: 'Test Email')
    end



end
