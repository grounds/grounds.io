var utils = {
    getMode: function(language) {
        return this.samples[language].mode;
    },

    getSample: function(language) {
        return this.samples[language].code.join('\n');
    },

    samples: {}
};

utils.samples['ruby'] = { mode: 'ruby', code: [
'puts "Hello world"'
]};

utils.samples['golang'] = { mode: 'golang', code: [
'package main',
'',
'import "fmt"',
'',
'func main() {',
'	fmt.Println("Hello world")',
'}'
]};

utils.samples['python2'] = { mode: 'python', code: [
'print "Hello world"'
]};

utils.samples['python3'] = { mode: 'python', code: [
'print("Hello World")'
]};

utils.samples['c'] = { mode: 'c_cpp', code: [
'#include <stdio.h>',
'',
'int main()',
'{',
'	printf("Hello World\\n");',
'	return 0;',
'}'
]};

utils.samples['cpp'] = { mode: 'c_cpp', code: [
'#include <iostream>',
'',
'int main()',
'{',
'	std::cout << "Hello World\\n";',
'	return 0;',
'}'
]};

utils.samples['csharp'] = { mode: 'csharp', code: [
'using System;',
'',
'class Program',
'{',
'	static void Main(string[] args)',
'	{',
'		Console.WriteLine("Hello world");',
'	}',
'}'
]};

utils.samples['php'] = { mode: 'php', code: [
'<?php',
'',
'print("Hello world\\n");'
]};

utils.samples['java'] = { mode: 'java', code: [
'public class Main {',
'	public static void main(String[] args) {',
'		System.out.println("Hello world");',
'	}',
'}'
]};

utils.samples['node'] = { mode: 'javascript', code: [
'console.log("Hello world");'
]};

utils.samples['rust'] = { mode: 'rust', code: [
'fn main() {',
'	println!("Hello world");',
'}'
]}

utils.samples['elixir'] = { mode: 'elixir', code: [
'IO.puts "Hello world"'
]}

utils.samples['haxe'] = { mode: 'haxe', code: [
'class Main {',
'	public static function main() {',
'		Sys.println("Hello world");',
'	}',
'}'
]}
