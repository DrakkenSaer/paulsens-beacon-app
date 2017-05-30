json.rewards @rewards do |reward| 
    json.partial! 'rewards/reward', reward: reward
end 