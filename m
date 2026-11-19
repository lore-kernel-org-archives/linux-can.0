Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058066;
	b=j/dqSVqdBHMJqrFRAwtGzH3KEdxG1di1q0NrO9NlyW5LsrVeZxVVY9Vbr8w8MCbWgydl
	 X0WttXLhZwZrguwaENSlKl5/ykZSu+SO/xXin5aPdK+Us4VOQme5g1BLuVKGkOm2/UFWZ
	 slOdxvMrASK4u9V6sLAPcQxIdWFIeYCTBIwxLf3xPW0DpRT3OifSEtJ2kmJtBV/R095Kq
	 kPV+0xpWcYY+doX47YzWdPSxv1vzbVl9KDDdGLoSOnMcIIDljKAT3dcmpyRlRsaAxRF2I
	 HTCab2cgFOmCnpg0O9Uz12z4OBIAoztX95jV3m11QadS4j0mgk+Ke4xRV9ZzHQIcd0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058066;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=rTVCMUckF4OImfL/pZOEtpsAr6XvQh0ItXntMQmf5hQ=;
	b=lEfcdJaVnTh5hs2iyH4sIuc1GWaK62y+3ZUWhDaoO2b8wmmaRWSh/dzxCZE717vDbR0q
	 lleERlna0l7sD9cw0H2yufiI07IPssqZjEZ5um3n0FTu++PZptq0ItJ3m85jDScJL3gj5
	 xCtEs2sfKuQMBGQs9cLlRyfKC9YtNzFg6wYT3DmSCtQn3QS4O1w7NM1o/LwYlBvINI/F2
	 uj6MTu+3O9SoewgSzpNZraq21YMry86agdkVj4c6qfHeBWnETMvRJG4x3cRbW6a9cq993
	 MZwV+UXZJAXFQhpl3Qee6A9UeWEP3z0vztSC/RCcmUQZHvkgeetSVFzGwk9SBEFjyzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=K0mLP1Yl;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09CB606A31C;
	Thu, 19 Nov 2026 03:14:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B09CB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=K0mLP1Yl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rT
	VCMUckF4OImfL/pZOEtpsAr6XvQh0ItXntMQmf5hQ=; b=K0mLP1YlyItMdc1LF6
	rJwUqY22/1oVGlC9RZ62Qh5B95yITrgy83bVSAPvsisBYnRvW6eoVM44U7NgEWHz
	JPORw40zXoAy90mV5pW2LtNb5lcT4FoB+BQnQPisa31n/dCH7ft4k6HYIKsiHluG
	DkifVjlJCjpqJ6/2Bfn9HyFms=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDnL4Bsaf5qld76Ig--.45716S2;
	Thu, 19 Nov 2026 11:13:59 +0800 (CST)
From: WEI Qinggang <stitchqgwei@163.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH can-next] selftests: can: cover CAN XL VCID getsockopt
Date: Thu, 19 Nov 2026 11:13:28 +0800
Message-ID: <20261119031328.625-1-stitchqgwei@163.com>
X-Mailer: git-send-email 2.47.1.windows.1
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL4Bsaf5qld76Ig--.45716S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF4fAF18tFyfZrW5Zr17GFg_yoW7Xw15p3
	WFyFyYyw4kJF13Xwn3Gr48uFWfXF4DJrW8Kr1xWryUZ3y7AF97XrsIkFWayry7ZrZYg39I
	va4SgF15urWDJaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZzVnUUUUU=
X-CM-SenderInfo: xvwl3u5ktj4vrl6rljoofrz/xtbC0hfR0Wr+aXcs4gAA3B

CAN_RAW_XL_VCID_OPTS returns the configured VCID options through
getsockopt(). When the supplied buffer is too small, it returns ERANGE
and updates optlen with the required size. Neither behavior is covered
by the CAN selftests.

Add two tests to a separate test_raw_sockopt executable. Set nonzero,
distinct VCID values and compare each returned field and the option
length. Pass a buffer length one byte below the structure size and
check the error and required length.

Use an unbound CAN_RAW socket so the tests need neither a CAN interface
nor vcan setup. Skip when CAN_RAW or the VCID option is unavailable.
Register the executable with kselftest and request CONFIG_CAN_RAW.

OpenAI Codex assisted with the implementation and commit message.

Signed-off-by: WEI Qinggang <stitchqgwei@163.com>
---
Tested with GCC 13.3.0 (-Werror). On Ubuntu 7.0.0-43-generic in QEMU,
both tests pass as root and as uid 65534 with only the loopback interface.
Both tests skip with CAN modules absent and on WSL 6.6 without the VCID
option. No vcan interface is created.

OpenAI Codex generated the implementation and commit message from a
request for these two cases and ran the build and runtime checks.

 tools/testing/selftests/net/can/.gitignore    |  1 +
 tools/testing/selftests/net/can/Makefile      |  2 +
 tools/testing/selftests/net/can/config        |  1 +
 .../selftests/net/can/test_raw_sockopt.c      | 80 +++++++++++++++++++
 4 files changed, 84 insertions(+)
 create mode 100644 tools/testing/selftests/net/can/test_raw_sockopt.c

diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
index 764a53fc8..f578c0821 100644
--- a/tools/testing/selftests/net/can/.gitignore
+++ b/tools/testing/selftests/net/can/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_raw_filter
+test_raw_sockopt
diff --git a/tools/testing/selftests/net/can/Makefile b/tools/testing/selftests/net/can/Makefile
index 5b82e60a0..43ea4efac 100644
--- a/tools/testing/selftests/net/can/Makefile
+++ b/tools/testing/selftests/net/can/Makefile
@@ -6,6 +6,8 @@ CFLAGS += -Wall -Wl,--no-as-needed -O2 -g -I$(top_srcdir)/usr/include $(KHDR_INC
 
 TEST_PROGS := test_raw_filter.sh
 
+TEST_GEN_PROGS := test_raw_sockopt
+
 TEST_GEN_FILES := test_raw_filter
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/can/config b/tools/testing/selftests/net/can/config
index 188f79796..2fb0a7a18 100644
--- a/tools/testing/selftests/net/can/config
+++ b/tools/testing/selftests/net/can/config
@@ -1,3 +1,4 @@
 CONFIG_CAN=m
+CONFIG_CAN_RAW=m
 CONFIG_CAN_DEV=m
 CONFIG_CAN_VCAN=m
diff --git a/tools/testing/selftests/net/can/test_raw_sockopt.c b/tools/testing/selftests/net/can/test_raw_sockopt.c
new file mode 100644
index 000000000..e4175b8f6
--- /dev/null
+++ b/tools/testing/selftests/net/can/test_raw_sockopt.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* CAN_RAW socket option tests that do not require a CAN interface. */
+
+#include <errno.h>
+#include <sys/socket.h>
+#include <unistd.h>
+
+#include <linux/can.h>
+#include <linux/can/raw.h>
+
+#include "kselftest_harness.h"
+
+static const struct can_raw_vcid_options vcid_opts = {
+	.flags = CAN_RAW_XL_VCID_TX_SET | CAN_RAW_XL_VCID_TX_PASS |
+		 CAN_RAW_XL_VCID_RX_FILTER,
+	.tx_vcid = 0x5a,
+	.rx_vcid = 0xa5,
+	.rx_vcid_mask = 0xf0,
+};
+
+FIXTURE(can_raw_vcid)
+{
+	int sock;
+};
+
+FIXTURE_SETUP(can_raw_vcid)
+{
+	int ret;
+
+	self->sock = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	if (self->sock < 0 &&
+	    (errno == EAFNOSUPPORT || errno == EPROTONOSUPPORT))
+		SKIP(return, "CAN_RAW sockets are not supported");
+	ASSERT_GE(self->sock, 0);
+
+	ret = setsockopt(self->sock, SOL_CAN_RAW, CAN_RAW_XL_VCID_OPTS,
+			 &vcid_opts, sizeof(vcid_opts));
+	if (ret < 0 && errno == ENOPROTOOPT) {
+		close(self->sock);
+		SKIP(return, "CAN_RAW_XL_VCID_OPTS is not supported");
+	}
+	ASSERT_EQ(0, ret);
+}
+
+FIXTURE_TEARDOWN(can_raw_vcid)
+{
+	close(self->sock);
+}
+
+TEST_F(can_raw_vcid, getsockopt_roundtrip)
+{
+	struct can_raw_vcid_options opts = { };
+	socklen_t len = sizeof(opts);
+	int ret;
+
+	ret = getsockopt(self->sock, SOL_CAN_RAW, CAN_RAW_XL_VCID_OPTS,
+			 &opts, &len);
+	ASSERT_EQ(0, ret);
+	EXPECT_EQ(sizeof(opts), len);
+	EXPECT_EQ(vcid_opts.flags, opts.flags);
+	EXPECT_EQ(vcid_opts.tx_vcid, opts.tx_vcid);
+	EXPECT_EQ(vcid_opts.rx_vcid, opts.rx_vcid);
+	EXPECT_EQ(vcid_opts.rx_vcid_mask, opts.rx_vcid_mask);
+}
+
+TEST_F(can_raw_vcid, getsockopt_short_buffer)
+{
+	struct can_raw_vcid_options opts = { };
+	socklen_t len = sizeof(opts) - 1;
+	int ret, saved_errno;
+
+	ret = getsockopt(self->sock, SOL_CAN_RAW, CAN_RAW_XL_VCID_OPTS,
+			 &opts, &len);
+	saved_errno = errno;
+	ASSERT_EQ(-1, ret);
+	EXPECT_EQ(ERANGE, saved_errno);
+	EXPECT_EQ(sizeof(opts), len);
+}
+
+TEST_HARNESS_MAIN

base-commit: 573af801552999954caa8347e4490b04cf4763f0
-- 
2.47.1.windows.1

