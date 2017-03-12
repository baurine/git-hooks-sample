class GitHookUtil
  BRANCH_NAME_REG = /^(feature|bug|hotfix|misc|refactor)\/(\d*)?(\w*)/

  # generate pre msg by branch name
  def self.gen_pre_msg(branch_name)
    match_group = BRANCH_NAME_REG.match(branch_name)
    if match_group
      issue_type = match_group[1].upcase
      issue_num = match_group[2]
      issue_content = match_group[3]

      issue_type = 'BUG' if issue_type == 'HOTFIX'
      issue_num = " \##{issue_num}" unless issue_num.empty?
      issue_content = issue_content.gsub(/_/, ' ').strip.capitalize

      "#{issue_type}#{issue_num} - #{issue_content}"
    else
      ''
    end
  end

  ##########################################

  MSG_FORMAT_REG = /^(FEATURE|BUG|MISC|REFACTOR)(\s#\d+)* - ([A-Z].*)/

  def self.expected_msg_format?(commit_msg)
    commit_msg.start_with?('Merge branch') || MSG_FORMAT_REG.match(commit_msg)
  end
end
