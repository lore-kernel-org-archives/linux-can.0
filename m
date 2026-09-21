Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46F1A6834
	for <linux-can@vger.kernel.org>; Mon, 21 Sep 2026 06:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789970961; cv=none; b=FCtuiuk+57L2wExPeuuD8qzYRsUKVK8o/v7VtoMhoKS7WB9PyWwpX9FlTvYYxKJH/x3QNMUmtwLnqHj9mu5hH7RnqN2HWbtqikwI+aa+5LRO1qW8xTsSEfzqKYqrTgJfrQkT4/S2hpD81XSq9km5f8nYYnCdk1vuLbiREjKG9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789970961; c=relaxed/simple;
	bh=5e1DN0MH+2uhstHQPY9yvSOiQBlfYmFimowFYKSkVuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fl/rFlvAo+frvXv5MvFpRcMTJrS24MM1C/BZmP3bArBxxtScjelb9+uwxJeW4S1xQhUOkJc7y+f1vk8nt13+czSxQGR79KZ3hgApe84m2jDO+T6rtKfnBkr6rtQmWCMpZ3mjleJRYbm/OC6uG6/7xiRVLR1oZN9XJC4v3NkztV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacecubics.com; spf=none smtp.mailfrom=spacecubics.com; dkim=pass (2048-bit key) header.d=spacecubics-com.20251104.gappssmtp.com header.i=@spacecubics-com.20251104.gappssmtp.com header.b=N3iOXIwJ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=spacecubics.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=spacecubics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacecubics-com.20251104.gappssmtp.com header.i=@spacecubics-com.20251104.gappssmtp.com header.b="N3iOXIwJ"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso2545091a91.2
        for <linux-can@vger.kernel.org>; Sun, 20 Sep 2026 23:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spacecubics-com.20251104.gappssmtp.com; s=20251104; t=1789970959; x=1790575759; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Wqlm2oKxQsTu2i23sWiXCPOdJxQdXfXmPVhtM0Xyv9w=;
        b=N3iOXIwJ0z/jlax3Fiu6BpYnaPF6neEeJEt/b8P3htrxe2k06KZRHbU4EM/6wAU8CV
         T3q1zryvk/+11u7rhnaTRjX9ehqNpYuCUeiJmGbnwPStHYhh00ymX54S1Cum1BEJpU7f
         XlnMMfnT5oVWo83a5oQLp+2P9o0xsy9t2mBY0cla7ttC2oDztdiKBzfevJNZYlC9Jm76
         jfPTHYynVztttBOVKhqI1KfIxxoBtgg0XWxzVUtogBUKPO9vt8DsfoxXvdKV1FnOR5qh
         Y82b6ZJV0dR3L1lolultWLwA8w+i2sEM16Co9RAgeJw8vAnksWkDmV4lQsKarn5g0+sb
         RZ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789970959; x=1790575759;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Wqlm2oKxQsTu2i23sWiXCPOdJxQdXfXmPVhtM0Xyv9w=;
        b=VcRUld6sqn+EfMeDkqGazNurKuRUxwtcyeQsXqNy0s+cd7u+3v9gv/6geiJTe5sqEU
         2lLQrlf7G1bcC4FZzdVn1oa+86KurwU9zIx8Ah+OsiTkbRAlPU5LKxLggbmu+8zYTCyM
         d7xu70/Fx7Z5e0T/aOlSsQ942zPXrjTtVJF0M/T75YAhXY/1sdv2by2z6+zcQ3Em/Yuy
         nsikzO2yfjURUl6tPtpZwuCVLGyD4GTbGXUwy0/NOLJjfLRi+n4Xxk6vjivgZ0mK0oji
         XW8PT7PSuijNUC120Ylp/Uc5bxhSuUPini9NSpccvCxXeNsyasLuqrn7hCZdOuiw4v+t
         6Cjg==
X-Gm-Message-State: AFuF++lGElPJSmMCq1/NAbAFRk5h8cllPZJWuzndQdeaYsKAQ2xHG3Ix
	dMfLKUpb1KETMA50lAyYahtciP/zKQon4pmY7TfDO/ZWf7B6WZKP0+IWeY2kdDm5RRY=
X-Gm-Gg: AYBFou1iJE2ZucLlAK/96rjmZ5sy8fDVdeUA9unFVz+yyJ45Bm98rMD+j3Z2uTPvmUB
	i7rg0sOBhm2dexvRRp26FydMqvk9FQhyNgzfAsceHFgRSaqHIytGPkeOpbAdEdsyHOLRCxnTW/i
	ZtYIgFS+JQQbhECVSKZ9TpdvVaTcvoOW86qmJ/feigH8cljKPfILBtKvr0Po83hML5k/sFpXiQZ
	6yy5mEqN9MGuYFTaGuBoFxGeBBKi9f2LW04rT3iuQg5xmqHAvh80vybcOK4r4WkKtZvAb8HbCA2
	V8VkWcYd3Vgw4ndiDJYtZcUcZytc1tNQQXWEZqipoQkag0jj5vdi2KLL5oEInOs+E/wffVzjTev
	6rM5ST2CS4qhYCF0v4QJalEu1pAREIua/fSyUn2aa4XGYnqhviYKgsoSEufiZZlOo/kYRTrgRg/
	MlYOZ1+U0VUsWcLlcHxICzcgw1VMQ8ZlB+cfyU2N/qJBzn30M3qhHQjQQ1CwQu12Eu25BUPrdvo
	SalQAX0LF7uhH1GKjH/6IyCYv7Q4Se36TNb0LlBWw==
