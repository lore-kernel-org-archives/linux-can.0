Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2281F63D9;
	Wed, 23 Sep 2026 02:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132040; cv=none; b=Sytg9fCmTGUt7QgwB0RDsVVoOezNKQgitppJuoE5lX57YVb/4c6nHDJ72C9GbYVy7allFHt5K1p3Mp9cs602+kWj73pxWc4ShqpyPeg8tJzhKTiRP0Tfh2MYvFlgH4Qvm59VEsxr851GKhfVOHbqQH0cUcWTLpO+/dLcHOOql3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132040; c=relaxed/simple;
	bh=X/9QHCzrOKuGDYz/clmsNOVioxcItktSTaUSlO//Jz0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ND9UocZ1BPjqIcPwll4C7rAkZknPaXBEnKVMsGP7R2Q7av99K/jBx2fgp7ktBeVMBC6ElgTOH5bLjWEkV1Qhtmk/pvRwUWjtjYvTBQDs2D+W10Y1Xb4QxnEbxQ1LaHitfu1eoh+QJjUN5c47JXcqfBOhqJFRWYpNuRt+OJqCjkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ytpl7CPe; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ytpl7CPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SN
	APCKLxuyT2mcxZ5JnVAm9pPavqX2Kqo/KkOx6nHv8=; b=Ytpl7CPe2+EoyzxzJb
	MqlkEAbVdAgTr3mzfrUOgW+gZ7snHWwTw4rnQeOFDPshNywADd7atzZHJXtmhdut
	Pe2bSuMzvmrXOC2w5ROv232zqEpkq98SkijkskI6FAvLPv50I/MAwevC0OJKj7de
	GRassRrha4bpc+F5ULU1pJY5w=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3BywmP7Nqb1ryAA--.49940S2;
	Wed, 23 Sep 2026 10:53:27 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH] selftests: can: add CAN XL raw socket tests
Date: Wed, 23 Sep 2026 10:53:17 +0800
Message-ID: <20260923025317.374997-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3BywmP7Nqb1ryAA--.49940S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3KrW8WFyrWw17ury7JrykAFb_yoWkuw1Up3
	WvkFy5JrWUJw1fuw45Ja1FkFW3Gr1qgry29r9xXrWDZw1fWFn8WFZ2kFZ09FWUZrZ3W3W5
	Wa15GFW5C39xJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRy5d_UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5Adg1WqzPyd7YQAA3N

The CAN raw socket CAN XL support (CAN_RAW_XL_FRAMES,
CAN_RAW_XL_VCID_OPTS) is currently untested in kselftest. The only CAN
test in the tree, test_raw_filter, exercises classic CAN filter matching
and never touches CAN XL.

Add a set of CAN XL tests to test_raw_filter. vcan is used as the test
interface, which reports CAN XL capability when the MTU is large enough,
so these run without CAN hardware. Tests are skipped when the interface
cannot carry CAN XL frames, so a classic CAN or CAN FD only interface
does not turn them into failures.

Covered behaviour:

  - payload round-trips for 1, 8, 64 and the maximum of 2048 bytes,
    including the priority, SDU type and acceptance field
  - a CAN XL frame is rejected with -EINVAL while CAN_RAW_XL_FRAMES is
    disabled
  - a frame without the mandatory CANXL_XLF flag is rejected
  - the declared length must match the payload actually written
  - enabling CAN XL implicitly enables CAN FD, and CAN FD cannot be
    disabled again while CAN XL stays enabled
  - the VCID is stripped by default, and a VCID tagged frame is only
    forwarded once CAN_RAW_XL_VCID_RX_FILTER is set
  - CAN_RAW_XL_VCID_TX_SET overwrites the VCID without clobbering the
    priority, and a non-matching RX VCID filter drops the frame

