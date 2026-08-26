Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9131248F7C
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787707863; cv=none; b=mLfQy5wTyCaXti/1noza822aocoXOocc4n8S2xkdkgbTMIbuyw7quroaXGkz7CgbupOzrnnaLzj16f8MFA35yzU6u2NmDxY26Ac9xHqTjPoWvEgTJMdBs9m79gruFCw+YLAt/1VWy8mWi4/AiQcvlVzS1kxtoDZRuRp4XXMOSjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787707863; c=relaxed/simple;
	bh=VP41uxKw0FfekXFnJJHh+Pnw8byZRbNHP92L5bGOph4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVhiiGeRSb385Dcv3h93Zdh5q8nf9om26U30W/jeWApg0oFXIb1+h0FSLLQBzr2+J8BJ7ICatlHpKJSXbyGo3dkGlk5rA2eqx+f+OZen5HE0L/iCwTshc8Rtdz3dkC0hYraB/zjG6x2qQDgk+MYlcvzK6ghhiLlR552amCUct4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqTiEo/H; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqTiEo/H"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-66ceaade3f1so393485d50.1
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 18:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787707859; x=1788312659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jYeUoTrvVE/9BjwtXesGs0vbqmsGKZw2+esTghaIakE=;
        b=HqTiEo/HJ5hsfjrFphjQ34Zc7hSE5KsitrhCNoYbgVQpfuZJDy9oWRplqt2vAXASnN
         XD9FZuLbalBJTZWzhNiaC6XivrONVnaN1krpw9t6wUJa+hwx99t1M29M1kZHVdYsv41U
         G6/WcI1lazj/dDfJaq70VgrYA8cpYUrOJol0F4FXz6HCZqEOhTVEdgW69mXNRX0vzBdU
         5//DQA3x1POmt8i8XNWtvdtcw/lBINEI1r4Noss142S0g27uoJE6odsOj1YL/rvRjTs4
         IWCTn/0+bvJhpo0p1ieNMlanFr2FDkGrj2YHoavIY6Tui3hb1E0rSRdLEAX/V9OKZN6A
         +JQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787707859; x=1788312659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jYeUoTrvVE/9BjwtXesGs0vbqmsGKZw2+esTghaIakE=;
        b=D6HOA3LvaECS+3iNSw/UuHiGvr+keFINnKDku5qfC+uKTyG7/NS2anwTq8ZO/orHzf
         GPgKMPO1bD152giH4W9LQkok6J26kDYazKu4W757aSiAnjrZ009XQ4vif4tmYXUSHXSW
         Xnqx5b8MdUgCjauglLfZ1VEgxtIch05VWSnKBU6r1tJH+0852BYPo4V/AzZn6JPrRPIf
         sM6AV12jy5ig7r6T6e60msh/tiVMl9nRP1SGgOOYknkekrqmR0DhR2vkPjkHy8p5NVAU
         2HLuYFk6MsK8gkDOBkrtrvuBmfs0wySwR9NC/wddF0Kdiu3UuIKHjC8pDr2vwnYNFGPA
         0k4w==
X-Forwarded-Encrypted: i=1; AHgh+RrlIUnzJL1ChpjYILRf4Dx3ozLzgDlkGmc+4EEyXyqf7ZYylc6KlQrgnEkGvJPjiPl5yhcNrc+/XD0=@vger.kernel.org
X-Gm-Message-State: AFuF++kGIuFzd3J0ekOQ0kTuH3vjkPAEEA2WmVflUVhjlTnmjX8wZz7/
	NXfv7AQQ8dY10TTGhPpMEt/fjvDG0Hp24bxk4ZZcO+lD4IC/FZhjsoMN
X-Gm-Gg: AR+sD10lFxfBB/5Q5Lyx+PLwa2djHqFUgXD4AjL3tyBk8wuZ/rF4kJ5UEDB5x/VGHrV
	QrHsVmn2AJWuXvXkCej2t0hH58PjpoijX5W3LQkfTVnGYwkX3g8RwPO+jS/02x8lF0gzYXmwn5l
	hCNe6yLj97MO5UeoWu+fy5aNi1xPh6iXCjRUn4oDhEBs8JO/8r8hvDttP/a5UY4Tf9gxt6Pzyy7
	KhaOFJo4CL3XhBqhrnaDHESet8dFyNfzpNM06KIInXb3qxneOozZsctuwvEgIImUm9aNIENvoBp
	A0nyyVWrBP8AbqqQDO0QtlLX4buXEONQvSw9LOzUy7c3WKTQGVgewaLY97tp1Jwina8zYAYFGBx
	9CDnPoHSZtXkJLxnMgA1z1c/HmmZ8Ppn0bx3twRNNrYrpaS8Ik5DoCJNAj2UNwbLVSmvqeJd+gB
	uEVu4NK7eF4/rJRUhjJzLVicbivIfniopy0bm3UNZm4Jpzf6amM8KviBqumlkJosTCu1k=
