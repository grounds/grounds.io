GroundOptions = [
  ['language', 'golang'],
  ['language', 'python2'],

  ['theme', 'monokai'],
  ['theme', 'github'],

  ['indent', '4'],
  ['indent', 'tab'],

  ['keyboard', 'vim'],
  ['keyboard', 'ace'],
]

options = GroundOptions.map { |option, _| [option] }.uniq.flatten

AllGroundOptions = []

options.each do |option|
  opts = Editor.options(option).to_a.map { |value| [option].concat(value) }
  AllGroundOptions.concat(opts)
end