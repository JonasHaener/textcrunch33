DELETE FROM
textcrunch.blocks,
textcrunch.tag_switch,
textcrunch.lang_german, 
textcrunch.lang_english, 
textcrunch.lang_french,
textcrunch.lang_dutch,
textcrunch.lang_italian,
textcrunch.lang_spanish,
textcrunch.lang_polish,
textcrunch.lang_japanese
USING
textcrunch.blocks,
textcrunch.tag_switch, 
textcrunch.lang_german, 
textcrunch.lang_english, 
textcrunch.lang_french,
textcrunch.lang_dutch,
textcrunch.lang_italian,
textcrunch.lang_spanish,
textcrunch.lang_polish,
textcrunch.lang_japanese
WHERE
blocks.block_id 	= lang_german.block_id
AND blocks.block_id = lang_english.block_id
AND blocks.block_id = lang_french.block_id
AND blocks.block_id = lang_dutch.block_id
AND blocks.block_id = lang_italian.block_id
AND blocks.block_id = lang_spanish.block_id
AND blocks.block_id = lang_polish.block_id
AND blocks.block_id = lang_japanese.block_id
AND blocks.block_id = tag_switch.block_id 
AND blocks.block_id > 9;