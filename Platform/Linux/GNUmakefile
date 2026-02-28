# GNUmakefile for Xenolexia Linux App
# SmallStep: use from ../../SmallStepProject/SmallStepLib (sibling of xenolexia-objc: ../SmallStepProject/SmallStepLib).

include $(GNUSTEP_MAKEFILES)/common.make

APP_NAME = Xenolexia

# Use clang with blocks support (GCC does not support Objective-C blocks)
# GNUStep rules.use $(CC) for .m files; override so ObjC compiles with clang.
CC = clang
ADDITIONAL_OBJCFLAGS = -fblocks -DXENOLEXIA_SIMPLE_CSV_EXPORT=1

# SmallStep: from ../../SmallStepProject/SmallStepLib (sibling of Xenolexia repo: two levels up from xenolexia-objc).
XENOLEXIA_OBJC_ROOT = $(shell cd ../.. && pwd)
SMALLSTEP_ROOT = $(XENOLEXIA_OBJC_ROOT)/../../SmallStepProject/SmallStepLib
SMALLSTEP_INCLUDE = $(SMALLSTEP_ROOT)/SmallStep/Core
SMALLSTEP_LIB = $(SMALLSTEP_ROOT)
# Optional: local libobjc2 for blocks runtime (run build-libobjc2-local.sh; then prefix in xenolexia-objc/local)
LOCAL_OBJC2_PREFIX ?= $(XENOLEXIA_OBJC_ROOT)/local
LOCAL_OBJC2_EXISTS = $(shell test -d $(LOCAL_OBJC2_PREFIX)/include/objc 2>/dev/null && echo 1)

Xenolexia_OBJC_FILES = \
	main.m \
	UI/XLLinuxApp.m \
	UI/Screens/XLLibraryWindowController.m \
	UI/Screens/XLBookDetailWindowController.m \
	UI/Screens/XLReaderWindowController.m \
	UI/Screens/XLVocabularyWindowController.m \
	UI/Screens/XLReviewWindowController.m \
	UI/Screens/XLSettingsWindowController.m \
	UI/Screens/XLOnboardingWindowController.m \
	UI/Screens/XLStatisticsWindowController.m \
	UI/Screens/XLAboutWindowController.m \
	../../Core/Models/Book.m \
	../../Core/Models/Language.m \
	../../Core/Models/Vocabulary.m \
	../../Core/Models/Reader.m \
	../../Core/Native/XLSm2.m \
	../../Core/Native/XLEpubReader.m \
	../../Core/Native/XLFB2Reader.m \
	../../Core/Native/XLPDFReader.m \
	../../Core/Native/XLMobiReader.m \
	../../Core/Services/XLBookParserService.m \
	../../Core/Services/XLEpubParser.m \
	../../Core/Services/XLNativeParsers.m \
	../../Core/Services/XLManager.m \
	../../Core/Services/XLTranslationEngine.m \
	../../Core/Services/XLTranslationService.m \
	../../Core/Services/XLLibreTranslateClient.m \
	../../Core/Services/XLStorageService.m \
	../../Core/Services/XLStorageServiceBlockHelper.m \
	../../Core/Services/XLExportService.m \
	../../ThirdParty/fmdb/src/fmdb/FMDatabase.m \
	../../ThirdParty/fmdb/src/fmdb/FMResultSet.m \
	../../ThirdParty/fmdb/src/fmdb/FMDatabaseAdditions.m \
	../../DictionaryService.m \
	../../DownloadService.m \
	../../TranslationService.m

Xenolexia_INCLUDE_DIRS = \
	-I. \
	-IUI \
	-IUI/Screens \
	-I../../Core/Models \
	-I../../Core/Services \
	-I../../Core/Native \
	-I$(SMALLSTEP_INCLUDE) \
	-I../../ \
	-I../../ThirdParty/fmdb/src/fmdb \
	-I../../ThirdParty/chcsvparser/CHCSVParser/CHCSVParser \
	-I/usr/include \
	-I/usr/local/include \
	-I/usr/include/x86_64-linux-gnu \
	$(if $(LOCAL_OBJC2_EXISTS),-I$(LOCAL_OBJC2_PREFIX)/include,) \
	-I/usr/include/libxml2

Xenolexia_HEADER_FILES = \
	UI/XLLinuxApp.h \
	UI/Screens/XLLibraryWindowController.h \
	UI/Screens/XLBookDetailWindowController.h \
	UI/Screens/XLReaderWindowController.h \
	UI/Screens/XLVocabularyWindowController.h \
	UI/Screens/XLReviewWindowController.h \
	UI/Screens/XLSettingsWindowController.h \
	UI/Screens/XLOnboardingWindowController.h \
	UI/Screens/XLStatisticsWindowController.h \
	UI/Screens/XLAboutWindowController.h

# Resources (app_logo.png for About screen)
Xenolexia_RESOURCE_FILES = ../../app_logo.png

# Link against SmallStep (from SmallStepProject/SmallStepLib), SQLite, libxml2, zlib, libzip, libcurl (downloads)
# Put SmallStep and system libs in Xenolexia_GUI_LIBS so they appear in ALL_LIBS after object files on the link line.
Xenolexia_LIBRARIES_DEPEND_UPON = -lsqlite3 -lxml2 -lz -lzip -lcurl
Xenolexia_GUI_LIBS = $(SMALLSTEP_LIB)/libSmallStep.a -lxml2 -lz -lzip -lcurl -lsqlite3
ADDITIONAL_LDFLAGS = -L$(SMALLSTEP_LIB) -L/lib/x86_64-linux-gnu $(if $(LOCAL_OBJC2_EXISTS),-L$(LOCAL_OBJC2_PREFIX)/lib,)

include $(GNUSTEP_MAKEFILES)/application.make
