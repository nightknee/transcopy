CC = g++

CCDEPLOYFLAGS = -O3 -O2 -std=c++14
CCDEBUGFLAGS = -g -O0 -Wall -std=c++14
CCFLAGS = $(CCDEPLOYFLAGS)

LDSTATICLIBS = /usr/lib/libboost_program_options.a /usr/lib/libboost_system.a /usr/lib/libboost_filesystem.a /usr/lib/libboost_regex.a
LDDYNAMICLIBS = -lboost_program_options -lboost_system -lboost_filesystem -lboost_regex
LDLIBS = $(LDDYNAMICLIBS)

BUILDDIRNAME = Build
BUILDDIR = $(BUILDDIRNAME)/

APPNAME = TransCopy

all: bulidDirName TransCopy.o TransCopyConfiguration.o PlsParser.o PathNotExistException.o OpenFileException.o NotFoundParserException.o MainExceptionHandler.o main.o FileParserContainer.o FileNotExistException.o FileManager.o File.o CopyStatus.o CmdOptionsParserException.o CmdOptionsParsed.o CmdOptionsParser.o BaseException.o CmdOptionsDescription.o
	$(CC) $(CCFLAGS) $(BUILDDIR)TransCopy.o $(BUILDDIR)TransCopyConfiguration.o $(BUILDDIR)PlsParser.o $(BUILDDIR)PathNotExistException.o $(BUILDDIR)OpenFileException.o $(BUILDDIR)NotFoundParserException.o $(BUILDDIR)MainExceptionHandler.o $(BUILDDIR)main.o $(BUILDDIR)FileParserContainer.o $(BUILDDIR)FileNotExistException.o $(BUILDDIR)FileManager.o $(BUILDDIR)File.o $(BUILDDIR)CopyStatus.o $(BUILDDIR)CmdOptionsParserException.o $(BUILDDIR)CmdOptionsParsed.o $(BUILDDIR)CmdOptionsParser.o $(BUILDDIR)BaseException.o $(BUILDDIR)CmdOptionsDescription.o $(LDLIBS) -o $(APPNAME)

TransCopy.o:  TransCopy.cpp TransCopy.h TransCopyConfiguration.h FileParserContainer.h AbstractFileParse.h MainExceptionHandler.h Exceptions/BaseException.h FileManager.h CopyStatus.h CmdOptionsParser.h CmdOptionsDescription.h CmdOptionsParsed.h
	$(CC) -c TransCopy.cpp -o $(BUILDDIR)TransCopy.o $(CCFLAGS)

TransCopyConfiguration.o:  TransCopyConfiguration.cpp TransCopyConfiguration.h Configuration.h
	$(CC) -c TransCopyConfiguration.cpp -o $(BUILDDIR)TransCopyConfiguration.o $(CCFLAGS)
	
PlsParser.o: PlsParser.cpp PlsParser.h AbstractFileParse.h
	$(CC) -c PlsParser.cpp -o $(BUILDDIR)PlsParser.o $(CCFLAGS)

PathNotExistException.o: Exceptions/PathNotExistException.cpp Exceptions/PathNotExistException.h Exceptions/BaseException.h
	$(CC) -c Exceptions/PathNotExistException.cpp -o $(BUILDDIR)PathNotExistException.o $(CCFLAGS)

OpenFileException.o: Exceptions/OpenFileException.cpp Exceptions/OpenFileException.h Exceptions/BaseException.h
	$(CC) -c Exceptions/OpenFileException.cpp -o $(BUILDDIR)OpenFileException.o $(CCFLAGS)

NotFoundParserException.o: Exceptions/NotFoundParserException.cpp Exceptions/NotFoundParserException.h Exceptions/BaseException.h
	$(CC) -c Exceptions/NotFoundParserException.cpp -o $(BUILDDIR)NotFoundParserException.o $(CCFLAGS)

FileNotExistException.o: Exceptions/FileNotExistException.cpp Exceptions/FileNotExistException.h Exceptions/BaseException.h
	$(CC) -c Exceptions/FileNotExistException.cpp -o $(BUILDDIR)FileNotExistException.o $(CCFLAGS)

CmdOptionsParserException.o: Exceptions/CmdOptionsParserException.cpp Exceptions/CmdOptionsParserException.h Exceptions/BaseException.h
	$(CC) -c Exceptions/CmdOptionsParserException.cpp -o $(BUILDDIR)CmdOptionsParserException.o $(CCFLAGS)

BaseException.o: Exceptions/BaseException.cpp Exceptions/BaseException.h
	$(CC) -c Exceptions/BaseException.cpp -o $(BUILDDIR)BaseException.o $(CCFLAGS)

MainExceptionHandler.o: MainExceptionHandler.cpp MainExceptionHandler.h Exceptions/BaseException.h
	$(CC) -c MainExceptionHandler.cpp -o $(BUILDDIR)MainExceptionHandler.o $(CCFLAGS)

main.o:  main.cpp TransCopy.h
	$(CC) -c main.cpp -o $(BUILDDIR)main.o $(CCFLAGS)

FileParserContainer.o:  FileParserContainer.cpp FileParserContainer.h AbstractFileParse.h PlsParser.h Exceptions/BaseException.h
	$(CC) -c FileParserContainer.cpp -o $(BUILDDIR)FileParserContainer.o $(CCFLAGS)

FileManager.o:  FileManager.cpp FileManager.h File.h Exceptions/FileNotExistException.h Exceptions/PathNotExistException.h Exceptions/OpenFileException.h linux/SysFileManager.h
	$(CC) -c FileManager.cpp -o $(BUILDDIR)FileManager.o $(CCFLAGS)

File.o: File.cpp File.h
	$(CC) -c File.cpp -o $(BUILDDIR)File.o $(CCFLAGS)

CopyStatus.o: CopyStatus.cpp CopyStatus.h AbstractFileParse.h
	$(CC) -c CopyStatus.cpp -o $(BUILDDIR)CopyStatus.o $(CCFLAGS)

CmdOptionsParsed.o: CmdOptionsParsed.cpp CmdOptionsParsed.h AbstractFileParse.h CmdOptionsDescription.h
	$(CC) -c CmdOptionsParsed.cpp -o $(BUILDDIR)CmdOptionsParsed.o $(CCFLAGS)

CmdOptionsParser.o: CmdOptionsParser.cpp CmdOptionsParser.h Exceptions/CmdOptionsParserException.h CmdOptionsDescription.h CmdOptionsParsed.h
	$(CC) -c CmdOptionsParser.cpp -o $(BUILDDIR)CmdOptionsParser.o $(CCFLAGS)

CmdOptionsDescription.o: CmdOptionsDescription.cpp CmdOptionsDescription.h
	$(CC) -c CmdOptionsDescription.cpp -o $(BUILDDIR)CmdOptionsDescription.o $(CCFLAGS)

bulidDirName:
	@mkdir -p $(BUILDDIRNAME)

clean: 
	@rm -R $(BUILDDIRNAME)
