Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5841DED4C;
	Sun, 30 Aug 2026 12:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788093809; cv=none; b=l34i7NJZ/Qt6BqWNCKDG+D3RdKz5CHcnp60UjY1XV024bEM2nuFg6b61v7aPxE6LlipK7WgGFGOQtNFC7s2njtJego0/XWqHITsESMZ7BMsaaWIjrTWEGBblCH4Wh9qIPf9irUx5HFjOU+fJcpfd5BVtQqRo3S/F8xOZXyo8BII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788093809; c=relaxed/simple;
	bh=WOPVwHazyUPnvQyAQJZJFZH8rYLme33Mpw49oj2mo/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bod2wOoXD6tv30QVX1jipqsy6NlEmbQLtA6+dSkekbkQsna+9Y9Z8nRercDW9BqMOU1vqxYfkEBieKWfC+mAOwP9D92j2MJ3q3yH8Cv/OmluG9be8dQcaSykrsOJr7dv7Vm/ey+rz/uCVuIm9phm5ZVJyyF0OaqCzxKvO75a23M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowAAHED5qJZRq1oiaBg--.39702S2;
	Sun, 30 Aug 2026 20:43:23 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: kvaser_pciefd: validate DMA packet extents
Date: Sun, 30 Aug 2026 20:43:11 +0800
Message-ID: <20260830124320.96232-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAHED5qJZRq1oiaBg--.39702S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr45Aw1kKw48Zry8Zr48Crg_yoW5Cw4fpw
	45KFWYyrZ8tw1avw1xuFs8AryYv3ZxAr1093yIq34FvwnIyr1DW3W093W3KFW0krWIvFyY
	y34UCrn7GFs5A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5oGQDU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The RX parser reads a packet header and payload before checking the packet
size. It also compares its word index against the DMA buffer size in bytes,
allowing the loop index to pass the end of the 4 KiB buffer.

Bound the word index, require the fixed packet header, validate the
declared packet span, and prove a CAN payload fits before passing it to the
packet handler.

Fixes: 26ad340e582d ("can: kvaser_pciefd: Add driver for Kvaser PCIEcan devices")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index d8c9bfb202304..354a9e29a056e 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -1552,6 +1552,7 @@ static int kvaser_pciefd_read_packet(struct kvaser_pciefd *pcie, int *start_pos,
 				     int dma_buf)
 {
 	__le32 *buffer = pcie->dma_data[dma_buf];
+	const int buffer_words = KVASER_PCIEFD_DMA_SIZE / sizeof(*buffer);
 	__le64 timestamp;
 	struct kvaser_pciefd_rx_packet packet;
 	struct kvaser_pciefd_rx_packet *p = &packet;
@@ -1560,11 +1561,16 @@ static int kvaser_pciefd_read_packet(struct kvaser_pciefd *pcie, int *start_pos,
 	int size;
 	int ret = 0;
 
+	if (*start_pos < 0 || *start_pos >= buffer_words)
+		return -EIO;
+
 	size = le32_to_cpu(buffer[pos++]);
 	if (!size) {
 		*start_pos = 0;
 		return 0;
 	}
+	if (size < 5 || size > buffer_words - *start_pos)
+		return -EIO;
 
 	p->header[0] = le32_to_cpu(buffer[pos++]);
 	p->header[1] = le32_to_cpu(buffer[pos++]);
@@ -1577,13 +1583,22 @@ static int kvaser_pciefd_read_packet(struct kvaser_pciefd *pcie, int *start_pos,
 	type = FIELD_GET(KVASER_PCIEFD_PACKET_TYPE_MASK, p->header[1]);
 	switch (type) {
 	case KVASER_PCIEFD_PACK_TYPE_DATA:
+		if (!(p->header[0] & KVASER_PCIEFD_RPACKET_RTR)) {
+			u8 data_len, data_words;
+
+			data_len = can_fd_dlc2len(FIELD_GET(KVASER_PCIEFD_RPACKET_DLC_MASK,
+							    p->header[1]));
+			data_words = DIV_ROUND_UP(data_len, sizeof(*buffer));
+			if (data_words > *start_pos + size - pos)
+				return -EIO;
+		}
 		ret = kvaser_pciefd_handle_data_packet(pcie, p, &buffer[pos]);
 		if (!(p->header[0] & KVASER_PCIEFD_RPACKET_RTR)) {
 			u8 data_len;
 
 			data_len = can_fd_dlc2len(FIELD_GET(KVASER_PCIEFD_RPACKET_DLC_MASK,
 							    p->header[1]));
-			pos += DIV_ROUND_UP(data_len, 4);
+			pos += DIV_ROUND_UP(data_len, sizeof(*buffer));
 		}
 		break;
 
@@ -1640,7 +1655,8 @@ static int kvaser_pciefd_read_buffer(struct kvaser_pciefd *pcie, int dma_buf)
 
 	do {
 		res = kvaser_pciefd_read_packet(pcie, &pos, dma_buf);
-	} while (!res && pos > 0 && pos < KVASER_PCIEFD_DMA_SIZE);
+	} while (!res && pos > 0 &&
+		 pos < KVASER_PCIEFD_DMA_SIZE / sizeof(__le32));
 
 	/* Report ACKs in this buffer to BQL en masse for correct periods */
 	for (i = 0; i < pcie->nr_channels; ++i) {

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.50.1

