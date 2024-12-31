# AseScale
Automates export of Aseprite files in different scales.  
It currently supports `.png` format, and exports from x2 to x10 scales only.

![preview of 'on start' and 'running' app](/preview.png)

> [!NOTE]  
> You need Aseprite installed to your system in order for this to work.

## Usage
Simply drag and drop an Aseprite file, and the files will be exported on `~/Documents/AseScale` folder.

## Testing
There's a `Test/test_smug.aseprite` you can test and it should generate the following:

![preview of exported files](/export_test.png)

## Docs
The program uses the following functions in order to work.

### Godot

- `OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)` - to get user's Documents path in various platforms.
- `OS.execute(<program_path>, <[args]>)` - to run Aseprite and its arguments in the command line.
    - Example: `OS.execute("aseprite", ["--batch" , file_path, "--scale", "2", "--save-as", export_path + "/" + output_name + "_x2.png"])`

### Aseprite

- `aseprite [OPTIONS] [FILES]...` - launch installed Aseprite in the command line (see [aseprite.org/docs/cli/#options](https://www.aseprite.org/docs/cli/#options))
- `--batch`/`-b` - run and process commands only, then finish them. (see [aseprite.org/docs/cli/#batch](https://www.aseprite.org/docs/cli/#batch))
    - Example: `aseprite -b`
- `--save-as` - saves the document with the provided file name. (see [aseprite.org/docs/cli/#save-as](https://www.aseprite.org/docs/cli/#save-as))
- `--scale FACTOR` - resizes the image with the given `FACTOR`. (see [aseprite.org/docs/cli/#scale](https://www.aseprite.org/docs/cli/#scale))
    - Example: `aseprite -b amogus.png --scale 4 --save-as amogus_x4.png`

## To-do
- [ ] Add `.gif` format
- [ ] Add scale options

## License
### AseScale
This work is under the [MIT License](/LICENSE.md).

### Bit3 Font
Made by [Camshaft](https://www.fontsc.com/font/designer/camshaft), © 2016-present  
https://www.fontsc.com/font/bit3  
License: Freeware - Personal & Commercial Use
