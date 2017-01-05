class ExampleMailer < ApplicationMailer
  default from: "letrunghieusingapore@gmail.com"
  def sample_email(task)
    mail(to: 'lth08091998@gmail.com', subject: 'Hieu')
  end
end
