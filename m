Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727161;
	b=EpqHt3aQI1Ux5gXhcLolATMpC43VK1IeEKCvtjZYIlDJfhncOk3p9mynRUxPTrnqTmDO
	 gK6q7OAhygeSchbSAbzvHn69WjpjGwVhxLL721Y7arwPcda5mBl+XXGCdQlrodhmwkm65
	 hcfOHw5DueST9D7bjNysnAqVS17K5UesJb62td1UeWIw2kUv8PLzscxWH8FIuz4fgiQB3
	 6UQRrMFUNizkt5juJQKr+WnOoBDhv9xipYbonOi1pbtZVpaLq7dPweS8R3al5e94QBOmb
	 bo/TKMhqML3F5qg6h622JGgFXOfzEM9Pi9zyPve1JiJL5tC+QigAidULR9xbZL48iag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727161;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=T8c3+g/CO1/xlTFNnLxrnDN2SGC4RT44u4/nBVkCdm4=;
	b=k75FPlfbNlDr8Vu3BI+h176MUy1YO0j1wm5SUJ2HWt1GVHZ3JMZckZd0g9Mn0lm0pc8r
	 GqXdcCWtX9SNJ0Bs7RTdNq3V76RRswia0P4tGsJTtVbkHf3D9ZRddBivUoACt3AHBCA6Y
	 1+rxdyBs2gfwVOqTa1IJBGOC3AGfs4037DCtGusNxkfRm5CvNi+etd3bfzn8E/TGqj6yx
	 Kd4CM9HNxfVPYQ31ZIS3QPpkrnOgRe+Hv9SGWU88bdaj4KGVB0kihxyTu/c7uSfWXuDLV
	 KfkHlYAf6e27w6+bDSCnQB29kJG8ZAAf7231eTlSMlURJSF/5fZNvJ6JyljGCxaeb9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=gYfbIcRT;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2C2v9FNP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.80
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BEE606A33C
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1BEE606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=gYfbIcRT;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=2C2v9FNP
ARC-Seal: i=1; a=rsa-sha256; t=1795727152; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XvhIqpQqSnumuzcrbrwzFmUJuhpKjiL4leg6P95hktc9MB07aMPqRiZUKogeVWzmVe
    nZjJs5PD+PLTV6Gz6OWkilEIBedDSVQD0+5MPKpGUUfomT+svCik5DXppPgENQBpTYRm
    2gTG8LA/bMovEJzS3mDYQy6lfjSqSXOE3D70Cf+DHAbKTdwpu1uJquynTUXVJK7/r2kt
    XHaykDGp7WJDk82iNGY+GTFafOgI8gNoc3SEpldJLBPtM6v+eEsnuKCaoUFqBAzpB5ON
    6EGJyYVKx1YjYb6Babk1AcJEIbVl6S9STAVR0G9sp6vyYaZ8UbXQvGV6+WcdjCemeTHC
    BgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=T8c3+g/CO1/xlTFNnLxrnDN2SGC4RT44u4/nBVkCdm4=;
    b=ARBnVrNGsEzCZ+D0E+TcJ+tPW4cuXmiy4gq8sO4Eyd65NUGgAwvpOCoqPmegUvM2Xt
    QMNzZ+MfnTq8l2Spbe1/iYzxjqZPHEFH3KP2YlGKHoMSsLyL74SvqW4935fVBJQLMmJX
    rkx/Di5EHTIoezLYBK7cULVTJWT2PgnjtyBJScbv7S52YZbig9fqoKvkHs2ZiOz+r9Kw
    UGZmZ4KFfzaPfShonQMj56BdKgAqX53V0b5suLRnPt1cZqyEP3rBbSP3d4HXleBkF4JW
    oQDmJLTq9Ow3ssMyGXQGq9vcBep808fgQDUkY7RTw9QwhmNOGF/cU+e0vRAr3WDFhxIA
    SehA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=T8c3+g/CO1/xlTFNnLxrnDN2SGC4RT44u4/nBVkCdm4=;
    b=gYfbIcRTQljyLAbd7b+FauO20WygSSJOrukSVdT+a0I+gMnPHcYBMMYd7N/JbIr/2F
    dB/wyc8KzyEp6OL1nEoxWF8WtutxPz4lHsItXvF1B8x+hh1Sd5UGqQ4XuRhCVypbwyGx
    sYCuS6aL+kjmnkpuA4JymHHyGmOoX3Qth5J7RGmHv9EZyK0Wy9KsGIrrmTgyfiXBDnBF
    j3+mcKobcOPjX8K0m2ASChd0WKrAzPSGH8Vixvqkd3vupqoAXiaab4j2/rFm2aHvtQvc
    f+1P7TBIfIMY/YOOkbR7AgMJzuIDzNwk1XM2Ur5ZSOIBRTI8QZdymL/1GHynV80/3rXm
    na0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=T8c3+g/CO1/xlTFNnLxrnDN2SGC4RT44u4/nBVkCdm4=;
    b=2C2v9FNPsEFEFN4yp/285H/HZX8ab1GTVXZqXxa5TAr7GW64Okr0pALSFckHnS0JGr
    rUy+Z6b2xd/ojcu+JEDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5qtUp
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:56 +0100
Subject: [PATCH can-next 14/22] can: isotp: ignore invalid SF and FF frames
 during a reception
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-14-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=3889;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=DM78YQWAMffIkZPdJzDYxqcWkWGbhuAM9+e9Wfl+Ibw=;
 b=QwMFTz24YZGD9aIbiCImLTON6Wct/DaLhAA0mLshtwL73mPB1IyVy+4ngGOwmu3GOt07+dXYu
 wO/Aflc9Ah9C17dcf76eizEsSR/JkCq66+ii6JwZzfFE+fKh9Cgpas2
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

