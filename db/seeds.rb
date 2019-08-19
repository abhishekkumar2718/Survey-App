# Create an admin account

User.create(email: 'admin@survey-app.com', password: 'passwd')
puts "Created admin account"

# Create 10 user accounts

User.seed(10)
puts 'Created user accounts'

# Create 2 Open Surveys, 1 Closed Survey

n_open = 2

titles = [
  'Web Development Survey',
  'Club Survey',
  'User Experience Survey'
]
questions = [
  [
    'Choose your favorite backend framework',
    'Choose your favorite UI framework',
    'Choose your favorite OS',
    'Choose your secondary area of expertise',
    'How likely are you to recommmed this site'
  ],
  [
    'Select your first preference for club',
    'Select your second preference for club',
    'Select your third preference for club',
    'Select your first preference for SIG',
    'Select your second preference for SIG',
  ],
  [
    'Rate the authentication interface',
    'Rate the survey interface',
    'Rate the survey creation interface',
    'Rate the overall experience',
    'Which of the following features should be a priority'
  ]
]

options = [
  [
    ['Rails', 'Django', 'Flask', 'Sinatra', 'Others'],
    ['Bootstrap', 'Materialize-CSS', 'Semantic UI', 'UIKit'],
    ['Ubuntu', 'Fedora', 'Windows', 'Arch Linux', 'Other Linux distributions'],
    ['Machine Learning', 'Systems', 'Security', 'Competitive Programming'],
    ['Most Likely', 'Likely', 'Neutral', 'Unlikely']
  ],
  [
    ['ACM', 'IE', 'IEEE', 'IET', 'ISTE', 'Rotaract'],
    ['ACM', 'IE', 'IEEE', 'IET', 'ISTE', 'Rotaract'],
    ['ACM', 'IE', 'IEEE', 'IET', 'ISTE', 'Rotaract'],
    ['Programming', 'Electricals', 'Creative Arts', 'Media', 'Mechanical'],
    ['Programming', 'Electricals', 'Creative Arts', 'Media', 'Mechanical']
  ],
  [
    ['Great', 'Good', 'Neutral', 'Bad', 'Very Bad'],
    ['Great', 'Good', 'Neutral', 'Bad', 'Very Bad'],
    ['Great', 'Good', 'Neutral', 'Bad', 'Very Bad'],
    ['Great', 'Good', 'Neutral', 'Bad', 'Very Bad'],
    ['Comment Chains', 'Categorizing Surveys', 'Adding images', 'Android Application']
  ],
]

Survey.seed(n_open, titles[0, n_open], questions[0, n_open], options[0, n_open])

private_survey = Survey.create(
  user_id: 1,
  title: titles[n_open],
  questions: questions[n_open],
  options: options[n_open]
)

puts 'Created Surveys'

# Add permissions

emails = User.pluck(:email)

5.times do
  email = emails.sample
  private_survey.permit(email)
end

puts 'Created Permissions'

# Add submissions

users = User.all - [User.first]
surveys = Survey.all

users.each do |user|
  surveys.each do |survey|
    if survey.permitted?(user.email)
      survey.submit(
        user.id,
        survey.options_lengths.map{ |x| rand(x) }
      )
    end
  end
end

puts 'Created Submissions'
