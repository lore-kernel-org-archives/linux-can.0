Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793357109;
	b=P5oErzRjbvpSOyX170xq++imJtMeIr22muLHlBinyF3mQkLjWx8Vdf2YIdXGljJ47bdE
	 YtZPY/ljXlJuqkYWIENb+dg86jhGn9KF6SFavT7JJQChRbcUXwnxIHwFU1/JbGXqB1Ewv
	 92TguVwGkcPpEjcoR0eE+E75JPNpClIno4ITt0t4df0jH5PbMeuxgrHMRKwQEZAcyOAMz
	 NBT7JdFtKLLrDUbNgWVZn/r7NLmgKrSdngc7wvvICxYiRzIQCLUtrDO6jasUZeofQ/Uxc
	 4eBj9zZ+d0tZiVB/PWtfb2s+tpdQ3TXhW6BAijhLgNh5WPKC9+a0Rsjcst9L7HcTywA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357109;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PeMcAUOgzVtxioPnFgylSSIopZwrQmC6hhu7bNACXk0=;
	b=R2UUrwcuBoFCxf9hfOs7XHvEf4AtGU37n6SyTLkAhtsxG8CalNbpzZYiHsYwNyyBzlM7
	 QBqoXadbh7ZsOtJy3mZmzS0asQBs62huOkrBz5tc9ONIglFg0CvPyMr3yyJqSifLeUGCq
	 NvPK2Q6HYBM99MdpONsUNfHitlWjx5HIjf39PTzL0Up1BMHuYy2jER5Xh6j2FIPhjg+if
	 Nr0AlYDghh+YLxSUBFxQVrGo9hL7pso5ol60di2Idx+/OVx/fg18BNfcNK/H5xT1nqy/H
	 NKC1vDRrl98NtajcRE7y3yd+ztso2fMaeqOhao2uPCj9WEAC/FeG+fOAxpoMv4lO1Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkV22DRI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C1160A2612;
	Fri, 30 Oct 2026 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CkV22DRI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793357108;
	b=1B83EIyH9Xq/OZq53kNGk1P6zl1WwPRkJiIxacUFBkVIfioa8VEVe6K/GCgNiTeTCk2a
	 PrwGpL3JI/8XaC3558HrVSWxvgmtUuIlpbSietAOVvnEYC8zfmTV5ZN/fqvFANpudmKFT
	 1hQ9O8uk/UX+dbtK/Z10wO+povtk9Zcu+2+bObgzH6tvKGLBHEYi7GcG6tvFBmugIq+4w
	 YpA6uNG4bSbS9d7VHpD4PFXjD+pATVYHJy7+hWUc4Bo+QUESwzxjtQXzIqlLwET/HuJH/
	 ZHEoAKlBN90NtcPxmsDmH3U7KA+vIBnm+GDqM4D0FnJXPHwBIguoTltBNHkG6KqyJ8Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793357108;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=PeMcAUOgzVtxioPnFgylSSIopZwrQmC6hhu7bNACXk0=;
	b=AZX3RzuaAydNZ6msj2W95SNQ2AGnkziMHF0KINUkxTbCJT/GYmUQnnaUfZNSQ4a2f1z6
	 0x0ypp7tKK6f1Z4LeHYIe+46RRGVKNnuBoPw7Y7KJMA4iZOdyYPCc8degLJI8zPaC4O+S
	 LULrnARgx1efITVejT1XGMJpm7lEbDLcKr6s/M9ZTqsWPBtnfLZWauyYx1scjpqWERage
	 joUyGLp1MObcZdrxN4GzcTkUpjlswRrAojC2fV7hZfm7KOVbJ/Tl2Gx2bzJC87VIcMe5N
	 YPzZ1HOMO5Gd/VlaUJiYOL0radCeBmSGJsw5e4o72U6m5CTGvjeaPp2syI8nv7YmkXQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5DA481F000C1;
	Fri, 30 Oct 2026 10:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357108;
	bh=PeMcAUOgzVtxioPnFgylSSIopZwrQmC6hhu7bNACXk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=CkV22DRIna2zctketUvH3IgrAgyTr+eP748heHltr7jx1isbftnG1g3WoLASSmAaQ
	 g5lmIpOBgKG3ryvcbWj8cbxrYeLEfN65rXI1xlN1vQxP7qPI4FqQG0+ji8KmV7BGUv
	 XN1GOYb2DVjnFX/7h9aNe9tDO9rk6T3vrr3+3DkXniTVY30v02nmEsztKdYgx21n91
	 eZgRpLm+jehCCtchGMS5Y+7s8WIZOmKO/vxozKIMRl+QyEWYIdE9lTBwKGRNCweg8k
	 2wcOgDw6pop5YraSGk9H5f+Lr+WZ1Cuz4euWIAjRo5HsN7GyLa/B1BWKNHDF9MsDPd
	 pvuCqK65nLDFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C5C514375E;
	Fri, 30 Oct 2026 10:45:04 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Fri, 30 Oct 2026 11:45:00 +0100
