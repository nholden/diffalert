FactoryGirl.define do
  factory :trigger do
    user
    modified_file "todo.md"
    email "test@gmail.com"
    message "Alert! Alert!"
    branch "master"
    repository_name "sandbox"
  end
end
