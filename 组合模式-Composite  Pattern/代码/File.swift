//组合模式：允许你将对象组合成树形结构来表现“整体/部分”层次结构。组合能让客户以一致的方式处理个别对象已经对象组合


protocol FileType {
    func getFileName() -> String
    func addFile(file: FileType)
    func deleteFile(file: FileType)
    func display()
}

extension FileType {
    func addFile(file: FileType) {}
    func deleteFile(file: FileType){}
}

class Folder: FileType {
    private var files: Dictionary<String, FileType> = Dictionary<String, FileType>()
    private var folderName: String
    init(folderName: String) {
        self.folderName = folderName
    }
    
    func getFileName() -> String {
        return self.folderName
    }
    
    
    func addFile(file: FileType) {
        files[file.getFileName()] = file
    }
    
    func deleteFile(file: FileType) {
        files.removeValueForKey(file.getFileName())
    }
    
    func display() {
        let allKeys = Array(files.keys)
        print(getFileName())
        for i in 0..<allKeys.count {
            files[allKeys[i]]?.display()
        }
    }
}

class  BaseFile: FileType {
    private var fileName: String
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func getFileName() -> String {
        return self.fileName
    }
    
    func display() {
        print(getFileName())
    }
    
}

class SwiftFile: BaseFile {
}

class ObjCFile: BaseFile {
}






//我们要实现的结构是一个树形结构
/*
 -文件夹-rootFolder
 -Swift文件
 —Ojbc文件
 -子文件夹-SubFolder
 -Swift文件
 —Ojbc文件
 */

//创建根文件夹
let rootFolder: FileType = Folder(folderName: "根文件夹")
let objcFile1: FileType = ObjCFile(fileName: "objc1.h")
let swiftFile1: FileType = SwiftFile(fileName: "file1.Swift")
rootFolder.addFile(swiftFile1)
rootFolder.addFile(objcFile1)

let subFolder : FileType = Folder(folderName: "子文件夹")
let objcFile2: FileType = ObjCFile(fileName: "objc2.h")
let swiftFile2: FileType = SwiftFile(fileName: "file2.Swift")
subFolder.addFile(swiftFile2)
subFolder.addFile(objcFile2)

rootFolder.addFile(subFolder)

//输出该目录下的所有文件夹和文件名
rootFolder.display()
