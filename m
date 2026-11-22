Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373341;
	b=dNdUJV3NcZC6Caq+V2TTIIiP5M6TZtIRReu1Z28dDeY7kBHyZ3pJkEKM5Mg4Ys6wa11j
	 4os9uPO38xTE1Vx+s2wdd+fiO4p3hC+/srEtfudHx9gfaKinb13Shm8BzdgliRsF5nadu
	 rtx3op04mS1IRWlbfsCpykSHYJ/X7PQjsXWxCvFKrf9a6mJdbQXrC6DpyxYod5xoLkw1c
	 wjHh6B7ae09C6hhWNMTVh8yM9tM7NdAhOZwbY76mMaPH38re4yKAog3M7SqV4BC4t+K/X
	 GIigaRUpqF1irD+lMLmGgLiWMv9HAEu4SYvnpZY2sT4J/iHDdwZr6T27Rvhbir6CpXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373341;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MRd0mDOfL51YFjfXbxCfucHvEQzYtjIEc2x9pbDRGiI=;
	b=UlNY2/R1NQRdymJVb2Vlja/o8DbJxR3dA+KIdStVcLzXq+tE9A7QTYg8OSPTznaDBWiH
	 fl8icT8HRyI1RE4EtO+Ay/KuZ/MftJJh4aAtUYTQ+z7YVwj6v/yrTgSUgdLHB3V7MIqGi
	 aWA9SWjyjmApTtpW+IqqXpUBsI7G1WW9/ZUX+9HIxIsXpCHL2o6/2f/t3NlkNi0lD1yVc
	 g8Yl8AtPGDEyAoKwreYAg91eOFp11mfPNNE8hgiNN75jUF4uFGzjoKWDwc3VVBIs/abup
	 p8Tc+OM6tiQzZwThXClTgVX2qw3EZyBrqW+E3AzPmaBc8rFAizy/Q00ptW11QosL3xQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WK5a50zQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F0606A685
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 18:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C74F0606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=WK5a50zQ
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2594F205B48;
	Sun, 22 Nov 2026 19:48:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRd0mDOfL51YFjfXbxCfucHvEQzYtjIEc2x9pbDRGiI=;
	b=WK5a50zQ9na/3caV37ZRwkX95BvTqud7CupYwzjUtquQxq4+dZ4Al/l+GCAr51N+xGYmDk
	0aYjgjnUsPiBwzqk09MIGIXCSCkY2xffe7ZLjmZ7FEAQFQLFdmytkREc1E2u1BBs704SUp
	e+iSfaVzB2Tt/CdPrFBa9EXy0a6LOtLhfkEd9296BBt1UYd7h6t4mgKZa8Ul1Mbl81qt8x
	9QRQJR9qbz4qUDN3Ls/EMFZm0AKJvLDf4SCxXumFx6A5RdHz/eCJ9Z66rW6WdnUShx9OPL
	ITFfemWeKb1Gxld4ZvoAmDNuY8tkNxfKXpoG+SQjIM0XZnhE8rgM5xZOt8E35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MRd0mDOfL51YFjfXbxCfucHvEQzYtjIEc2x9pbDRGiI=;
	b=W7YMnw2PDZ701cWoxQ5ZMQizgZ/EcBxC36jKZH7JLLnDMzn9K4EUfitGFhVGKJYnc/fOBR
	CUe8nGgjD3e2wYUpU5qv/yuziyHl5GdDWBVSVULTQyuOaptox0OfZqwYGMPvefSGqDIMex
	mjj33c79YeyzSzGb4h8vzm2hvZgfpJN2y6Q5l0YELOPw2o6GArYdQYT6KrRniOK7tt6mXJ
	DTZiMpMcf/FKMDnARRBWkD1bwK6Bu3jFs9ome6499dlv5jsi0DmP8rlNEYDdgDiRHeYAMt
	eWF8Djf+FVWfCYdB9atti6qWtpGDqE5D1xOst8R+7OBMWWzrPEUhwMvEUN+ovw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373331; a=rsa-sha256;
	cv=none;
	b=LlkGeaI3M9sLkmNJcbf0bvWmdTUCszHZFhtKU7r39hIGrKONK2neXCGfWr1MpICD+z/gGH
	lcCd1AXnItadyM9ODIn6Pa4cuxVy/Lrjae7tfkZVnTiJPm0zBTox48RgeCQEdUX1me+SHH
	PPnNy4kXFIxwnajd00uHY3cgb2h2vgJmx92w4/pvbqX7BRv88xr6vSkqs3fcjyZ+zBglI1
	2MgT2e3IX7uvWXeussytqj71m+xtra/JBjohCXk7dXTrxOwhJFkkfABYgJ3A6srjiOO+m2
	wsz22T8csfr247f+13tv7K9gULy3kAWBjxZ6bKHspYm8upwcMStHU3yCGwTc8Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:36 +0100
