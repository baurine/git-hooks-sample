require_relative '../git-hooks/git_hook_util'
require 'test/unit'

class TestGitHooks < Test::Unit::TestCase
  def test_pre_msg
    assert_equal('FEATURE #123 - Add test',
                 GitHookUtil.gen_pre_msg('feature/123_add_test'))
    assert_equal('FEATURE - Add test',
                 GitHookUtil.gen_pre_msg('feature/add_test'))
    assert_equal('',
                 GitHookUtil.gen_pre_msg('feature_add_test'))
    assert_equal('BUG - Fix 123 bugs',
                 GitHookUtil.gen_pre_msg('bug/fix_123_bugs'))
    assert_equal('BUG #234 - Fix update error',
                 GitHookUtil.gen_pre_msg('hotfix/234_fix_update_error'))
    assert_equal('',
                 GitHookUtil.gen_pre_msg('master'))
  end

  def test_msg_format
    assert(GitHookUtil.expected_msg_format?(
      'FEATURE #123 - Add test'))
    assert(GitHookUtil.expected_msg_format?(
      'FEATURE - Add test'))
    assert(!GitHookUtil.expected_msg_format?(
      'FEATURE #123 - add test'))
    assert(!GitHookUtil.expected_msg_format?(
      ' FEATURE #123 - Add test'))
    assert(!GitHookUtil.expected_msg_format?(
      'FEATURE #123  -  Add test'))
  end
end
