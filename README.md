Unix-shell-script-like functionality implemented in Scala scripts. Should work under Windows/Linux/OSX.

## Installing

### on Windows

<ol>
<li>install Scala</li>
<li>git clone git://github.com/jyrimatti/scalashell.git &lt;install_path&gt;</li>
<li>SET Path=&lt;install_path&gt;;%Path%</li>
</ol>

### on Linux

<ol>
<li>install Scala</li>
<li>git clone git://github.com/jyrimatti/scalashell.git &lt;install_path&gt;</li>
<li>EXPORT PATH=&lt;install_path&gt;:$PATH</li>
</ol>

## Usage

> files.bat | filter.bat ".*[.]exe" | lineCount.bat

On Windows you can leave out the _.bat_ extension.