X-Received: by 2002:a53:4903:0:b0:66c:d36f:d2ef with SMTP id 956f58d0204a3-66d2575b4cemr760121d50.32.1787707859198;
        Tue, 25 Aug 2026 18:30:59 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66d2457c083sm783271d50.5.2026.08.25.18.30.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 18:30:58 -0700 (PDT)
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
Subject: [PATCH net v3] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Tue, 25 Aug 2026 21:30:37 -0400
Message-ID: <20260826013037.6933-1-blbllhy@gmail.com>
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

Fix by adding kvaser_usb_hydra_cmd_size_rx(), which checks whether the
size field is complete before reading it and rejects zero command lengths.
The asynchronous receive path preserves incomplete headers in the leftover
buffer and completes them from the following transfer.  Clear malformed
leftover state before returning so later transfers do not retry it.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Link: https://lore.kernel.org/all/20260819145658.29872-1-blbllhy@gmail.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v3:
 - Preserve fragmented command headers by distinguishing incomplete size
   fields from invalid zero lengths.
 - Complete a fragmented extended size field before reading it, using the
   actual valid leftover length.
 - Link: https://lore.kernel.org/all/20260824214058.44948-1-blbllhy@gmail.com/

v2:
 - Clear malformed leftover state before returning.
 - Reject command lengths shorter than the buffered prefix.

v1:
 - The zero-length command loop is also addressed by:
    https://lore.kernel.org/linux-can/20260815-can-esd-hydra-fixes-v1-2-de644cbeaec2@ikuyo.dev/
 - This patch additionally handles truncated command headers in the
    synchronous wait and asynchronous receive paths, including the
    leftover-buffer path.

 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 70 ++++++++++++++++---
 1 file changed, 62 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index efbb7bed34c9..eddd207ee8da 100644
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
@@ -675,8 +693,10 @@ static int kvaser_usb_hydra_wait_cmd(const struct kvaser_usb *dev, u8 cmd_no,
 			size_t cmd_len;
 
 			tmp_cmd = buf + pos;
-			cmd_len = kvaser_usb_hydra_cmd_size(tmp_cmd);
-			if (pos + cmd_len > actual_len) {
+			err = kvaser_usb_hydra_cmd_size_rx(tmp_cmd,
+							   actual_len - pos,
+							   &cmd_len);
+			if (err || pos + cmd_len > actual_len) {
 				dev_err_ratelimited(&dev->intf->dev,
 						    "Format error\n");
 				break;
@@ -2110,6 +2130,7 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 {
 	unsigned long irq_flags;
 	struct kvaser_cmd *cmd;
+	int err;
 	int pos = 0;
 	size_t cmd_len;
 	struct kvaser_usb_dev_card_data_hydra *card_data =
@@ -2120,24 +2141,53 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	spin_lock_irqsave(usb_rx_leftover_lock, irq_flags);
 	usb_rx_leftover_len = card_data->usb_rx_leftover_len;
 	if (usb_rx_leftover_len) {
+		const size_t cmd_size_field_end =
+			offsetof(struct kvaser_cmd_ext, cmd_no_ext);
 		int remaining_bytes;
 
 		cmd = (struct kvaser_cmd *)card_data->usb_rx_leftover;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		if (cmd->header.cmd_no == CMD_EXTENDED &&
+		    usb_rx_leftover_len < cmd_size_field_end) {
+			remaining_bytes = min_t(int, len,
+						cmd_size_field_end -
+						usb_rx_leftover_len);
 
-		remaining_bytes = min_t(unsigned int, len,
+			memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len,
+			       buf, remaining_bytes);
+			usb_rx_leftover_len += remaining_bytes;
+			card_data->usb_rx_leftover_len = usb_rx_leftover_len;
+			pos += remaining_bytes;
+
+			if (usb_rx_leftover_len < cmd_size_field_end) {
+				spin_unlock_irqrestore(usb_rx_leftover_lock,
+						       irq_flags);
+				return;
+			}
+		}
+
+		err = kvaser_usb_hydra_cmd_size_rx(cmd, usb_rx_leftover_len,
+						   &cmd_len);
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
-		       remaining_bytes);
+		memcpy(card_data->usb_rx_leftover + usb_rx_leftover_len,
+		       buf + pos, remaining_bytes);
 		pos += remaining_bytes;
 
 		if (remaining_bytes + usb_rx_leftover_len == cmd_len) {
@@ -2154,9 +2204,13 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 	while (pos < len) {
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
2.55.0
