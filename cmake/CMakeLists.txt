include("ue_default.cmake")

include("fmtlib.cmake")
include("libbase.cmake")
include("libcutils.cmake")
include("liblog.cmake")
include("libpcre2.cmake")
include("libavb.cmake")
include("libsepol.cmake")
include("libselinux.cmake")
include("libgflags.cmake")
include("libevent.cmake")
include("libmodpb64.cmake")
include("libchrome.cmake")

# compress lib
#include("zlib.cmake")
include("libxz.cmake")
include("libbz.cmake")
include("libbrotli.cmake")
include("libzstd.cmake")
include("liblz4.cmake")
include("liblzma.cmake")

include("libziparchive.cmake")

include("libfec.cmake")
include("protobuf.cmake")
include("libdivsufsort.cmake")
include("libbsdiff.cmake")
include("libzucchini.cmake")
include("puffin.cmake")
include("libsparse.cmake")
include("libverity_tree.cmake")
include("libsnapshot_cow.cmake")
include("libbrillo.cmake")

# fs lib
include("libext2_uuid.cmake")
include("libext2_com_err.cmake")
include("libext2fs.cmake")
include("liberofs.cmake")

# update_engine
include("update_engine.cmake")