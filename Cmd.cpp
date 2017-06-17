#include "Cmd.h"

int Cmd::run(int argc, char** argv, std::shared_ptr<CmdOptionsDescription> desc) {
    this->setConfigurationFromCmd(argc, argv, desc);
    
    this->startCopy();
    
    return 0;
}

void Cmd::setConfigurationFromCmd(int argc, char** argv, std::shared_ptr<CmdOptionsDescription> desc) {
    CmdOptionsParser::parseCmdOptionsToConfiguration(argc, argv, this->getOptionsDescription(desc));
}

std::shared_ptr<CmdOptionsDescription> Cmd::getOptionsDescription(std::shared_ptr<CmdOptionsDescription>  desc) {    
    
    desc->add_options()
            ("file-path,f", po::value<std::string>()->required(), "Path to list files")
            ("destination-path,d", po::value<std::string>()->required(), "Path when copy files")
            ("notificate,n", "Show informations about progress copy");
   
    return desc;
}

void Cmd::startCopy() {
    std::shared_ptr<File> fileToParse = this->getFileToParse();
    std::shared_ptr<Directory> destination = this->getDestination();
    AbstractFileParse* parser = this->getParser(fileToParse);
    
    ParsedFiles *files = this->startParse(parser, fileToParse);
    
    if (!files->isEmpty()) {
        this->copyParsedFiles(files, destination);
    }
}

std::shared_ptr<File> Cmd::getFileToParse() {
    File* file = new File(TransCopyConfiguration::getInstance()->getStringOptionValue(Cmd::OPTION_FILE_PATH));
    
    return std::make_shared<File>(*file);
}

std::shared_ptr<Directory> Cmd::getDestination() {
    Directory* path = new Directory(TransCopyConfiguration::getInstance()->getStringOptionValue(Cmd::OPTION_DESTINATION_PATH));
    
    return std::make_shared<Directory>(*path);  
}

AbstractFileParse* Cmd::getParser(std::shared_ptr<File> fileToParse) {
    return FileParserContainer::getInstance().findParser(fileToParse->getExntenstion());
}

ParsedFiles* Cmd::startParse(AbstractFileParse* parser, std::shared_ptr<File> fileToParse) {
    return parser->parse(fileToParse);
}

void Cmd::copyParsedFiles(ParsedFiles* files, std::shared_ptr<Directory> destination) {
    if (TransCopyConfiguration::getInstance()->optionExist(Cmd::OPTION_NOTIFICATE)) {
        this->copyWithNotificate(files, destination);
    } else {
        this->copyWithoutNotificate(files, destination);
    }    
}

void Cmd::copyWithNotificate(ParsedFiles* parFiles, std::shared_ptr<Directory> destination) {
    ParsedFilesStorage *files = parFiles->getParsedFilesStorage();

    this->setCopyStatusValues(parFiles, files); 

    for (ParsedFilesStorage::iterator i = files->begin(); i != files->end(); ++i) {  
        if (destination->copyFile(*i)) {            
            CopyStatus::getCopyStatus().increaseCopiedNumberFiles();
            CopyStatus::getCopyStatus().addCopiedFileSize(i->size());
                
            this->showCopyStats();
        }
    }
    std::cout << std::endl;
}

void Cmd::copyWithoutNotificate(ParsedFiles* parsedFiles, std::shared_ptr<Directory> destination) {
    ParsedFilesStorage *files = parsedFiles->getParsedFilesStorage();

    for (ParsedFilesStorage::iterator i = files->begin(); i != files->end(); ++i) {  
        destination->copyFile(*i);            
    }
    std::cout << std::endl;
}

void Cmd::setCopyStatusValues(ParsedFiles* parFiles, ParsedFilesStorage *files) {
    CopyStatus::getCopyStatus().setAllFilesSize(parFiles->size());
    CopyStatus::getCopyStatus().setNumberOfAllFiles(files->size());
}

void Cmd::showCopyStats() {
    std::cout << "\r";
    std::cout << "Copied: " << CopyStatus::getCopyStatus().getCopiedNumberFiles() << " of  " << CopyStatus::getCopyStatus().getNumberOfAllFiles() << " files ";
    std::cout << " Copied: " << CopyStatus::getCopyStatus().getCopiedFilesSize() << " of  " << CopyStatus::getCopyStatus().getAllFilesSize() << " bytes ";
    std::cout << "\r";

}