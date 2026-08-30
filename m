Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E192DEA8F;
	Sun, 30 Aug 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788094409; cv=none; b=sWvSSyaSnVTcrcRII6u+1apycxvISmf/JpDrdS/Z546icJ1Y/7T98xXeIpMAUz1mMdEvjyl5sWXBrkzjYOvckPftASKRJeY6M4vrDeFtgzzHF7b0kYvjLhy1iQKCxgbsucfXgIBxd/drGHPn6x+TFOKDd3VioIyVpu8iuKG5irs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788094409; c=relaxed/simple;
	bh=EPd5ms3w1RzfQvz6ciYloATZy/TSHx2EIgphDmbyJos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZ2ctKYjT5sAjl2qfdDg6lboq/yRUBJon+J1EhcJ1UJC7pmz1+oLS9Nb5CGtNd4Uc18SqE5ojeuS+VBMcy9uELUIDSMqEZcaWeFT49NwAdPxEgP9HR+3/wH8/9ZjMU7kdydHAb/7djPEOxroUsnajC8I6Bx5I7bCIR8wjPI6/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-03 (Coremail) with SMTP id rQCowABHUD7EJ5RqfKuaBg--.40012S2;
	Sun, 30 Aug 2026 20:53:24 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Vincent Mailhol <mailhol@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] can: kvaser_usb: hydra: validate command prefixes before parsing
Date: Sun, 30 Aug 2026 20:53:22 +0800
Message-ID: <20260830125322.98199-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHUD7EJ5RqfKuaBg--.40012S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAryrJFW8uryrZry5CF43GFg_yoWrur4xpa
	47WFs8tr13Jr45J3ykGrs7Z345W3Z7Gay0v3yru3s3X3WUt3yj9ay0gr1FqFWakry3AFW2
	ya1jvF90kF1DCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeKsjUU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The Hydra receive paths derive a command length from the current buffer
before
checking that a complete command header is available. For an extended
command
this also reads the extended length field before proving that field is in
the
current USB transfer or saved fragment.

Validate the header and extended-length prefix before decoding a command
length. Keep partial prefixes in the existing leftover buffer until enough
bytes arrive to establish the command extent, and reject invalid extents.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 76 +++++++++++++++++++++--
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index efbb7bed34c9d..92c78fa690281 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -536,6 +536,30 @@ static size_t kvaser_usb_hydra_cmd_size(struct kvaser_cmd *cmd)
 	return ret;
 }
 
+static int kvaser_usb_hydra_cmd_len(const void *buf, size_t len,
+				    size_t *cmd_len)
+{
+	const struct kvaser_cmd *cmd = buf;
+
+	if (len < sizeof(cmd->header))
+		return -EMSGSIZE;
+
+	if (cmd->header.cmd_no != CMD_EXTENDED) {
+		*cmd_len = sizeof(*cmd);
+		return 0;
+	}
+
+	if (len < offsetofend(struct kvaser_cmd_ext, len))
+		return -EMSGSIZE;
+
+	*cmd_len = le16_to_cpu(((const struct kvaser_cmd_ext *)cmd)->len);
+	if (*cmd_len < offsetofend(struct kvaser_cmd_ext, cmd_no_ext) ||
+	    *cmd_len > KVASER_USB_HYDRA_MAX_CMD_LEN)
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct kvaser_usb_net_priv *
 kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
 				   const struct kvaser_cmd *cmd)
@@ -675,8 +699,10 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
 			size_t cmd_len;
 
 			tmp_cmd = buf + pos;
-			cmd_len = kvaser_usb_hydra_cmd_size(tmp_cmd);
-			if (pos + cmd_len > actual_len) {
+			err = kvaser_usb_hydra_cmd_len(tmp_cmd, actual_len - pos,
+						       &cmd_len);
+			if (err || cmd_len > actual_len - pos ||
+			    cmd_len > sizeof(*cmd)) {
 				dev_err_ratelimited(&dev->intf->dev,
 						    "Format error\n");
 				break;
@@ -2121,12 +2147,44 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	usb_rx_leftover_len = card_data->usb_rx_leftover_len;
 	if (usb_rx_leftover_len) {
 		int remaining_bytes;
+		int err;
+		size_t needed;
 
 		cmd = (struct kvaser_cmd *)card_data->usb_rx_leftover;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		while (true) {
+			err = kvaser_usb_hydra_cmd_len(cmd, usb_rx_leftover_len,
+						       &cmd_len);
+			if (err != -EMSGSIZE)
+				break;
+
+			needed = sizeof(cmd->header);
+			if (usb_rx_leftover_len >= needed &&
+			    cmd->header.cmd_no == CMD_EXTENDED)
+				needed = offsetofend(struct kvaser_cmd_ext, len);
+
+			remaining_bytes = min_t(unsigned int, len - pos,
+						needed - usb_rx_leftover_len);
+			memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len,
+			       buf + pos, remaining_bytes);
+			usb_rx_leftover_len += remaining_bytes;
+			pos += remaining_bytes;
+
+			if (remaining_bytes == 0) {
+				card_data->usb_rx_leftover_len = usb_rx_leftover_len;
+				spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
+				return;
+			}
+		}
 
-		remaining_bytes = min_t(unsigned int, len,
+		if (err) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			card_data->usb_rx_leftover_len = 0;
+			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
+			return;
+		}
+
+		remaining_bytes = min_t(unsigned int, len - pos,
 					cmd_len - usb_rx_leftover_len);
 		/* Make sure we do not overflow usb_rx_leftover */
 		if (remaining_bytes + usb_rx_leftover_len >
@@ -2152,11 +2210,17 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
 
 	while (pos < len) {
+		int err;
+
 		cmd = buf + pos;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		err = kvaser_usb_hydra_cmd_len(cmd, len - pos, &cmd_len);
+		if (err == -EINVAL) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			return;
+		}
 
-		if (pos + cmd_len > len) {
+		if (err == -EMSGSIZE || cmd_len > len - pos) {
 			/* We got first part of a command */
 			int leftover_bytes;

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.50.1

