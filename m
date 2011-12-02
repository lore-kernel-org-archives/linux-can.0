From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 3/4] autotools: adopt to new location for kernel headers
Date: Fri,  2 Dec 2011 14:16:52 +0100
Message-ID: <1322831813-9729-4-git-send-email-mkl@pengutronix.de>
References: <1322831813-9729-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
In-Reply-To: <1322831813-9729-1-git-send-email-mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.berlios.de/mailman/options/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.berlios.de/pipermail/socketcan-core>
List-Post: <mailto:socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
List-Help: <mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=help>
List-Subscribe: <https://lists.berlios.de/mailman/listinfo/socketcan-core>,
	<mailto:socketcan-core-request-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org?subject=subscribe>
Sender: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
Errors-To: socketcan-core-bounces-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org
To: linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: socketcan-core-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Signed-off-by: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 GNUmakefile.am |   41 +++++++++++++++++++++++++----------------
 configure.ac   |   41 -----------------------------------------
 2 files changed, 25 insertions(+), 57 deletions(-)

diff --git a/GNUmakefile.am b/GNUmakefile.am
index d507a76..fc8f6e7 100644
--- a/GNUmakefile.am
+++ b/GNUmakefile.am
@@ -9,7 +9,24 @@ LDADD = \
 
 noinst_HEADERS = \
 	lib.h \
-	terminal.h
+	terminal.h \
+	include/linux/can/bcm.h \
+	include/linux/can/core.h \
+	include/linux/can/dev.h \
+	include/linux/can/error.h \
+	include/linux/can/gw.h \
+	include/linux/can.h \
+	include/linux/can/isotp.h \
+	include/linux/can/netlink.h \
+	include/linux/can/raw.h \
+	include/socketcan/can/bcm.h \
+	include/socketcan/can/error.h \
+	include/socketcan/can/gw.h \
+	include/socketcan/can.h \
+	include/socketcan/can/ioctl.h \
+	include/socketcan/can/isotp.h \
+	include/socketcan/can/netlink.h \
+	include/socketcan/can/raw.h
 
 
 noinst_LTLIBRARIES = \
@@ -27,30 +44,22 @@ bin_PROGRAMS = \
 	candump \
 	canfdtest \
 	cangen \
+	cangw \
 	canlogserver \
 	canplayer \
 	cansend \
 	cansniffer \
-	log2asc \
-	log2long \
-	slcan_attach \
-	slcand \
-	slcanpty
-
-if CONFIG_GW
-bin_PROGRAMS += \
-	cangw
-endif
-
-if CONFIG_ISOTP
-bin_PROGRAMS += \
 	isotpdump \
 	isotprecv \
 	isotpsend \
 	isotpserver \
 	isotpsniffer \
-	isotptun
-endif
+	isotptun \
+	log2asc \
+	log2long \
+	slcan_attach \
+	slcand \
+	slcanpty
 
 EXTRA_DIST = \
 	autogen.sh
diff --git a/configure.ac b/configure.ac
index 919ed5f..3ec20fb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -78,47 +78,6 @@ AC_CHECK_FUNCS([ \
 ])
 
 
-#
-# check for SOCKETCAN specific defines and headers
-#
-AC_ARG_WITH(linux-headers,
-    AS_HELP_STRING([--with-linux-headers=/path/to/kernel/include], [path to linux kernel headers]),
-    [case "${withval}" in
-	(""|y|ye|yes|n|no)
-	    AC_MSG_ERROR([You must supply a PATH as argument to --with-linux-headers]) ;;
-	(*)
-	    LINUX_HEADERS_DIR="$(cd "${withval}" && pwd)"
-	    if test $? -ne 0; then
-	        AC_MSG_ERROR(["${withval}" seems to be an invalid path!])
-	    fi ;;
-    esac]
-)
-
-maybe_linux_headers_dir="../kernel/2.6/include"
-if test -z "${LINUX_HEADERS_DIR}" -a -e "${maybe_linux_headers_dir}"; then
-    LINUX_HEADERS_DIR="$(cd "${maybe_linux_headers_dir}" && pwd)"
-fi
-if test -n "${LINUX_HEADERS_DIR}"; then
-    linux_CFLAGS="-I${LINUX_HEADERS_DIR}"
-fi
-CPPFLAGS="${CPPFLAGS} ${linux_CFLAGS}"
-AC_SUBST(linux_CFLAGS)
-
-
-AC_CHECK_HEADERS([ \
-	linux/can/gw.h \
-	linux/can/isotp.h \
-	],[],[],
-[
-#ifdef HAVE_SYS_SOCKET_H
-#include <sys/socket.h>
-#endif
-])
-
-AM_CONDITIONAL(CONFIG_GW, [test "${ac_cv_header_linux_can_gw_h}" = "yes"])
-AM_CONDITIONAL(CONFIG_ISOTP, [test "${ac_cv_header_linux_can_isotp_h}" = "yes"])
-
-
 AC_CHECK_DECL(SO_RXQ_OVFL,,
     [AC_DEFINE([SO_RXQ_OVFL], [40], [SO_RXQ_OVFL])]
 )
-- 
1.7.4.1
