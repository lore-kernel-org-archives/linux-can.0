Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793709031;
	b=Q8BSFP7mMh3eEa47pm1590OTP9UqBdqPHtgvfPrQKmhe+ktVUMl/4/TRPs9IyAjxg8aa
	 vFl6ByoAD4ho/jEtRRftGHmRdP9fBqMmF/NvTE78amXILP+zFkMFE7YeW0xjZfFE3Vtrp
	 aj5trLrPIozg9GfwO0VmNDrH25J1AInqybyO4lYfQ1dv8cV2XaurOr83rNlm6Awjq77IH
	 2FEgPesHtr4cmSskU4XX2y2QJMf7CCjJOpyLdlZyPa+4F2FBPCF7f8vt6dhv9T0R56OUO
	 ALK5D8fzzD5mxRSthl7dDuG9gwUlf8BxpW1EQSsE8bVYZmmRSVVwmp3yvEH4mxHqdsg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709031;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5S25kYhorfTO1S1eETiOfOeSqk0ceKXUPyw0jEoPbCI=;
	b=CwURyuRH83DJU3RfWXWYQ0fm4H54EPtDxRL5qJfXi27PORXuG18fWU8evhyS9qf5EggN
	 weTVfluBGd/1TXQbh+Ur3F+FSt8xNQ25h4qYFCUF+9CfiwjmkFN+wXDaTo2UKlPH1elOn
	 NJDGEkWDSWBt3jYVfv4dmd005ltjmUwepVCw6N5XUtHfcF8M4grgnG30N0Lkrkaj3R6I5
	 IF7/hGwlPubaBhIarD6aDcTFKzyO4qk9gFvZbk6Kc2lEwW/rFmvBknQWmPCs7aVAbjGKf
	 cnD9NT/Smp+5H9zXNax4AdQOqr93+3tMRpZx0Pgg2fpFWz5o5M7tlx6sHjujUGfSc1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2uweuIH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1248606D83F;
	Tue,  3 Nov 2026 12:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2uweuIH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793709030;
	b=sqhNEqoXtSnKX921NQ28os9tJEf1btcz2YXoc/iV/8AFH3jPbkS1xH1hEu8tuWGYUiCc
	 JSi3ujF39Eso3rjAhx5elf+WJAxDo5FtU8h3ht1Wu62PIddfylHumcYxxKhAdpHv6aZm0
	 xHUBA/MeizH1jGPLynh1YV1VukyFRGlH/UbzF8swM8y4N1RG4ns8JZKK9/psHexEIJbT+
	 Kez03PwF/sitgHN+vboLRiA3qgHyui0VHyq51RBN8ShUMABYEaiF31qjvpo/xm/O+ZEme
	 Fj3R0gjOQ5zRfw1VxO3XDT80CNwzzAFQ7hCPNdsM0HdXLYru+N9UoYipWhzXjH7rG9Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793709030;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5S25kYhorfTO1S1eETiOfOeSqk0ceKXUPyw0jEoPbCI=;
	b=Gxf2SV+vY2pUGbFx++VVYoyFN0mF9/3vKbBorfcY9Ngnw47XsPCoKVToCgo4I0Wy+R3F
	 RergtcEqYpNEfkQ1VleYTV0f6oo6alctEfau3FSps8Muyg5rGHmNzN/cDp0Z6OSuFAL1H
	 bnBCeJTuBFsSjKJPK2qqSKpKkiKLz4Kstps2G4ZuHjCdDcxRgHlYQxzKNqzPjn+P9vEKR
	 o98C0AoYAXupKF64QhKqglr9C9QlIte2qh3Bwx9lo1SFGP8llcD8ExVRaz7ca1Z2XHbcM
	 +3naS7ilMv/s5q/zzRs7O3Wto48tlvCTWIy+/W4X8ao27E6Go4X8Z37K6OZCYpM4dUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6F6751F00A1A;
	Tue,  3 Nov 2026 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709030;
	bh=5S25kYhorfTO1S1eETiOfOeSqk0ceKXUPyw0jEoPbCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Z2uweuIHlhwIcfL9njkyzIMCRnRiUuoKA7N9+8WJV6ARhSfg9c15JDNDuILi+NTDo
	 oPsUGJKjl19ALUdsi/N4OZAWRdDssoi0wwl/2Wj1vVe7jfVdK/8ZjAihBFTOUytmih
	 hXe27DJ5R5ukQ+UDEo8Uv7MmOxWs6NR+206QZXCteKaBIRTNkCCqxdIqh4QfbnKahP
	 Ea6BAFdpCgQdkMKu8QIW1Pwra7OAuGx0fwXfI8zAOthTrx4a9u2vW0fhC5pAYVZUyv
	 4WAY2omtDkjtseKQb8F73iYJAhbtIcFiGvlo4IxjfxzspimcGy6RNQ69APtFD3AW8g
	 +JpK3E+TJ7vwg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9AF9C46944;
	Tue,  3 Nov 2026 12:30:25 +0000 (UTC)
From: =?utf-8?q?St=C3=A9phane_Grosjean_via_B4_Relay?= <devnull+s.grosjean.peak-system.fr@kernel.org>
Date: Tue, 03 Nov 2026 13:30:25 +0100
Subject: [PATCH v8 09/14] can: peak_usb: don't read past the message in
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
Message-Id: <20261103-canfd_check_channel_idx-v8-9-4e8b2c0a8806@peak-system.fr>
References: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
In-Reply-To: <20261103-canfd_check_channel_idx-v8-0-4e8b2c0a8806@peak-system.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
 Dan Carpenter <error27@gmail.com>, Lukas Magel <lukas.magel@posteo.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tristan Madani <tristmd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793709024; l=3340;
 i=s.grosjean@peak-system.fr; s=20261020; h=from:subject:message-id;
 bh=h4jVtQ++YLpdaDDefew6U35BUUpoAZ8/yqvbCDBX9dA=;
 b=AxqEku8UFmw5LaP8ZCeST2y+Ts/X24M6YPYFVLU879AAdzifN0kIELT8UcymoQGw59mDZAnuK
 G++yD0ywq1pDzzkluBg7SEYd0PMHWWZ3k9v0rLxRJpypVUrCyUCBDwO
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


