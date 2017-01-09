class Task < ApplicationRecord
	validates :text, presence: true,
                    length: { minimum: 5 }
	has_many :taggings
	has_many :tags, through: :taggings
	
	def self.send_reminder
		@tasks = Task.all
		@tasks.each do|task|
			day = Time.now - Time.parse(task.title)
			# I send email to remind one hour before the task
			if  (((day / 3600).to_f >= -1) && ((day / 3600).to_f < 0)) 
				ExampleMailer.sample_email(task).deliver
			end
		end
	end
	
	def tag_list
		self.tags.collect do |tag|
			tag.name
		end.join(", ")
	end
	
	def tag_list=(tags_string)
	  tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
	  new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
	  self.tags = new_or_found_tags
	end

end