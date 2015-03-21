
#-----------------------------------------------------------------------------------------------------------
$.fn.text_nodes = ->
  # http://refactormycode.com/codes/341-jquery-all-descendent-text-nodes-within-a-node
  R = []
  @each ->
    fn = arguments.callee
    ( $ @ ).contents().each ->
      if @nodeType == 3
        R.push @
      else
        fn.apply $ @
  return $ R

#-----------------------------------------------------------------------------------------------------------
$.fn.replace_text = ( matcher, replacement, is_raw = no ) ->
  to_be_removed = if is_raw then null else []
  @text_nodes().each ( idx ) ->
    if ( new_value = @nodeValue.replace matcher, replacement ) isnt @nodeValue
      if not is_raw and '<' in new_value
        ( $ @ ).before new_value
        to_be_removed.push @
      else
        @nodeValue = new_value
    ( $ to_be_removed ).remove() if not is_raw and to_be_removed.length > 0