X-Received: by 2002:a17:90b:2584:b0:39e:6c68:c787 with SMTP id 98e67ed59e1d1-39e6c68ca2emr8661197a91.61.1789970958653;
        Sun, 20 Sep 2026 23:09:18 -0700 (PDT)
Received: from [127.0.1.1] (221x245x252x90.ap221.ftth.ucom.ne.jp. [221.245.252.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a031d63ca9sm7736324a91.14.2026.09.20.23.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:09:18 -0700 (PDT)
From: Maximilian Zimmermann <maxz@spacecubics.com>
Date: Mon, 21 Sep 2026 15:09:10 +0900
Subject: [PATCH net] can: xilinx_can: set CAN FD flags on received frames
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-fix-xilinx-canfd-flags-v1-1-a371c90b4e7c@spacecubics.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAxFf2Xk2cBadDp/RXzo2mRGRibNlMLYv
 1vd47ncc1YwykIG12aFTB8xmbWCOzQQH0FHQkmVwbe+a3vvkKVgkUm0YAzKCXkKo6Ebjunkzsz
 hQlDlV6b6/IdvoLTAfR/tPTwpLr8kbNsXOLaTT38AAAA=
X-Change-ID: 20260921-fix-xilinx-canfd-flags-1b4d517ffa8e
To: Harini T <harini.t@amd.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>, 
 Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc: linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Maximilian Zimmermann <maxz@spacecubics.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789970955; l=2529;
 i=maxz@spacecubics.com; h=from:subject:message-id;
 bh=5e1DN0MH+2uhstHQPY9yvSOiQBlfYmFimowFYKSkVuA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgTdhHxRWjd/5fTnSCl2OntVxEesqbE
 9i5nsw3HMsMZQEAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKXfMkUxdDkzbUxrYqcR9CmxaEoMSR48XP0S0bdMqlRh9gJxY12FDmi0dDFtQsct5b1Va9/oXnU
 BgiIyHvpargc=
X-Developer-Key: i=maxz@spacecubics.com; a=openssh;
 fpr=SHA256:0PWSMXfOZY6FZQRGGLZq/AMDyoKTiLmNTaQ2XShpqeA

The Xilinx CAN FD controller reports the bit rate switch (BRS) and error
state indicator (ESI) in the receive buffer DLC register. The receive
path currently uses this register to determine frame format and payload
length, but does not set BRS and ESI in struct canfd_frame::flags.

This results in applications being unable to receive the BRS and ESI
flags, even when the controller correctly received them.

Add the ESI register mask and copy the controller flags to the
corresponding SocketCAN canfd_frame struct.

Fixes: c223da689324 ("can: xilinx_can: Add support for CANFD FD frames")
Cc: stable@vger.kernel.org
Signed-off-by: Maximilian Zimmermann <maxz@spacecubics.com>
---
Tested building against net/main and backported
linux-xlnx (31626ef92ff1).

Also tested runtime on the backported linux-xlnx kernel with
QEMU Xilinx CAN FD 2.0 connected through host SocketCAN to a
physical board via candump. Verified reception with and without BRS
using frames transmitted by the board. Send an ESI frame using
cansend on the host and verified that both QEMU and board
reported ESI.
---
 drivers/net/can/xilinx_can.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 43d7f22820b8..52661e088205 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -157,6 +157,7 @@ enum xcan_reg {
 #define XCAN_2_FSR_RI_MASK		0x0000003F /* RX Read Index */
 #define XCAN_DLCR_EDL_MASK		0x08000000 /* EDL Mask in DLC */
 #define XCAN_DLCR_BRS_MASK		0x04000000 /* BRS Mask in DLC */
+#define XCAN_DLCR_ESI_MASK		0x02000000 /* ESI Mask in DLC */
 #define XCAN_ECC_CFG_REECRX_MASK	BIT(2) /* Reset RX FIFO ECC error counters */
 #define XCAN_ECC_CFG_REECTXOL_MASK	BIT(1) /* Reset TXOL FIFO ECC error counters */
 #define XCAN_ECC_CFG_REECTXTL_MASK	BIT(0) /* Reset TXTL FIFO ECC error counters */
@@ -959,6 +960,11 @@ static int xcanfd_rx(struct net_device *ndev, int frame_base)
 
 	/* Check the frame received is FD or not*/
 	if (dlc & XCAN_DLCR_EDL_MASK) {
+		if (dlc & XCAN_DLCR_BRS_MASK)
+			cf->flags |= CANFD_BRS;
+		if (dlc & XCAN_DLCR_ESI_MASK)
+			cf->flags |= CANFD_ESI;
+
 		for (i = 0; i < cf->len; i += 4) {
 			dw_offset = XCANFD_FRAME_DW_OFFSET(frame_base) +
 					(dwindex * XCANFD_DW_BYTES);

---
base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
change-id: 20260921-fix-xilinx-canfd-flags-1b4d517ffa8e

Best regards,
--  
Maximilian Zimmermann <maxz@spacecubics.com>

