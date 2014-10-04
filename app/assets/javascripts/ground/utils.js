var utils = {
    getMode: function (language) {
        return this._getFor(language, 1);
    },
    
    getSample: function (language) {
        return this._getFor(language, 2);
    },
    
    _getFor: function (language, key) {
        for (var i = 0; i < this._samples.length; i++) { 
            if (this._samples[i][0] === language) {
                return this._samples[i][key];
            }
        }
        return '';
    },
  
    _samples: [
        // Code - Mode - Sample
        ['ruby', 'ruby', 'puts "Hello world"'],
        ['golang', 'golang', 'package main\r\n\r\nimport "fmt"\r\n\r\nfunc main() {\r\n\tfmt.Println("Hello world")\r\n}'],
        ['python2', 'python', 'print "Hello World"'],
        ['python3', 'python', 'print("Hello World")'],
        ['c', 'c_cpp', '#include <stdio.h>\r\n\r\nint main()\r\n{\r\n\tprintf("Hello World\\n");\r\n\treturn 0;\r\n}'],
        ['cpp', 'c_cpp', '#include <iostream>\r\n\r\nint main()\r\n{\r\n\tstd::cout << "Hello World\\n";\r\n\treturn 0;\r\n}'],
        ['csharp', 'csharp', 'using System;\r\n\r\nclass Program\r\n{\r\n\tstatic void Main(string[] args)\r\n\t{\r\n\t\tConsole.WriteLine("Hello world");\r\n\t}\r\n}'],
        ['php', 'php', '<?php\r\n\r\nprint("Hello world\\n");']
    ]
};