isotp_rcv_sf() and isotp_rcv_ff() stop the rx timeout and set the rx
state to ISOTP_IDLE before the received frame is checked. So an invalid
SF or FF which has to be ignored (e.g. SF_DL 0 or a FF with a CAN_DL
below its LL_DL) terminated an ongoing reception silently.

Check the SF/FF first and terminate an ongoing reception only for a
valid SF/FF. isotp_rcv_ff() reads the LL_DL and FF_DL into local
variables to keep the data of an ongoing reception for invalid FFs.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index f6801c18172c..39bae46701cc 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -547,16 +547,18 @@ static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
 			struct sk_buff *skb, int len)
 {
 	struct isotp_sock *so = isotp_sk(sk);
 	struct sk_buff *nskb;
 
-	hrtimer_cancel(&so->rxtimer);
-	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
-
+	/* ignore invalid SFs (ongoing reception is not affected) */
 	if (!len || len > cf->len - pcilen)
 		return 1;
 
+	/* terminate a potentially ongoing reception */
+	hrtimer_cancel(&so->rxtimer);
+	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
+
 	if ((so->opt.flags & ISOTP_CHECK_PADDING) &&
 	    check_pad(so, cf, pcilen + len, so->opt.rxpad_content)) {
 		/* malformed PDU - report 'not a data message' */
 		sk->sk_err = EBADMSG;
 		if (!sock_flag(sk, SOCK_DEAD))
@@ -577,53 +579,57 @@ static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
 }
 
 static int isotp_rcv_ff(struct sock *sk, struct canfd_frame *cf, int ae)
 {
 	struct isotp_sock *so = isotp_sk(sk);
-	unsigned int sf_max;
+	unsigned int ll_dl, len, sf_max;
 	int i;
 	int ff_pci_sz;
 
-	hrtimer_cancel(&so->rxtimer);
-	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
-
 	/* get the used sender LL_DL from the (first) CAN frame data length */
-	so->rx.ll_dl = padlen(cf->len);
+	ll_dl = padlen(cf->len);
 
 	/* the first frame has to use the entire frame up to LL_DL length */
-	if (cf->len != so->rx.ll_dl)
+	if (cf->len != ll_dl)
 		return 1;
 
 	/* get the FF_DL */
-	so->rx.len = (cf->data[ae] & 0x0F) << 8;
-	so->rx.len += cf->data[ae + 1];
+	len = (cf->data[ae] & 0x0F) << 8;
+	len += cf->data[ae + 1];
 
 	/* Check for FF_DL escape sequence supporting 32 bit PDU length */
-	if (so->rx.len) {
+	if (len) {
 		ff_pci_sz = FF_PCI_SZ12;
 	} else {
 		/* FF_DL = 0 => get real length from next 4 bytes */
-		so->rx.len = cf->data[ae + 2] << 24;
-		so->rx.len += cf->data[ae + 3] << 16;
-		so->rx.len += cf->data[ae + 4] << 8;
-		so->rx.len += cf->data[ae + 5];
+		len = cf->data[ae + 2] << 24;
+		len += cf->data[ae + 3] << 16;
+		len += cf->data[ae + 4] << 8;
+		len += cf->data[ae + 5];
 		ff_pci_sz = FF_PCI_SZ32;
 
 		/* unneeded escape sequence => ignore PDU according to spec */
-		if (so->rx.len <= MAX_12BIT_PDU_SIZE)
+		if (len <= MAX_12BIT_PDU_SIZE)
 			return 1;
 	}
 
 	/* the PDU must not fit into a SF (FF_DLmin) */
-	if (so->rx.ll_dl == CAN_MAX_DLEN)
+	if (ll_dl == CAN_MAX_DLEN)
 		sf_max = CAN_MAX_DLEN - SF_PCI_SZ4 - ae;
 	else
-		sf_max = so->rx.ll_dl - SF_PCI_SZ8 - ae;
+		sf_max = ll_dl - SF_PCI_SZ8 - ae;
 
-	if (so->rx.len <= sf_max)
+	if (len <= sf_max)
 		return 1;
 
+	/* valid FF => terminate a potentially ongoing reception */
+	hrtimer_cancel(&so->rxtimer);
+	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
+
+	so->rx.ll_dl = ll_dl;
+	so->rx.len = len;
+
 	/* PDU size > default => try max_pdu_size
 	 *
 	 * This buffer is not accounted to a memory cgroup: In softirq
 	 * context the charge would either have to be forced beyond the
 	 * limit of the cgroup or the reception would fail at the limit.

-- 
2.53.0

