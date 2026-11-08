Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794378616;
	b=boPMG9h1MMHdh5YrrwaZUPbULjJvrIU49iRcIDuJpYUGxOvgtnqNRmAcfM4guOpTwz5G
	 eOnkicvkrYEnZTBjtRQX1DPISdt6z/4L8BxKq6MeGrEwa/5yWjNT2xnnjVgYqHz9MYjpe
	 x2Hg6qhCHVd2Ku1RVZE8aDYLp3EkikxxRr3O8hfZW2p+Sd8RtP1sizKraW4GcqepBncEx
	 Bz6DHm+Ezl4DenN3tyJegOLvIYPuYM0K61qGP68XUByyz/He0IWcIsg1orcptFx3fTzR4
	 u3M1qiRibkbyod+u28FMtZXlLywz5Jzet+BCbA9TwzczOWZauTWGPXV7krYwCfhz+rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794378616;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=UgN1zSNadRzxbt9jpslpGAsoDeZYTmReGXXIuMOSvag=;
	b=IE8vo39TPY/0QHwBHP3uN/A/DfG4rfwOeucFl9ZMohmU2wlphIGBUoOKvpW7Kyo3R5Zf
	 7Z3OFgXhT73N4h+yaI0aJjbd4XQjF2/4pQxIycn3h2kici5uyOIb48OVVYTWymNEWcOiG
	 VxLAK9qLmX0eU6YM8tab7dKhtD7deSl0iXnQHW61YkpqG6AZAp21auINHYqvBcQ+vWJvi
	 gMLu+MzFMw2LHRlcRv6wpzo3TSmgzJyjp3e9N5uyvhOP/apwpD4rbQjgmNtWfytoeuA3a
	 02oovNmoHWFjJNXZoqACdl1HDP/oNKgnm7UMIdE6dI1lzzP8/H/nLXHoCWcQ7yE5+pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ynr9hIt2;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D09606A330;
	Wed, 11 Nov 2026 06:30:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00D09606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Ynr9hIt2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=UgN1zSNadRzxbt9jpslpGAsoDeZYTmReGXXIuMOSvag=;
	b=Ynr9hIt2V/Ol22CFwQ/LD87xUXirJvPCieVcOsNf9xa3JfXimrRi+IL9yVg7Xi
	Ybz6en27ZjS+kP8kuSDSGalvz3r2XsVfZ6Pai0OLXL9hkvdMI/xsUZSKLZARsWFF
	hnlgTnlBHcWuK0D9JH/0Myk6FM6lgoLvYa/LRmzGmu+3o=
From: Chaosheng Qu <quchaosheng000406@163.com>
To: Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <o.rempel@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v7 4/4] can: j1939: reject a CTS that names more packets than the message has
Date: Sun, 08 Nov 2026 09:34:23 +0800
Message-ID: <179410166346.60581.17199842424718803160@163.com>
In-Reply-To: <179410166344.60581.3898011861151549156@163.com>
References: <179410166344.60581.3898011861151549156@163.com>
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
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_4NhC_Rqz5ZtGw--.9039S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw13WryrXrWkuw4kAFWUJwb_yoW8AFWUp3
	ZxKry7Cr97Jrn3Ars7KF1DJFyUCws8Ca47WFyjq3s3twsrCF13ta90qrZFgayDJF4UW3y5
	ZF4Yqwn3W340g37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jODGOUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wKyKGr0C2KYIgAA32

From d4e65724a76b0d8570b7e4603948219f11128999 Mon Sep 17 00:00:00 2001
From: Chaosheng Qu <quchaosheng000406@163.com>
Date: Sun, 8 Nov 2026 09:22:30 +0800
Subject: [PATCH net v7 4/4] can: j1939: reject a CTS that names more packets
 than the message has

j1939_xtp_rx_cts_one() rejects a zero packet number and a window above
pkt.block, but not a packet number above pkt.total.  It then stores
"pkt - 1" in pkt.tx_acked, and the transmitter reports that value back in
an
ETP.CM_DPO.

That value is what j1939_xtp_rx_dpo_one() now bounds, so an oversized CTS
is
currently caught one step later and reported as a bad EDPO offset.  Reject
it where it originates instead, with the abort code that describes it:
J1939_XTP_ABORT_ECTS_TOO_BIG, "ECTS requested packets exceeds message
size".

Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 net/can/j1939/transport.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 5f05c15114ce..6cb3dec49f3f 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1504,6 +1504,15 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
 		goto out_session_cancel;
 	else if (dat[1] > session->pkt.block /* 0xff for etp */)
 		goto out_session_cancel;
+	else if (pkt > session->pkt.total) {
+		/* The responder asks for more packets than the message has.
+		 * pkt - 1 becomes pkt.tx_acked below, and the transmitter
+		 * reports that value in an ETP.CM_DPO, where it would name a
+		 * packet past the end of the message.
+		 */
+		err = J1939_XTP_ABORT_ECTS_TOO_BIG;
+		goto out_session_cancel;
+	}
 
 	/* set packet counters only when not CTS(0) */
 	session->pkt.tx_acked = pkt - 1;
-- 
2.43.0