Subject: [PATCH v7 11/13] can: peak_usb: don't read past the message in
 PCAN-USB Pro decoders
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
Message-Id: <20261030-canfd_check_channel_idx-v7-11-fc4a3faf3acf@peak-system.fr>
References: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
In-Reply-To: <20261030-canfd_check_channel_idx-v7-0-fc4a3faf3acf@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793357103; l=3340;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=hez4z54jzy+0+IuvzPEHtRrty5qZlgBrFzDpTVvDVR0=;
 b=hrVtkQawd41S6xgMAVFR22zguJ87wDUyK3dAW91At9DSd/BqIjuYTlqGg5BHy9veOgnXX9UtQ
 7U8247VZVyeBkvHHyieAWKEgDtKcj6qt5lIPCFnA6Qfm6RmqCOkzNZO
X-Developer-Key: i=s.grosjean@peak-system.fr; a=ed25519;
 pk=bP7QV2zvvAKAfConZlUOGKGEcXL64SNUpVUm++Ai+/c=
X-Endpoint-Received: by B4 Relay for s.grosjean@peak-system.fr/20261020
 with auth_id=1250
X-Original-From: =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Reply-To: s.grosjean@peak-system.fr
Content-Transfer-Encoding: 8bit

From: Stéphane Grosjean <s.grosjean@peak-system.fr>

The messages received from a PCAN-USB Pro device start with a record
count, followed by records whose size depends on their type, given by
their first byte. Both pcan_usb_pro_decode_buf() and
pcan_usb_pro_wait_rsp() trust this count:

- pcan_usb_pro_decode_buf() reads the type of the next record before
  checking that this record starts inside the URB. When the device
  claims more records than the URB holds, it reads the byte following
  the URB data, which is beyond the 1024-byte RX buffer when the URB
  fills it;
- pcan_usb_pro_wait_rsp() doesn't check the records against the
  received length at all. A truncated response is then accepted, and
  pcan_usb_pro_get_can_channel_id() returns stale bytes of its own
  request as the channel id. With the current callers, the walk only
  stays within the command buffer because its unused tail is zeroed.

Stop decoding a message at its end in both functions, and in
pcan_usb_pro_wait_rsp() also reject a record that doesn't fit in the
message.

Found by Sashiko AI review.

Fixes: d8a199355f8f ("can: usb: PEAK-System Technik PCAN-USB Pro specific part")
Assisted-by: LLM
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index f94494e01f4a..b869a20438cf 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
@@ -244,9 +244,9 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_device *dev,
 	for (i = 0; !err && i < PCAN_USBPRO_RSP_SUBMIT_MAX; i++) {
 		struct pcan_usb_pro_msg rsp;
 		union pcan_usb_pro_rec *pr;
+		u8 *pc, *rsp_end;
 		u32 r, rec_cnt;
 		u16 rec_len;
-		u8 *pc;
 
 		err = usb_bulk_msg(dev->udev,
 			usb_rcvbulkpipe(dev->udev, PCAN_USBPRO_EP_CMDIN),
@@ -271,13 +271,18 @@ static int pcan_usb_pro_wait_rsp(struct peak_usb_device *dev,
 		pc = pcan_msg_init(&rsp, pum->u.rec_buffer,
 			actual_length);
 
+		rsp_end = pum->u.rec_buffer + actual_length;
 		rec_cnt = le32_to_cpu(*rsp.u.rec_cnt);
 
 		/* loop on records stored into message */
 		for (r = 0; r < rec_cnt; r++) {
+			/* rec_cnt comes from the device: stay in the message */
+			if (pc >= rsp_end)
+				break;
+
 			pr = (union pcan_usb_pro_rec *)pc;
 			rec_len = pcan_usb_pro_sizeof_rec[pr->data_type];
-			if (!rec_len) {
+			if (!rec_len || pc + rec_len > rsp_end) {
 				netdev_err(dev->netdev,
 					   "got unprocessed record in msg\n");
 				pcan_dump_mem("rcvd rsp msg", pum->u.rec_buffer,
@@ -745,8 +750,15 @@ static int pcan_usb_pro_decode_buf(struct peak_usb_device *dev, struct urb *urb)
 	rec_cnt = le16_to_cpu(*usb_msg.u.rec_cnt_rd);
 	for (; rec_cnt > 0; rec_cnt--) {
 		union pcan_usb_pro_rec *pr = (union pcan_usb_pro_rec *)rec_ptr;
-		u16 sizeof_rec = pcan_usb_pro_sizeof_rec[pr->data_type];
+		u16 sizeof_rec;
+
+		/* rec_cnt comes from the device: don't read past the message */
+		if (rec_ptr >= msg_end) {
+			err = -EBADMSG;
+			break;
+		}
 
+		sizeof_rec = pcan_usb_pro_sizeof_rec[pr->data_type];
 		if (!sizeof_rec) {
 			netdev_err(netdev,
 				   "got unsupported rec in usb msg:\n");

-- 
2.53.0


