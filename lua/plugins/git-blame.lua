require('gitblame').setup {
  enabled = true,
  message_template = ' <summary> • <date> • <author> • <<sha>>',
  date_format = '%m-%d-%Y %H:%M:%S',
  virtual_text_column = 1,
}

-- vim: ts=2 sts=2 sw=2 et
