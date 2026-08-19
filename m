Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4445347A860
	for <linux-can@vger.kernel.org>; Wed, 19 Aug 2026 14:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151432; cv=none; b=aXMRkKZkUxxa/TcluZsviAl5c+0qQYLhoAu5jjMvVkEZCWknQigKMVFLlH6jCvvs3WksbwFb3sHMCC4CHxyRyyQgaqRMCSBcg++Kgwu7x6nDBijDJ8iU4mfDtVct+Azz0jlnUeprVm0CSTiISiTjkX/aycPepbYhBI9oYiMTJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151432; c=relaxed/simple;
	bh=n+/jxBonuUFEOu+l8/UycfkodOl6Ph+PFwwpLzlVvRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJrXWTHwwrnvuM6kKcGmq0EFdgJQn8r2TGI6Egrwu9ouTKm0MgBrx+8Pzn4uwMhdNimd3kqADxU+hwyWZ+RT5GhZ6iY6nsVN3sj5t5NmXJa+pVAr+3wgbtxlc/OMa+Qm8L7BxV+Tbj4ZRwUcjKKkLu2K9vOMpzTV1xijFEa1TZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SS0CmwVG; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SS0CmwVG"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-80cebd41372so18923727b3.3
        for <linux-can@vger.kernel.org>; Wed, 19 Aug 2026 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787151421; x=1787756221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v5e8TjtYhDixRiYQxUw92puCIFCu3Ty52Hj2lnvjnEg=;
        b=SS0CmwVGLtmeRGAU/LM7vdJ6SCi7CGeqWIgSuqyMuOiOGeTtw+/bFpy3VgVZasybJx
         VZaillWg84Fveg7lAk1Zz1OoD6aptumlAEr/0sWBowo1aKK71sPjdBeso3nV6KGtSFvF
         ASRAB/ecUN1qa9AYmfzDxb4IjziGIPxFnsUVcD6sDOYR/XQqXB74u3tCZ1PamzNkYnOS
         RHEjPPpi+qUcLWGPESP5D9y2zqsiyIur3IaaiNCEUKjVlpmf3bi6rLQyoUT0S1Hf1Ld+
         dVQY25nF6dyIAMzmbo0bLbzibSoK5t00gLwWpNDrEilq7PzNHB5I/g/snD/7NqXyytCn
         31fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151421; x=1787756221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v5e8TjtYhDixRiYQxUw92puCIFCu3Ty52Hj2lnvjnEg=;
        b=BtGEcEHssP1nNzrBeiOu1Ef08kRDlks1EVgpxle/AZyvxu17eDcXUWDF8LJBCvvlcJ
         M7h/1DVfpIP5TDZS2+b2pSHodJKaM+b4gpC3aMwwNQZG/ldb4wuBOUKRlfiy78vLkP2Z
         J3U5hvR+bqwSMRazcBCQu8Fz19d/YzR44b7bLkY4JuBY26OthEHyISSbNh97xhi7XP+W
         ZdqaGp3xyNcQ06dV82JSpnS/7lvU4l3nQXAwBL7vqUWXsNr7FegzNRhM8w5aNrjD2hJV
         59Z2wJZ5Ri8FB2Dg7ToG2EzJ0DC96lEVdaLQsvGJTPVZmLmRAi9/5epiUbmi6mefnsZV
         1sxA==
X-Forwarded-Encrypted: i=1; AHgh+RoaWrB8N/p7v3PZq31MyJZt79U5sCaNjq1PG2vmU8BxnVmmkk1KS3uoPOrnHJLhTlO2p16og+s6qoE=@vger.kernel.org
X-Gm-Message-State: AFuF++nSn0PGmMQGnXKeHTz1amb1tBorKt+3hSj5PwRdd9ujqnva0/Bd
	NGF7aQfCdBo9GZGSsPOYO98KEoRIr700PwFThu8bf+rh7BIFCfF6ghvr
X-Gm-Gg: AR+sD1245nQB7N12cUuPJszM4ARaVTGn9IaFjJ8vd59f1TRqN01QTH9OWDtRkakYWV9
	ZsuM7i7BYPFfz60rMv+ukS2Akr6YTvxBGPORJ3u8P0xRRVjffNx1erbnEZdtBXGmb6wc/asUt1g
	new6pJb6XpLYwjhHtNhu9VHrYPcH6NvN+/VNguHLX1eupSst9abjSu5La5XCEZVgwC88kFFBu4+
	Xdg+y+P9qzfTVpIAyosAaZKfY8i/x0Zrum2NDs6PXqZOMV8vJCVC+/ruFGR109t9zqwXL0E+1R6
	LtropjSOCNPenkXNnvDQ+h6CVtQ6dq8+2eIKgOP1ksdTkNxSKp7dXyn7DAx26W0JZbimK2a/MLj
	njjD2ojbQeQToTyFniL3SoNKDxIq/k6TNUPCjVaj6jZ98ldtpvqzeGwO431UN6nCuXU0tcbZkRq
	1VnMJRG5ghslYp2FC/1FyyHpeMscBG8DfIYY0Tvd87dp3heP7eANhhivU21URFIFb2+ik=
X-Received: by 2002:a05:690c:d89:b0:81f:49e1:1f03 with SMTP id 00721157ae682-844e4ed8f40mr20766227b3.31.1787151421114;
        Wed, 19 Aug 2026 07:57:01 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-845182ddaa5sm10139897b3.34.2026.08.19.07.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 07:57:00 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: mkl@pengutronix.de,
	mailhol@kernel.org
Cc: nihaal@cse.iitm.ac.in,
	eritque-arcus@ikuyo.dev,
	kees@kernel.org,
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
Subject: [PATCH net] can: kvaser_usb: validate command format before parsing in hydra receive path
Date: Wed, 19 Aug 2026 10:56:58 -0400
Message-ID: <20260819145658.29872-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.52.0
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
Callers check for zero return to reject both issues above.

Fixes: aec5fb2268b7 ("can: kvaser_usb: Add support for Kvaser USB hydra family")
Reported-by: AutonomousCodeSecurity@microsoft.com
Reported-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Reported-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
The zero-length command loop is also addressed by:
https://lore.kernel.org/linux-can/20260815-can-esd-hydra-fixes-v1-2-de644cbeaec2@ikuyo.dev/

This patch additionally handles truncated command headers in the
synchronous wait and asynchronous receive paths, including the
leftover-buffer path.

 .../net/can/usb/kvaser_usb/kvaser_usb_hydra.c | 34 ++++++++++++++++---
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_hydra.c
index efbb7bed34c9..a964edde5783 100644
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
@@ -2124,7 +2139,14 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
 
 		cmd = (struct kvaser_cmd *)card_data->usb_rx_leftover;
 
-		cmd_len = kvaser_usb_hydra_cmd_size(cmd);
+		cmd_len = kvaser_usb_hydra_cmd_size_rx(cmd,
+						       KVASER_USB_HYDRA_MAX_CMD_LEN);
+
+		if (!cmd_len) {
+			dev_err(&dev->intf->dev, "Format error\n");
+			spin_unlock_irqrestore(usb_rx_leftover_lock, irq_flags);
+			return;
+		}
 
 		remaining_bytes = min_t(unsigned int, len,
 					cmd_len - usb_rx_leftover_len);
@@ -2154,7 +2176,11 @@ static void kvaser_usb_hydra_read_bulk_callback(struct kvaser_usb *dev,
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
2.52.0
