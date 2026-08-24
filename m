Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674C1391505
	for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 21:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787607668; cv=none; b=O5g9LG05HrUwr/0Hu6I9X2A5HBL0k+PTUXCIPxT11FFgKQAh6kzxYkN7DxDPlEFMJ59/UQJ/Bu43rw1lfla4D42LvQMubd5pQPmfUYNT3RAh2HUC/hF3Wq7R/PmzLdh9mQq0+kAMPp8BHfrCdVtQR/eDGXKcU+3flJpJ4vtvBus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787607668; c=relaxed/simple;
	bh=WrLECu6vT+7aI1wH8qutkqPtHYimnJ3bFMO50vk3vPg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKpiGx0+sCbFo4bodXjLMSOLQxq/alU2p/L4qHOZhbv4QxbVSyjglk4hiG7qEii1Gpf1wAarySqwCAkSUhZJX59gSm9RG4moy+UrwBTdW3do22VoPbpe7ktRBRzi+ZoMN/G8sE8k4cCW7E+PCijDRUfSacMgv+lclrqIcu/H7aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geX9kouO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geX9kouO"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d560775ca2so32822375ad.1
        for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 14:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787607666; x=1788212466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qOhcTB4KjILVw1lywIMVOHG+BE0wc/PeD6Ix52xTTSU=;
        b=geX9kouOgC/8MZO8dMRIYyXczI/kaaRf6KhApdDxs5AKvqzKPG+O/01fL9Zg5vkw89
         LTZ/IMKqfZhg2qx+7NshwSo9oEHO/+lZe5nI/Y7lxIh5IZUAkzOtBXL8dNditgcQWJko
         rRk/qrZY9kL7iLtDpoxbA64D4p9L/x03afqv6qPKArRXb/RrZy15DBOZBfPcLJon/Pcx
         NeYM5Gq9z826xZBykA60Y3z+U/8A8wvWUis61pkDXxoVjPH0+8srmqDUWth5tO/FQ6IA
         ndjrbEc48CjFtyBoNCCdnDBRlOzz7Af+v1Oz91p3WAlGrvNC/XKdyQliQ3VNqdLJs8gX
         Rasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787607666; x=1788212466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qOhcTB4KjILVw1lywIMVOHG+BE0wc/PeD6Ix52xTTSU=;
        b=IGp48bmwfNeL0iSjLj7qEvCiP2Ria9rimxUlbRneMdnRfM1UmBNioA7GzvWccdRqLX
         1EAG9yT1X5IFimCyxpIxhevCZqnkckAHTmjzXgimcok2ujCrDa5p49wYeS4SvQjbFj3L
         unJJYlRPWbo6HfS2+JzJnDQHJ6Fncqy/v9dl8EpnbblILLoCzMWXdFy4tmdFL14GjlIx
         UiVYXWvQyX50U5lJ4iUzvLPtVZcPrt3z7PSXicGY1vvAs0IZdQpUfmGVz0iw6HOUg1In
         TmdFvSDbpZO0T3aJuQLoB3RQxOr+67wC+v9alV3faeLHEQ0CfZeYITd4qMHrM0/hPBxj
         f2sA==
X-Forwarded-Encrypted: i=1; AHgh+RoPzLhnS4ljpkaL182tAJOk2LNjIjUvBQFZERRQh85n4MRugDkRbePaCvC/2AGPaV1VRzZEb3OY3bQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mXM1m7naFjF5q/Ei3Alg3M1omSkzVbZZmcsV1Z3hysqnMRqEWV
	6hQnCuSHr7bVYA7rQ1CvqKJznBtqqfF4cNvdnf32M7kFRA3XNH1/dYB5
X-Gm-Gg: AR+sD107hJy+8KwXoUSoStaqs7decFeA2fn+KbBWan6l4D9SDyroQn8c7CK3pszYwef
	Lc3MebGV2GoTu91JVpwYzNA/a4tebQnGa80HscamsKLl7LNQ6YyelSpTJzR4/KNTPVFVJ60eHoN
	u+Fw1cQvM43gSTat37rHNXuRatJJu1X8QBhsNUQf58aqhfaRGlMzmVttKl9SZ1rvPnlryDSAmrO
	ArYb0Ut1ALmgLuNKWnMLhsPC2e3HFS7R6majwBJL6DgM6GIHG5KpVXhe3IqwF3C1h2hu9SPgl/1
	XVFJ3Lq5VaDgpVLLSFoWGvZ6Q3110/1YDC9qHJtExPXxxhgb9jUGByHC4UNzHTIyN5/d1XJ1StW
	IZwekT4i2Ej+/FuB7659Yf7CAmmn1byYmy1a9c6TaYxpV6Upx4WQJ9YP3we8fgrAQlA4HtNVirA
	L3aP3++UAT1eSEepkCl0WRoigYE+vmjY7ACKiSv8Ur3I1zxoj3ZqcQSBNTKSBQegrSZTz/k4M/0
	Agz7I49qw+gcabETLIeQFqs
