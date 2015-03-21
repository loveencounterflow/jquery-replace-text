# jquery-replace-text

## Recursively replace text in an HTML structure.

This plugin is a slight improvement over
[Ben Alman's `replaceText` plugin](http://benalman.com/projects/jquery-replacetext-plugin/); its distinction
lies in the fact that it **will walk recursively through all text nodes below a given node and apply the
replacement**. The code as such is quite short, viz:


```coffee
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
```

As a bonus, you get a snazzy `node.text_nodes()` method for free!

## Installation

Use `npm`:

```bash
npm install jquery-replace-text
```



