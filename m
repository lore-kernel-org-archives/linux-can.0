Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978433F8EB9;
	Wed, 26 Aug 2026 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746253; cv=none; b=FII5iQlvO3ZU6CuyGnRAllYuzpli1RckdEO8bQBBfg2LTi8vrGNnOQRZ1TYLk2USYe1uAsFWhT6pb9HU+acWADM/dlrP7vCwaxGgAliFhE8OmkFsYKeX+hY0j1N++l7Pwyb7nvJ5p2jtT4EfCQIhJYdD9r/U3uAzkQLjvcrB1TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746253; c=relaxed/simple;
	bh=JFujjEPMQ+zsmrlPsiFdnNyy1WdLgu/YacYzg8XhAt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3dEzib/AEWZWdptLnimYp1k1BaHIC7NY4wVfKbIGlSP1C/Ec3HBv6V2FD6xWd/dIUxOQZxyIuE9xgG3IuyCHOV3A6JWZXnzOTYACQGSkv+iNv2wbVwoX1T7iMIlD5tGSbzgxYRFyqe2F3BMKNZhqLf7L9RS49VhOadClTmNEbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 45A7920240D;
	Wed, 26 Aug 2026 14:10:39 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzCSl-003R9R-0c;
	Wed, 26 Aug 2026 14:10:39 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id DF40558CD03;
	Wed, 26 Aug 2026 12:10:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	"Cen Zhang (Microsoft)" <blbllhy@gmail.com>,
	AutonomousCodeSecurity@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 12/14] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Wed, 26 Aug 2026 14:02:22 +0200
Message-ID: <20260826121036.2706424-13-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826121036.2706424-1-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>

The receive-path command parsers (kvaser_usb_hydra_wait_cmd and
kvaser_usb_hydra_read_bulk_callback) call kvaser_usb_hydra_cmd_size()
without verifying that enough buffer remains.  For CMD_EXTENDED,
kvaser_usb_hydra_cmd_size() unconditionally reads a 2-byte len field
at offset 4 (kvaser_usb_hydra.c:532).  A malicious USB device can place
a CMD_EXTENDED header at the end of a 3072-byte bulk transfer such that
only 4 bytes remain, causing a 2-byte slab-out-of-bounds read.

  BUG: KASAN: slab-out-of-bounds in kvaser_usb_hydra_wait_cmd+0x3f1/0x480
    [kvaser_usb_hydra.c:678]
  Read of size 2 at addr ffff888013f7ec00 by task kworker/0:0/9
   kvaser_usb_hydra_wait_cmd+0x3f1/0x480
   kvaser_usb_hydra_get_software_details+0x1c7/0x5d0
   kvaser_usb_probe+0x36a/0x1240

Additionally, if the device sends CMD_EXTENDED with len=0,
kvaser_usb_hydra_cmd_size() returns 0 and the parser loops forever
(pos += 0), permanently burning one CPU core.

Fix by adding kvaser_usb_hydra_cmd_size_rx(), which checks whether the
size field is complete before reading it and rejects zero command lengths.
The asynchronous receive path preserves incomplete headers in the leftover
buffer and completes them from the following transfer.  Clear malformed
leftover state before returning so later transfers do not retry it.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Link: https://patch.msgid.link/20260826013037.6933-1-blbllhy@gmail.com
[mkl: reduce scope of err in kvaser_usb_hydra_read_bulk_callback()]
[mkl: increase readability, reformat to make use of ~100 columns]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 62 ++++++++++++++++---
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index efbb7bed34c9..efe7b3ef489b 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -536,6 +536,24 @@ static size_t kvaser_usb_hydra_cmd_size(struct kvaser_cmd *cmd)
 	return ret;
 }
 
+/* -EAGAIN means incomplete; -EINVAL rejects zero to ensure progress. */
+static int kvaser_usb_hydra_cmd_size_rx(struct kvaser_cmd *cmd,
+					size_t remaining, size_t *cmd_len)
+{
+	if (remaining < sizeof(cmd->header.cmd_no))
+		return -EAGAIN;
+
+	if (cmd->header.cmd_no == CMD_EXTENDED &&
+	    remaining < offsetof(struct kvaser_cmd_ext, cmd_no_ext))
+		return -EAGAIN;
+
+	*cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+	if (!*cmd_len)
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct kvaser_usb_net_priv *
 kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
 				   const struct kvaser_cmd *cmd)
@@ -675,8 +693,8 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
 			size_t cmd_len;
 
 			tmp_cmd = buf + pos;
-			cmd_len = kvaser_usb_hydra_cmd_size(tmp_cmd);
-			if (pos + cmd_len > actual_len) {
+			err = kvaser_usb_hydra_cmd_size_rx(tmp_cmd, actual_len - pos, &cmd_len);
+			if (err || pos + cmd_len > actual_len) {
 				dev_err_ratelimited(&dev->intf->dev,
 						    "Format error\n");
 				break;
@@ -2120,23 +2138,47 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	spin_lock_irqsave(usb_rx_leftover_lock, irq_flags);
 	usb_rx_leftover_len = card_data->usb_rx_leftover_len;
 	if (usb_rx_leftover_len) {
+		const size_t cmd_size_field_end = offsetof(struct kvaser_cmd_ext, cmd_no_ext);
 		int remaining_bytes;
+		int err;
 
 		cmd = (struct kvaser_cmd *)card_data->usb_rx_leftover;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		if (cmd->header.cmd_no == CMD_EXTENDED &&
+		    usb_rx_leftover_len < cmd_size_field_end) {
+			remaining_bytes = min_t(int, len, cmd_size_field_end - usb_rx_leftover_len);
 
-		remaining_bytes = min_t(unsigned int, len,
+			memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len, buf, remaining_bytes);
+			usb_rx_leftover_len += remaining_bytes;
+			card_data->usb_rx_leftover_len = usb_rx_leftover_len;
+			pos += remaining_bytes;
+
+			if (usb_rx_leftover_len < cmd_size_field_end) {
+				spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
+				return;
+			}
+		}
+
+		err = kvaser_usb_hydra_cmd_size_rx(cmd, usb_rx_leftover_len, &cmd_len);
+		if (err || cmd_len < usb_rx_leftover_len) {
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
 						KVASER_USB_HYDRA_MAX_CMD_LEN) {
 			dev_err(&dev->intf->dev, "Format error\n");
+			card_data->usb_rx_leftover_len = 0;
 			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
 			return;
 		}
 
-		memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len, buf,
+		memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len, buf + pos,
 		       remaining_bytes);
 		pos += remaining_bytes;
 
@@ -2152,11 +2194,17 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
 
 	while (pos < len) {
+		int err;
+
 		cmd = buf + pos;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		err = kvaser_usb_hydra_cmd_size_rx(cmd, len - pos, &cmd_len);
+		if (err && err != -EAGAIN) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			return;
+		}
 
-		if (pos + cmd_len > len) {
+		if (err == -EAGAIN || pos + cmd_len > len) {
 			/* We got first part of a command */
 			int leftover_bytes;
 
-- 
2.53.0