Subject: [PATCH can-next v10 12/14] can: gs_usb: gs_can_start_xmit(): mask
 invalid parts of CAN ID before sending
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-gs_usb-fixes-v10-12-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=2132; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=Vjeevcx1CeD5jIksX+gRvTwVZ/Nm9ihu9lQ7iEwZq6o=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmtuSZtjj4e/Ch3+qnrqo2qcfsNvv7/jjb1i33lvFv/
 5q5y7Oxo6OUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQAT4Vdl+KdxWfXMIbeN2//z
 1SdKNMfeSVZ0aza0vq+xMJIn8zzHn8sM/3M3fvxltmGLjLfr86c958Vn1EaUBjy3fLtAKLGCv/h
 JKwMA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

Both struct can_frame::can_id and struct canfd_frame::can_id contain the
actual CAN ID as well as several flags. However, not all of them are valid
in all cases and/or in the TX path.

- CAN_EFF_FLAG indicates whether a CAN frame is sent in the standard or
  extended frame format.
- A standard frame contains an 11-bit CAN ID; an extended frame contains a
  29 bit CAN ID.
- CAN_RTR_FLAG indicates an RTR CAN frame; however, this applies only to
  CAN-CC.
- CAN_ERR_MASK is used exclusively in the receive path between the
  driver and user space to signal problems with the CAN controller.

Remove invalid flags and mask the actual CAN-ID to 11 or 29 bits, depending
on the EFF flag.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 4aa674c743f6..b345ab34a200 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -994,8 +994,14 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 
 	if (can_is_canfd_skb(skb)) {
 		cfd = (struct canfd_frame *)skb->data;
+		canid_t can_id = cfd->can_id;
 
-		hf->can_id = cpu_to_le32(cfd->can_id);
+		if (can_id & CAN_EFF_FLAG)
+			can_id &= CAN_EFF_MASK | CAN_EFF_FLAG;
+		else
+			can_id &= CAN_SFF_MASK;
+
+		hf->can_id = cpu_to_le32(can_id);
 		hf->can_dlc = can_fd_len2dlc(cfd->len);
 		hf->flags |= GS_CAN_FLAG_FD;
 		if (cfd->flags & CANFD_BRS)
@@ -1006,8 +1012,14 @@ static netdev_tx_t gs_can_start_xmit(struct sk_buff *skb,
 		memcpy(hf->canfd->data, cfd->data, cfd->len);
 	} else {
 		cf = (struct can_frame *)skb->data;
+		canid_t can_id = cf->can_id;
 
-		hf->can_id = cpu_to_le32(cf->can_id);
+		if (can_id & CAN_EFF_FLAG)
+			can_id &= CAN_EFF_MASK | CAN_RTR_FLAG | CAN_EFF_FLAG;
+		else
+			can_id &= CAN_SFF_MASK | CAN_RTR_FLAG;
+
+		hf->can_id = cpu_to_le32(can_id);
 		hf->can_dlc = can_get_cc_dlc(cf, dev->can.ctrlmode);
 
 		memcpy(hf->classic_can->data, cf->data, cf->len);

-- 
2.53.0

