# GNUmakefile for Xenolexia Linux App
# SmallStep: build as library; run ./scripts/install-smallstep.sh, then headers in include/, lib in lib/.

include $(GNUSTEP_MAKEFILES)/common.make

APP_NAME = Xenolexia

# Use clang with blocks support (GCC does not support Objective-C blocks)
# GNUStep rules.use $(CC) for .m files; override so ObjC compiles with clang.
CC = clang
ADDITIONAL_OBJCFLAGS = -fblocks

# SmallStep: headers and lib from xenolexia-objc/include and lib (absolute path for obj/ build)
XENOLEXIA_OBJC_ROOT = $(shell cd ../.. && pwd)
SMALLSTEP_INCLUDE = $(XENOLEXIA_OBJC_ROOT)/include
SMALLSTEP_LIB = $(XENOLEXIA_OBJC_ROOT)/lib
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
	../../ThirdParty/chcsvparser/CHCSVParser/CHCSVParser/CHCSVParser.m \
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

# Link against SmallStep (from xenolexia-objc/lib), SQLite, libxml2, zlib, libzip, libcurl (downloads)
Xenolexia_LIBRARIES_DEPEND_UPON = -lSmallStep -lsqlite3 -lxml2 -lz -lzip -lcurl
ADDITIONAL_LDFLAGS = -L$(SMALLSTEP_LIB) -L/lib/x86_64-linux-gnu $(if $(LOCAL_OBJC2_EXISTS),-L$(LOCAL_OBJC2_PREFIX)/lib,)

include $(GNUSTEP_MAKEFILES)/application.make
