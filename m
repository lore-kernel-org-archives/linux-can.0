Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679279;
	b=SzmGQ4JSeucoL1Hq1EwHa1+YYIsmW1KZ145y+S8YbhXyn8QHXlDshRXrGjpnbf0y4Leh
	 a58fZQfqniD2Fej7+s6sbM/pfvPPPmpnwcAumTU2uMPiq8wTI+GNQZQEASCymle1q42wF
	 vMmLdk2bqK0icgVMh4OeyhmPxn18vobASlL39SzGtXgeMnaOJCpjHfAPdbXr9kAOD59AT
	 cOVEZeWJi5flEl/GUAXwkncFVNslPlTZMo0+nLoB6QJbM0Al4eJeFcK7Dxdz+l3sN3PCr
	 ORMorIcfjOHTJ+uFDmr/eYX4Oh0Oi/BHzMmDWpFSPnq1MHVAdJhMM5gbmZWH4k9xpDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679279;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YMTpGwMtuCdk8eeM1ATjk5r+ogZhvierRSm8aCm0NWw=;
	b=aUmXtcmxr0isCnSPYcamjqSWK4R9V6OKiXtMwkfsSaQ9hLKB8qAHLrtDxSSS1GRgC7QK
	 aciQR6bKXKfbSf7wzJMxj4iR44jTBwp65YsELrgl+VDQbKa0l/0kMXD0h2JDz5J5CRdHP
	 gdGAg3AKKhgqBib+MtCRTnUhUquHHDRDXzSFlejvf4R3UBZwOFWfD5Eh5GFLMgOG4sAmg
	 JXOsvliavK7jsjg+P23K3wICg74oS8H5H4dVkYJ9DD9r46/nYFsJdt1xfLjRgi4bdKdM6
	 F/XP4i2bKGGu50tg/FvBhQlw7ANh3Oe2w2EO8FedcNg7CHHjakk3Fe7mp7CalLYgczg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lad6DL66;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0609060A2606;
	Thu, 22 Oct 2026 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lad6DL66
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792679278;
	b=mrGCA6p18/riaQasrjM+Otm9pNIyKtdmmPqPuV3JlJZ7xdShAOZuyo/ZO+4+lvOPExC8
	 Bfy+43nMma73OUdcrW+/tzUMDicwA5KhWE1uSXZIPmkhbyRov6y40Fkee+IwQ52KipWFX
	 qEzk8n1XvZiK91eAKu/g7XcmAz4kGPhFeLnZevKb0w7wBXoJPDC4uPimHKJlt1ARY2riU
	 RT7legPAtARybbHHEDn3rlBadTtQcnW8CAYfx+kvxnTtDMkUuefNVklDqyLSf84NOKmBU
	 T1LBQBsZLiuhWOfyzaBAvimEEU55448mFFq3lYhhKeswTytQ1A8ZKckZun02oPCsYzA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792679278;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=YMTpGwMtuCdk8eeM1ATjk5r+ogZhvierRSm8aCm0NWw=;
	b=3rzWPN1YfT8/DLQpKvQ13Y0IqYJe3Phe4O9y7PmZogj5Rk1aI4txOSBs39qljuu0tj+8
	 mUYq98A8UInh6gBlFgLYqQRlh5rw9hl/RA51Ccn1vNb5Nw58jbFYe64WeYETGos6H2R9n
	 nSdmy03hhxEBERMWS86i7HmMGemRgw18wtsD8YK1GNr7pLgKoPUT7WJ4hU+IgUfruhxay
	 eZ92kCBrvi68lEcnqTyDREe+ZYmhNDXTTDmse1BPUX3qcjaF4s+PV0CVdy1wVQ1Lop54x
	 P+4wb1MKHa4f/OnxDKZ61AgupM1KMwDMkqtcqSnXzQerSyrUtQuaaXrKkZx9z6TRycw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 171C51F000CB;
	Thu, 22 Oct 2026 14:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792679278;
	bh=YMTpGwMtuCdk8eeM1ATjk5r+ogZhvierRSm8aCm0NWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Lad6DL66Iu2788E0F4B6UYyw/lkI8ITa3yKP7cNYKdv7h4ngb/XSAaOaal2nUI7rF
	 gyXWAIPd8Wezd4Oj9JVKprS41/aJIKb4xAkqxAXl/Zwi8cywRe/VwjWbL9L1Gc1CUt
	 7XmLJyThp5EBK2zPuhEDoxyW/rhfTqFvnPCbd9M4mU8TPf9B9kvH7uE7ljzTcEmbb/
	 bwmuMcDHH7Paw1Xbo9xzsbTalTl5biu7TZbDBjXeAQc54FBseOimoWRwRyQT8Y3DEv
	 UUDwqdQqe4WJUn8Ns1rtJZrMgyGpj+ohmYV9MPfsK5RzCUCut9OJtY40RI7ZNVABvi
	 TJVPjy165vUqw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DE0AF435DB;
	Thu, 22 Oct 2026 14:27:54 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Thu, 22 Oct 2026 16:27:56 +0200
Subject: [PATCH v6 11/13] can: peak_usb: don't read past the message in
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
Message-Id: <20261022-canfd_check_channel_idx-v6-11-197704231551@peak-system.fr>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
In-Reply-To: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679273; l=3195;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=flMPKg1xIa7U4jARAjBvLBR6Xz2OZahn+0Fz2bTlglc=;
 b=RYpH9P4KoJ7SRI+sjY8/2tof1puaCeu/23xklN9hRabFPT651NEUswmjPgE+L2Xcg7GM3mMxU
 uatOiuoJ2xrAzhKKh3ncjxk+kQBk4MdcuJ9sMSv8VJhZZ1GAW4ICBOv
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
  received length at all. Since the count is a 32-bit value, a bogus
  response makes it walk the records past the command buffer.

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


