Received: from qmail.kvaser.se (static-195-22-86-94.cust.tele2.se [195.22.86.94])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16AB46F4AD
	for <linux-can@vger.kernel.org>; Wed,  2 Sep 2026 11:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.22.86.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788347651; cv=none; b=TUEMNNpBSIek89Aa+4AUITrpr0asTx7fcr7Tnjceu8LXcxMth/tVQSQFUx++qaWIBkdZfvEqpwAUVjfVxntVXKN/D2HCbqL2utBThalleZEDqvmz6FnLikKXmg+dPLIntzeEgC6ze3XunK6n+Bs/Ud72Q+Rhq9lbftULZcr5kf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788347651; c=relaxed/simple;
	bh=HGM65cv719ZC+1R/xgbGdoc20DgVqLAw64S+TznTSfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sa5T9Ejgpl1FrTvkMZ1Cl/9xmArBKt2qbs/J7uTDFcmxmq6Gz7aPWuq61kVae2vcd6aPLY9vO7RPKSvUlGRrQ3gKf68C5p6QZ6Ozc+VeyGB8pTaSHxkYE7tGLwT6Sm6mrI/uooynWCBtGPbxlfphpwJcsrl/6/eSsoQ6d2IHg8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=m8JT2f5w; arc=none smtp.client-ip=195.22.86.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="m8JT2f5w"
Received: from ATHENA.kvaser.se (ATHENA.kvaser.se [10.0.3.118])
	by qmail.kvaser.se (Postfix) with ESMTP id DD177E3015;
	Wed,  2 Sep 2026 13:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kvaser.com; s=qmail;
	t=1788347191; bh=HGM65cv719ZC+1R/xgbGdoc20DgVqLAw64S+TznTSfA=;
	h=From:To:Cc:Subject:Date:From;
	b=m8JT2f5wwgF6AcRfI0m85zz06JxHjOffvgT8YHtVhyUg7j4Ag4wKoU9dLuFX4Wd4w
	 pS7mqKT7RXiYMmCLKm6It7616boQJ/rv12Qykl4nl7mUCEr8CvBogLGONvPoK20/KK
	 FfdqvXN1Oe/D29mTF0Nvn9SDD/VkoTkYFgoOEpA9+XN5hZWI7wP6aYvu+zQz0SWP/S
	 bjs4Yr1MDGX0BkIqt1AiXVFhBniCmxfyVuVfMVHzOjthkUCJvZEz/1HtGzAVWp5PT+
	 kLsFOPP4BSZB7gHEMAcZsQG9Sgr+YPg1moFtgQ/EQ+mGYVf/1mZG8rDCIa/qg0jns5
	 6Cpm6v+Bb6b5Q==
From: Anton Olsson <anol@kvaser.com>
To: linux-can@vger.kernel.org
Cc: Anton Olsson <anol@kvaser.com>,
	Farhad Alemi <farhad.alemi@berkeley.edu>,
	Jimmy Assarsson <extja@kvaser.com>
Subject: [PATCH] can: kvaser_usb: fix potential crash in probe
Date: Wed,  2 Sep 2026 13:06:11 +0200
Message-ID: <20260902110611.2426535-1-anol@kvaser.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The leaf driver does not return any errors when no clock configuration
can be found, and instead it emits a null-check warning. Add default
cases to return an error when no matching clock configuration can be
found.

Signed-off-by: Anton Olsson <anol@kvaser.com>
Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Link: https://lore.kernel.org/linux-can/20260828-sassy-ammonite-of-focus-b2f17c-mkl@pengutronix.de/T/#t
Reviewed-by: Jimmy Assarsson <extja@kvaser.com>
---
 drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
index a876c7819b81..2091de2e4f8f 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_leaf.c
@@ -747,8 +747,8 @@ static int kvaser_usb_leaf_send_simple_cmd(const struct kvaser_usb *dev,
 	return rc;
 }
 
-static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
-						   const struct leaf_cmd_softinfo *softinfo)
+static int kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
+						  const struct leaf_cmd_softinfo *softinfo)
 {
 	u32 fw_version;
 	u32 sw_options = le32_to_cpu(softinfo->sw_options);
@@ -777,6 +777,8 @@ static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
 		case KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK:
 			dev->cfg = &kvaser_usb_leaf_m32c_dev_cfg_32mhz;
 			break;
+		default:
+			return -ENODEV;
 		}
 	} else {
 		switch (sw_options & KVASER_USB_LEAF_SWOPTION_FREQ_MASK) {
@@ -789,8 +791,11 @@ static void kvaser_usb_leaf_get_software_info_leaf(struct kvaser_usb *dev,
 		case KVASER_USB_LEAF_SWOPTION_FREQ_32_MHZ_CLK:
 			dev->cfg = &kvaser_usb_leaf_imx_dev_cfg_32mhz;
 			break;
+		default:
+			return -ENODEV;
 		}
 	}
+	return 0;
 }
 
 static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
@@ -809,7 +814,9 @@ static int kvaser_usb_leaf_get_software_info_inner(struct kvaser_usb *dev)
 
 	switch (dev->driver_info->family) {
 	case KVASER_LEAF:
-		kvaser_usb_leaf_get_software_info_leaf(dev, &cmd.u.leaf.softinfo);
+		err = kvaser_usb_leaf_get_software_info_leaf(dev, &cmd.u.leaf.softinfo);
+		if (err)
+			return err;
 		break;
 	case KVASER_USBCAN:
 		fw_version = le32_to_cpu(cmd.u.usbcan.softinfo.fw_version);
-- 
2.43.0

