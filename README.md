# jquery-replace-text


Recursively replace text in an HTML structure.



```coffee
$.fn.replace_text = ( matcher, replacement, is_raw = no ) ->
  to_be_removed = if is_raw then null else []
  this.text_nodes().each ( idx ) ->
    if ( new_value = @nodeValue.replace matcher, replacement ) isnt @nodeValue
      if not is_raw and '<' in new_value
        ( $ @ ).before new_value
        to_be_removed.push @
      else
        @nodeValue = new_value
    ( $ to_be_removed ).remove() if not is_raw and to_be_removed.length > 0
```