X-Received: by 2002:a17:90b:5485:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-395df6080e0mr42655870a91.12.1787607666513;
        Mon, 24 Aug 2026 14:41:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:a800:1010:84e9:817f:7171:6561])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645bbf440sm1036864a91.14.2026.08.24.14.41.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 24 Aug 2026 14:41:06 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: mkl@pengutronix.de,
	mailhol@kernel.org
Cc: nb@tipi-net.de,
	nihaal@cse.iitm.ac.in,
	eritque-arcus@ikuyo.dev,
	kees@kernel.org,
	pabeni@redhat.com,
	enrico.pozzobon@dissecto.com,
	extnj@kvaser.com,
	chbe@kvaser.com,
	extja@kvaser.com,
	mh@kvaser.com,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	xmei5@asu.edu,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net v2] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Mon, 24 Aug 2026 17:40:58 -0400
Message-ID: <20260824214058.44948-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fix by adding kvaser_usb_hydra_cmd_size_rx(), a receive-path wrapper that
validates buffer bounds before calling kvaser_usb_hydra_cmd_size().
Callers check for zero return to reject both issues above.  Clear invalid
leftover state before returning so subsequent transfers do not retry the
same malformed command.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Link: https://lore.kernel.org/all/20260819145658.29872-1-blbllhy@gmail.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v2:
 - Clear malformed leftover state before returning.
 - Reject command lengths shorter than the buffered prefix.

v1:
 - The zero-length command loop is also addressed by:
    https://lore.kernel.org/linux-can/20260815-can-esd-hydra-fixes-v1-2-de644cbeaec2@ikuyo.dev/
 - This patch additionally handles truncated command headers in the
    synchronous wait and asynchronous receive paths, including the
    leftover-buffer path.

 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 36 ++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index efbb7bed34c9..534bd2683012 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
@@ -536,6 +536,20 @@ static size_t kvaser_usb_hydra_cmd_size(struct kvaser_cmd *cmd)
 	return ret;
 }
 
+/* Receive-path wrapper: validate buffer bounds before reading cmd_size. */
+static size_t kvaser_usb_hydra_cmd_size_rx(struct kvaser_cmd *cmd,
+					   size_t remaining)
+{
+	if (remaining < sizeof(struct kvaser_cmd_header))
+		return 0;
+
+	if (cmd->header.cmd_no == CMD_EXTENDED &&
+	    remaining < offsetof(struct kvaser_cmd_ext, cmd_no_ext))
+		return 0;
+
+	return kvaser_usb_hydra_cmd_size(cmd);
+}
+
 static struct kvaser_usb_net_priv *
 kvaser_usb_hydra_net_priv_from_cmd(const struct kvaser_usb *dev,
 				   const struct kvaser_cmd *cmd)
@@ -675,8 +689,9 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
 			size_t cmd_len;
 
 			tmp_cmd = buf + pos;
-			cmd_len = kvaser_usb_hydra_cmd_size(tmp_cmd);
-			if (pos + cmd_len > actual_len) {
+			cmd_len = kvaser_usb_hydra_cmd_size_rx(tmp_cmd,
+							       actual_len - pos);
+			if (!cmd_len || pos + cmd_len > actual_len) {
 				dev_err_ratelimited(&dev->intf->dev,
 						    "Format error\n");
 				break;
@@ -2124,7 +2139,15 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 
 		cmd = (struct kvaser_cmd *)card_data->usb_rx_leftover;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		cmd_len = kvaser_usb_hydra_cmd_size_rx(cmd,
+						       KVASER_USB_HYDRA_MAX_CMD_LEN);
+
+		if (!cmd_len || cmd_len < usb_rx_leftover_len) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			card_data->usb_rx_leftover_len = 0;
+			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
+			return;
+		}
 
 		remaining_bytes = min_t(unsigned int, len,
 					cmd_len - usb_rx_leftover_len);
@@ -2132,6 +2155,7 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 		if (remaining_bytes + usb_rx_leftover_len >
 						KVASER_USB_HYDRA_MAX_CMD_LEN) {
 			dev_err(&dev->intf->dev, "Format error\n");
+			card_data->usb_rx_leftover_len = 0;
 			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
 			return;
 		}
@@ -2154,7 +2178,11 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	while (pos < len) {
 		cmd = buf + pos;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		cmd_len = kvaser_usb_hydra_cmd_size_rx(cmd, len - pos);
+		if (!cmd_len) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			return;
+		}
 
 		if (pos + cmd_len > len) {
 			/* We got first part of a command */
-- 
2.55.0

