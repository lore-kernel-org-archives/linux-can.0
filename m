Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795683713;
	b=OMTEv0xRvoD0qNL+0gBMHvPsqNEot7H8JGohW83woKa469qGD9W7F5N7ss8YqKl0nW2T
	 bxHYDm99MBqMXUCl9gxaILWFnXLgnZLD7wes6g9fPQOBBU/c4yA9sj2sr/cO617PxAVKv
	 /p56CHnSG3nXoLJbI9JWTeVdrtg5Asp0DfEwWbjq5KjXfaHI1QrLrasRLSduxOSeoyvPv
	 ck55nxlk+pe2p1x9GaMWmvTOgFYSBctPAFeEgOxguTjmUu4fZtt/NHXPKjbjcwMNFYhFY
	 oIqcA86hfDohCsqT+ja8RI3CMu9F5fyNw1ZMK2evTD52uS5qTiTHrLOPiYaZ5DvEujA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795683713;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CCtmhGBWoatG6b7u0CoPx1QyYxtErEF/pCK0e8gTBLo=;
	b=odBlZEiXQkYN4bqmp/KEsMf/AJj8gMDeFqU5Si8b5fcUWzP5WNSROFkdyn1T0UePMVFk
	 pK/k4NjgfWiUondVX37h4KwLTJ4qFe9GIKmrVHdlpx2iLNG01p3g3HuhSZnp/J7qjauAK
	 17zDlYU2g8qoOOJ604u4WSf9tporDUi+5ELWCXsyoKBcWXfVE+VEnmUbKzl8FGb1oH/gT
	 jVtjH2RC4+g6fCk4HFwaRYii5R0GTv9R2+MApt1sq3Ojplk3UghD/9gmY4Z6OYfqhrhhY
	 xnfZfJ565E1fLp2WaVgvjc8oC3LoqioEISsngRkjdBFy2c6pOk2zP6p4cGHoDgkUaEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1MrFgrq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3689C606A31C;
	Thu, 26 Nov 2026 09:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b1MrFgrq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795683713;
	b=nJjxNtbrykrFaWK5YklKKj+n7HI0fWo1cb6UP4QZ57Nnzt05No43qcFZdTSej3tS+jIA
	 virU8bqRuRVpY2fCr/ytCsxkILF4Aj6TQV6ToN5FvN/8klUlNeAmqYRSDSm08lz2sG+lH
	 hkhsWy9MrYIJs9UTklN0/yxwGQAZ8Kq5+UR5TnzhzRD5lFsE9nKNK6H1vfigBV5QeQFOa
	 epij9u72HSRGEQAE8xT60AcsmLHb7P2nJiAMpZ6SJ5UGOuMSh+d/Vw4FwE4MqcHlIajVc
	 BCQpSSpaBR5PbeWa09nlCUGRcgFKCFveKHlMWkGg+XJeVB2th2mPN1iGsxgotDSARNQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795683713;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=CCtmhGBWoatG6b7u0CoPx1QyYxtErEF/pCK0e8gTBLo=;
	b=fzpDqUfCWRQPcNvJYmW2QO4Is7uGWFPFMP560Cdm817/wvqrHTS+UKTuKhUJj9tqO2Et
	 VeDt7DVUPRXEJf86Ij3ZVSa2yGxzTuooFWEjEQ+yPWk5eTanTjR6m4SLlwZn2wCpiPviI
	 rvgSgAdPoC8vfes4nPzr/wEN1Cv70r60qMvuB++2RaKxZj9w2T9jA+JoMr+YpLl+6PX0C
	 1fNIjYsAb2BzCD+LDh7hWGVGShKB8UZ7lkMTMypMkpSfQ2g614YCzNIhZ7dMiYCgXn+9u
	 DadtjgNZ5isAzuOiOAk3HYMkudHd7BtjbhuAsWLaFTjXt67Rd8XhMAIomLD0iX3WZJg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 59C151F000F0;
	Thu, 26 Nov 2026 09:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795683713;
	bh=CCtmhGBWoatG6b7u0CoPx1QyYxtErEF/pCK0e8gTBLo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=b1MrFgrqqKaeSyv1vLJnm3kEjkt6F3IZCcO2lmIb6RS1fozBU3n6YoD42GoBryXM0
	 fssfnWhkFCkX4K/UUBirwNY1aUur4J+mQYp1n8IPyN/SXNwQww+ZODwXzxwIOqCzIj
	 27/PJcIDEHS/XEgwqO0f+7JQVu36LXm1N/63IH1IXbv8g38xfTm8yZvEGyGJa0wZ7p
	 ip4ewg3KxiW4VLvfgjXs8lqoiO+0azsD9jUmgrXsJ2Ehqc2kMyqVE6MFO8BRfpl7fK
	 kvraqlq5wLnTOvs+/MKPbxItOsR+Feakf6Zm1bm5vvKnzPwbHhqLFXgnRohEaJjsNS
	 QhTe1Ge/YTZkA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D97864D332;
	Thu, 26 Nov 2026 09:01:20 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 26 Nov 2026 10:01:10 +0100
Subject: [PATCH v9 09/14] can: peak_usb: don't read past the message in
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
Message-Id: <20261126-canfd_check_channel_idx-v9-9-abe0099b4585@peak-system.fr>
References: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
In-Reply-To: <20261126-canfd_check_channel_idx-v9-0-abe0099b4585@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795683678; l=3322;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=a0th2wCPOOTAu4l4k7o1TksEPXcDtcculXGghFD2lYw=;
 b=In0lfa/8ZFR4mNBAzPPH3glmBNH7twdmwWExTZbZOveyOtiuLhR1GgouT4gQUpVvWHliz7yQ/
 iuBPAHGXiEED2eiCpS8/gVLT6eXXJ/PTFd7fLUDLiBkzZuHiJFDT6q9
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
Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
---
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_pro.c b/drivers/net/can/usb/peak_usb/pcan_usb_pro.c
index 38307d452a5a..88d21806207b 100644
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


