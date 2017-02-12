import Vapor
import Storage
import VaporPostgreSQL
import HTTP


let drop = Droplet()
try drop.addProvider(VaporPostgreSQL.Provider.self)
try drop.addProvider(StorageProvider.self)
drop.preparations += Video.self



let apiController = ApiController(drop)


drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("video","upload") { request in
    return try drop.view.make("uploadvideo", ["message":"Welcome"])
}







drop.post("video","upload") { req in
    guard let image = req.multipart?["image"]?.file else {
        throw Abort.badRequest
    }
    
    let name = req.data["name"]?.string ?? image.name ?? "upload"
    
    //let image = req.data["image"]?.string ?? ""// or
    let altImage = req.multipart?["image"]?.string ?? ""
//    let path = try Storage.upload(bytes: image.data, fileName: "profile", fileExtension: "png", mime:"png" , folder: nil)
//
    var cdnPath = ""
    var fileType: String
    if let type = image.type {
        fileType = ""
        if type.contains("png") {
            fileType = "png"
        } else if type.contains("jpeg") {
            fileType = "jpeg"
        } else if type.contains("jpg") {
            fileType = "jpg"
        } else if type.contains("mp4") {
            fileType = "mp4"
        } else if type.contains("gif") {
            fileType = "gif"
        }
        
        let path = try Storage.upload(bytes: image.data, fileName: name, fileExtension: fileType, mime: fileType, folder: nil)
        print(path)
        
        cdnPath = try Storage.getCDNPath(for: path)
        
        
    
    }
    
    
    

    var video = Video(title: name, url: cdnPath)
    try video.save()
    
    return try JSON(node:["video":video.makeNode()])
//    return try drop.view.make("uploadvideo", ["message":"Success?"])
   // return Response(redirect: "/uploadvideo")
}

drop.get("api","videos") { req in
    let videos = try Video.query().all()
    
    return try JSON(node:["videos":videos.makeNode()])
}


drop.resource("posts", PostController())

drop.run()
