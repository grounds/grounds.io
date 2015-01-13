GROUND_OPTS = [
  ['language', 'golang'],
  ['language', 'python2'],

  ['theme', 'monokai'],
  ['theme', 'github'],

  ['indent', '4'],
  ['indent', 'tab'],

  ['keyboard', 'vim'],
  ['keyboard', 'ace'],
]

options = GROUND_OPTS.map { |option, _| [option] }.uniq.flatten

ALL_GROUND_OPTS = []

options.each do |option|
  opts = Editor.options(option).to_a.map { |value| [option].concat(value) }
  ALL_GROUND_OPTS.concat(opts)
end