A blocking read() cannot be used to assert that a frame was filtered out,
as it never returns; the new recv_timeout() helper waits for a frame with
a bounded timeout instead.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 .../selftests/net/can/test_raw_filter.c       | 393 ++++++++++++++++++
 1 file changed, 393 insertions(+)

diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
index bb8ae8854273..53f0c9d829ed 100644
--- a/tools/testing/selftests/net/can/test_raw_filter.c
+++ b/tools/testing/selftests/net/can/test_raw_filter.c
@@ -16,11 +16,19 @@
 #include <net/if.h>
 #include <linux/if.h>
 
+#include <errno.h>
+#include <stddef.h>
+
 #include <linux/can.h>
 #include <linux/can/raw.h>
+#include <linux/types.h>
 
 #include "kselftest_harness.h"
 
+#ifndef ARRAY_SIZE
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+#endif
+
 #define ID 0x123
 
 char CANIF[IFNAMSIZ];
@@ -390,6 +398,391 @@ TEST_F(can_filters, test_filter)
 	}
 }
 
+/* --- CAN XL --- */
+
+#define XLF 0x80
+
+/* CAN XL requires an interface whose MTU is large enough; a classic CAN or
+ * CAN FD only interface cannot carry CAN XL frames.
+ */
+static bool can_iface_supports_xl(void)
+{
+	struct ifreq ifr;
+	int s, ret;
+
+	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	if (s < 0)
+		return false;
+
+	strncpy(ifr.ifr_name, CANIF, sizeof(ifr.ifr_name));
+	ret = ioctl(s, SIOCGIFMTU, &ifr);
+	close(s);
+
+	if (ret < 0)
+		return false;
+
+	return ifr.ifr_mtu >= CANXL_MIN_MTU;
+}
+
+static int open_xl_socket(int send_xl, const struct can_raw_vcid_options *vcid)
+{
+	struct sockaddr_can addr;
+	struct ifreq ifr;
+	int one = 1;
+	int s, ret;
+
+	s = socket(PF_CAN, SOCK_RAW, CAN_RAW);
+	if (s < 0)
+		return -1;
+
+	strncpy(ifr.ifr_name, CANIF, sizeof(ifr.ifr_name));
+	ret = ioctl(s, SIOCGIFINDEX, &ifr);
+	if (ret < 0)
+		goto close_sock;
+
+	addr.can_family = AF_CAN;
+	addr.can_ifindex = ifr.ifr_ifindex;
+
+	ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
+	if (ret < 0)
+		goto close_sock;
+
+	ret = setsockopt(s, SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS, &one, sizeof(one));
+	if (ret < 0)
+		goto close_sock;
+
+	if (vcid) {
+		ret = setsockopt(s, SOL_CAN_RAW, CAN_RAW_XL_VCID_OPTS, vcid,
+				 sizeof(*vcid));
+		if (ret < 0)
+			goto close_sock;
+	}
+
+	ret = setsockopt(s, SOL_CAN_RAW, CAN_RAW_XL_FRAMES, &send_xl,
+			 sizeof(send_xl));
+	if (ret < 0)
+		goto close_sock;
+
+	return s;
+
+close_sock:
+	close(s);
+	return -1;
+}
+
+static void fill_canxl(struct canxl_frame *cxl, unsigned int len, __u8 sdt)
+{
+	int i;
+
+	memset(cxl, 0, sizeof(*cxl));
+	cxl->prio = ID;
+	cxl->flags = XLF;
+	cxl->sdt = sdt;
+	cxl->len = len;
+	cxl->af = 0xdeadbeef;
+
+	for (i = 0; i < len; i++)
+		cxl->data[i] = i & 0xff;
+}
+
+/* Wait up to 200ms for a frame. Returns the frame size, or -1 if nothing
+ * arrived. A blocking read() cannot be used to assert that a frame was
+ * filtered out, as it would simply wait forever.
+ */
+static int recv_timeout(int sock, void *buf, size_t len)
+{
+	struct timeval tv = {
+		.tv_sec = 0,
+		.tv_usec = 200000,
+	};
+	fd_set rdfs;
+	int ret;
+
+	FD_ZERO(&rdfs);
+	FD_SET(sock, &rdfs);
+
+	ret = select(sock + 1, &rdfs, NULL, NULL, &tv);
+	if (ret <= 0)
+		return -1;
+
+	return read(sock, buf, len);
+}
+
+FIXTURE(canxl) {
+	int sock;
+};
+
+FIXTURE_SETUP(canxl)
+{
+	self->sock = open_xl_socket(1, NULL);
+}
+
+FIXTURE_TEARDOWN(canxl)
+{
+	if (self->sock >= 0)
+		close(self->sock);
+}
+
+/* Round-trip payload lengths, including the maximum CAN XL payload */
+TEST_F(canxl, payload_roundtrip)
+{
+	const unsigned int lens[] = { 1, 8, 64, 2048 };
+	struct canxl_frame tx;
+
+	if (!can_iface_supports_xl())
+		SKIP(return, "%s does not support CAN XL", CANIF);
+
+	ASSERT_GE(self->sock, 0)
+		TH_LOG("failed to open CAN XL socket on %s", CANIF);
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(lens); i++) {
+		unsigned int len = lens[i];
+		struct canxl_frame rx;
+		int ret;
+
+		fill_canxl(&tx, len, 0x11);
+
+		ret = write(self->sock, &tx, CANXL_HDR_SIZE + len);
+		ASSERT_EQ(ret, CANXL_HDR_SIZE + len)
+			TH_LOG("failed to send CAN XL frame of len %u", len);
+
+		ret = read(self->sock, &rx, sizeof(rx));
+		ASSERT_EQ(ret, CANXL_HDR_SIZE + len)
+			TH_LOG("failed to receive CAN XL frame of len %u", len);
+
+		ASSERT_EQ(rx.len, len)
+			TH_LOG("wrong payload length in received frame");
+		ASSERT_EQ(rx.sdt, tx.sdt)
+			TH_LOG("wrong SDU type in received frame");
+		ASSERT_EQ(rx.af, tx.af)
+			TH_LOG("wrong acceptance field in received frame");
+		ASSERT_EQ(rx.prio, tx.prio)
+			TH_LOG("wrong priority in received frame");
+		ASSERT_EQ(memcmp(rx.data, tx.data, len), 0)
+			TH_LOG("payload corrupted");
+	}
+}
+
+/* A CAN XL frame must not be accepted when CAN_RAW_XL_FRAMES is off */
+TEST(canxl_send_requires_xl_frames)
+{
+	struct canxl_frame tx;
+	int s, ret;
+
+	/* a plain socket that did not enable CAN XL */
+	s = open_xl_socket(0, NULL);
+	ASSERT_GE(s, 0)
+		TH_LOG("failed to open CAN socket on %s", CANIF);
+
+	fill_canxl(&tx, 8, 0x11);
+
+	ret = write(s, &tx, CANXL_HDR_SIZE + tx.len);
+	ASSERT_LT(ret, 0)
+		TH_LOG("CAN XL frame accepted without CAN_RAW_XL_FRAMES");
+	ASSERT_EQ(errno, EINVAL);
+
+	close(s);
+}
+
+/* A frame without the mandatory CANXL_XLF flag must be rejected */
+TEST(canxl_requires_xlf_flag)
+{
+	struct canxl_frame tx;
+	int s, ret;
+
+	s = open_xl_socket(1, NULL);
+	if (!can_iface_supports_xl())
+		SKIP(return, "%s does not support CAN XL", CANIF);
+
+	ASSERT_GE(s, 0)
+		TH_LOG("failed to open CAN XL socket on %s", CANIF);
+
+	fill_canxl(&tx, 8, 0x11);
+	tx.flags = 0;
+
+	ret = write(s, &tx, CANXL_HDR_SIZE + tx.len);
+	ASSERT_LT(ret, 0)
+		TH_LOG("frame without CANXL_XLF accepted");
+	ASSERT_EQ(errno, EINVAL);
+
+	close(s);
+}
+
+/* The declared length must match the payload actually written */
+TEST(canxl_declared_len_must_match_payload)
+{
+	struct canxl_frame tx;
+	int s, ret;
+
+	s = open_xl_socket(1, NULL);
+	if (!can_iface_supports_xl())
+		SKIP(return, "%s does not support CAN XL", CANIF);
+
+	ASSERT_GE(s, 0)
+		TH_LOG("failed to open CAN XL socket on %s", CANIF);
+
+	fill_canxl(&tx, 8, 0x11);
+	tx.len = 100;
+
+	ret = write(s, &tx, CANXL_HDR_SIZE + 8);
+	ASSERT_LT(ret, 0)
+		TH_LOG("frame with mismatching length accepted");
+	ASSERT_EQ(errno, EINVAL);
+
+	close(s);
+}
+
+/* Enabling CAN XL must implicitly enable CAN FD, and it must not be turnable
+ * off again while CAN XL stays enabled
+ */
+TEST(canxl_enables_fd_and_cannot_be_disabled)
+{
+	struct canfd_frame tx;
+	struct canxl_frame rx;
+	int s, ret;
+	int zero = 0;
+
+	s = open_xl_socket(1, NULL);
+	if (!can_iface_supports_xl())
+		SKIP(return, "%s does not support CAN XL", CANIF);
+
+	ASSERT_GE(s, 0)
+		TH_LOG("failed to open CAN XL socket on %s", CANIF);
+
+	ret = setsockopt(s, SOL_CAN_RAW, CAN_RAW_FD_FRAMES, &zero, sizeof(zero));
+	ASSERT_LT(ret, 0)
+		TH_LOG("CAN FD could be disabled while CAN XL was enabled");
+	ASSERT_EQ(errno, EINVAL);
+
+	memset(&tx, 0, sizeof(tx));
+	tx.can_id = ID;
+	tx.len = 8;
+
+	ret = write(s, &tx, CANFD_MTU);
+	ASSERT_EQ(ret, CANFD_MTU)
+		TH_LOG("CAN FD not implicitly enabled by CAN XL");
+
+	ret = read(s, &rx, sizeof(rx));
+	ASSERT_EQ(ret, CANFD_MTU)
+		TH_LOG("CAN FD frame not delivered to a CAN XL socket");
+
+	close(s);
+}
+
+/* Without VCID options the VCID is stripped on TX and a VCID-tagged frame is
+ * not forwarded on RX
+ */
+TEST(canxl_vcid_stripped_by_default)
+{
+	struct can_raw_vcid_options pass = {
+		.flags = CAN_RAW_XL_VCID_TX_PASS,
+	};
+	struct canxl_frame tx, rx;
+	int tx_sock, rx_sock, ret;
+
+	tx_sock = open_xl_socket(1, &pass);
+	ASSERT_GE(tx_sock, 0)
+		TH_LOG("CAN XL not supported on %s", CANIF);
+
+	rx_sock = open_xl_socket(1, NULL);
+	ASSERT_GE(rx_sock, 0);
+
+	fill_canxl(&tx, 8, 0x11);
+	tx.prio |= 0x42 << CANXL_VCID_OFFSET;
+
+	ret = write(tx_sock, &tx, CANXL_HDR_SIZE + tx.len);
+	ASSERT_EQ(ret, CANXL_HDR_SIZE + tx.len);
+
+	/* the RX socket has no VCID filter, so it drops VCID tagged frames */
+	ret = recv_timeout(rx_sock, &rx, sizeof(rx));
+	ASSERT_LT(ret, 0)
+		TH_LOG("VCID tagged frame forwarded without CAN_RAW_XL_VCID_RX_FILTER");
+
+	close(tx_sock);
+	close(rx_sock);
+}
+
+/* CAN_RAW_XL_VCID_TX_SET overwrites the VCID, and the RX side can select it */
+TEST(canxl_vcid_set_and_filter)
+{
+	struct can_raw_vcid_options opts = {
+		.flags = CAN_RAW_XL_VCID_TX_SET,
+		.tx_vcid = 0x77,
+	};
+	struct can_raw_vcid_options filter = {
+		.flags = CAN_RAW_XL_VCID_RX_FILTER,
+		.rx_vcid = 0x77,
+		.rx_vcid_mask = 0xff,
+	};
+	struct canxl_frame tx, rx;
+	int tx_sock, rx_sock, ret;
+
+	tx_sock = open_xl_socket(1, &opts);
+	if (!can_iface_supports_xl())
+		SKIP(return, "%s does not support CAN XL", CANIF);
+
+	ASSERT_GE(tx_sock, 0)
+		TH_LOG("failed to open CAN XL VCID socket on %s", CANIF);
+
+	rx_sock = open_xl_socket(1, &filter);
+	ASSERT_GE(rx_sock, 0);
+
+	fill_canxl(&tx, 8, 0x11);
+	tx.prio |= 0x42 << CANXL_VCID_OFFSET;
+
+	ret = write(tx_sock, &tx, CANXL_HDR_SIZE + tx.len);
+	ASSERT_EQ(ret, CANXL_HDR_SIZE + tx.len);
+
+	ret = read(rx_sock, &rx, sizeof(rx));
+	ASSERT_EQ(ret, CANXL_HDR_SIZE + 8);
+
+	ASSERT_EQ((rx.prio & CANXL_VCID_MASK) >> CANXL_VCID_OFFSET, 0x77)
+		TH_LOG("CAN_RAW_XL_VCID_TX_SET did not overwrite the VCID");
+	ASSERT_EQ(rx.prio & CANXL_PRIO_MASK, ID)
+		TH_LOG("priority clobbered by the VCID option");
+
+	close(tx_sock);
+	close(rx_sock);
+}
+
+/* A non-matching VCID filter must not forward the frame */
+TEST(canxl_vcid_filter_mismatch)
+{
+	struct can_raw_vcid_options pass = {
+		.flags = CAN_RAW_XL_VCID_TX_PASS,
+	};
+	struct can_raw_vcid_options filter = {
+		.flags = CAN_RAW_XL_VCID_RX_FILTER,
+		.rx_vcid = 0x99,
+		.rx_vcid_mask = 0xff,
+	};
+	struct canxl_frame tx, rx;
+	int tx_sock, rx_sock, ret;
+
+	tx_sock = open_xl_socket(1, &pass);
+	if (!can_iface_supports_xl())
+		SKIP(return, "%s does not support CAN XL", CANIF);
+
+	ASSERT_GE(tx_sock, 0)
+		TH_LOG("failed to open CAN XL VCID socket on %s", CANIF);
+
+	rx_sock = open_xl_socket(1, &filter);
+	ASSERT_GE(rx_sock, 0);
+
+	fill_canxl(&tx, 8, 0x11);
+	tx.prio |= 0x42 << CANXL_VCID_OFFSET;
+
+	ret = write(tx_sock, &tx, CANXL_HDR_SIZE + tx.len);
+	ASSERT_EQ(ret, CANXL_HDR_SIZE + tx.len);
+
+	ret = recv_timeout(rx_sock, &rx, sizeof(rx));
+	ASSERT_LT(ret, 0)
+		TH_LOG("frame with non-matching VCID was forwarded");
+
+	close(tx_sock);
+	close(rx_sock);
+}
+
 int main(int argc, char **argv)
 {
 	char *ifname = getenv("CANIF");
-- 
2.43.0

