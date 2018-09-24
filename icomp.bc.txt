#GCC
!ifndef CC_DIR
CC_DIR = $(MAKE_DIR)
!endif

!ifndef BCB
BCB = $(MAKEDIR)
!endif

!ifndef BHC
BHC = $(HMAKEDIR)
!endif

RECURSE= NO
COMPRESS = NO
EXTERNALLIB = NO
XFWH = NO
FILESTOADD =  5
WARNINGLEVEL =  1
USERDEFINE =
USERINCLUDE =
GUI = NO
MT = NO
OBJ = obj
 
PROJECT = icomp $(PR)
OBJFILES = $(OBJ)/db.o
 $(OB)
PRGFILES = db.prg 
 $(PS)
OBJCFILES = $(OBC) 
CFILES = $(CF)
RESFILES =                                                   
RESDEPEN =                                                   
TOPMODULE = icomp               
LIBFILES = 
DEFFILE = 
HARBOURFLAGS = -w0
CFLAG1 = -I/usr/include/xbuilder -I/usr/include/xharbour -c -Wall
CFLAG2 = -L$(HB_LIB_INSTALL)
RFLAGS = 
LFLAGS = -static -gtcrs -lsqlrdd -lpq -lodbc -lstdc++ -lssl -lkrb5 -lgnutls -Wall
  
IFLAGS = 
LINKER = xblnk
 
ALLOBJ = $(OBJFILES)  $(OBJCFILES)
ALLRES = $(RESDEPEN) 
ALLLIB = $(LIBFILES) 
.autodepend
 
#COMMANDS
.cpp.o:
gcc $(CFLAG1) $(CFLAG2) -o$* $**
 
.c.o:
gcc -I/usr/include/xbuilder -I/usr/include/xharbour $(CFLAG1) $(CFLAG2) -I. -g -o$* $**
 
.prg.o:
harbour  -go -DLINUX -DHARBOUR -I/usr/include/xharbour $(HARBOURFLAGS) -I.  -o$* $**
 
#BUILD
 
$(PROJECT): $(CFILES) $(OBJFILES) $(RESDEPEN) $(DEFFILE)
    $(LINKER) @&&!
    $(PROJECT) 
    $(ALLOBJ)  
    $(LFLAGS)  
    $(ALLLIB)  
!
