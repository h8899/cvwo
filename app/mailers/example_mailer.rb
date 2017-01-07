class ExampleMailer < ApplicationMailer
  default from: "letrunghieusingapore@gmail.com"
  def sample_email(task)
	@task = task
    mail(to: 'lth08091998@gmail.com', subject: "Reminder")
  end
end
