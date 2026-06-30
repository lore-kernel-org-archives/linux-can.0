Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657B9EEC0;
	Tue, 30 Jun 2026 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804625; cv=none; b=M13SEjAyf5tnNueMaB5laMEroQNSDDy4aYGZ60LaF8iVEFoRd1Ys48qitm4H9lilh15zVshG6QuiHwn442n4DcZ9eYR7O4jGhWw8o9R9CzOoioC/elAbjXq+J0Ku9CNjg/ueJrUrbeqHrUNSabYMULkLlD1jb2MGBkC4F+2lC+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804625; c=relaxed/simple;
	bh=VI5GG3z/60fSJn2ej1NgW9bkKNYuR3yXnDzKAMgshMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EkGBfiEM78nTwVukq01FxajPLDlWLEn+v4IBqzneGx+n/A4faqKyn42GmLaxP3MgwMs7y+sxBgSyVJG7IOsQbhmIElfZ4budzLtAEuRvHALPPfqJJmqiMxE1s9nJ6FgyHM1g2i7EsvHIf6Y715FDwjX+YKWZFxH8ieKo5bqobqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0042-can-gw-validate-checksum-indices-against-frame-length.eml (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowAAXYMOGcENqV6gkFg--.11658S2;
	Tue, 30 Jun 2026 15:30:14 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] can: gw: validate checksum indices against frame length
Date: Tue, 30 Jun 2026 15:29:14 +0800
Message-ID: <2026063009033007.3-ccfa108-0042-can-gw-validate-checksum-in-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXYMOGcENqV6gkFg--.11658S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1kAr43AF15CF13uFWfZrb_yoW5uw45pa
	y5AFyY9FWkJrWfJrs2yw48Z3y5Aw48J3Z7G3sxK34UAry7ta4DJF17G34SvF18KF4kCr4a
	9rZ0yF4DGFyDZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUxcTPUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

CAN gateway checksum parameters are validated against the maximum Classic
CAN or CAN FD payload size when the route is configured.  At runtime,
however, an individual frame may carry a shorter payload.

The checksum helpers use from_idx, to_idx and result_idx to read and
write cf->data[], and the CRC8 16U8 profile additionally reads
cf->data[1].  A configuration that fits the maximum frame size can
therefore still access bytes outside the current frame's valid payload.

Validate checksum source and result indices against the current
cf->len, and require byte 1 to be present before using the CRC8 16U8
profile selector.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 net/can/gw.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/net/can/gw.c b/net/can/gw.c
index 0ec99f6..5911afb 100644
--- a/net/can/gw.c
+++ b/net/can/gw.c
@@ -318,6 +318,19 @@ static inline int calc_idx(int idx, int rx_len)
 		return idx;
 }
 
+static bool cgw_csum_idx_valid(const struct canfd_frame *cf, int idx)
+{
+	return idx >= 0 && idx < cf->len;
+}
+
+static bool cgw_csum_range_valid(const struct canfd_frame *cf,
+				 int from, int to, int res)
+{
+	return cgw_csum_idx_valid(cf, from) &&
+	       cgw_csum_idx_valid(cf, to) &&
+	       cgw_csum_idx_valid(cf, res);
+}
+
 static void cgw_csum_xor_rel(struct canfd_frame *cf, struct cgw_csum_xor *xor)
 {
 	int from = calc_idx(xor->from_idx, cf->len);
@@ -326,7 +339,7 @@ static void cgw_csum_xor_rel(struct canfd_frame *cf, struct cgw_csum_xor *xor)
 	u8 val = xor->init_xor_val;
 	int i;
 
-	if (from < 0 || to < 0 || res < 0)
+	if (!cgw_csum_range_valid(cf, from, to, res))
 		return;
 
 	if (from <= to) {
@@ -345,6 +358,10 @@ static void cgw_csum_xor_pos(struct canfd_frame *cf, struct cgw_csum_xor *xor)
 	u8 val = xor->init_xor_val;
 	int i;
 
+	if (!cgw_csum_range_valid(cf, xor->from_idx, xor->to_idx,
+				  xor->result_idx))
+		return;
+
 	for (i = xor->from_idx; i <= xor->to_idx; i++)
 		val ^= cf->data[i];
 
@@ -356,6 +373,10 @@ static void cgw_csum_xor_neg(struct canfd_frame *cf, struct cgw_csum_xor *xor)
 	u8 val = xor->init_xor_val;
 	int i;
 
+	if (!cgw_csum_range_valid(cf, xor->from_idx, xor->to_idx,
+				  xor->result_idx))
+		return;
+
 	for (i = xor->from_idx; i >= xor->to_idx; i--)
 		val ^= cf->data[i];
 
@@ -371,7 +392,10 @@ static void cgw_csum_crc8_rel(struct canfd_frame *cf,
 	u8 crc = crc8->init_crc_val;
 	int i;
 
-	if (from < 0 || to < 0 || res < 0)
+	if (!cgw_csum_range_valid(cf, from, to, res))
+		return;
+
+	if (crc8->profile == CGW_CRC8PRF_16U8 && cf->len < 2)
 		return;
 
 	if (from <= to) {
@@ -406,6 +430,13 @@ static void cgw_csum_crc8_pos(struct canfd_frame *cf,
 	u8 crc = crc8->init_crc_val;
 	int i;
 
+	if (!cgw_csum_range_valid(cf, crc8->from_idx, crc8->to_idx,
+				  crc8->result_idx))
+		return;
+
+	if (crc8->profile == CGW_CRC8PRF_16U8 && cf->len < 2)
+		return;
+
 	for (i = crc8->from_idx; i <= crc8->to_idx; i++)
 		crc = crc8->crctab[crc ^ cf->data[i]];
 
@@ -433,6 +464,13 @@ static void cgw_csum_crc8_neg(struct canfd_frame *cf,
 	u8 crc = crc8->init_crc_val;
 	int i;
 
+	if (!cgw_csum_range_valid(cf, crc8->from_idx, crc8->to_idx,
+				  crc8->result_idx))
+		return;
+
+	if (crc8->profile == CGW_CRC8PRF_16U8 && cf->len < 2)
+		return;
+
 	for (i = crc8->from_idx; i >= crc8->to_idx; i--)
 		crc = crc8->crctab[crc ^ cf->data[i]];
 

