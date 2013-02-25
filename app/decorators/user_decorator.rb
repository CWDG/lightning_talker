class UserDecorator < Draper::Decorator
  delegate_all

  def karma
    speaker_karma + submitter_karma
  end

  def speaker_karma
    source.speeches.count * 10
  end

  def submitter_karma
    source.submitted_topics.count
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       source.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
