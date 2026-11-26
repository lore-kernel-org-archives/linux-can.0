Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727160;
	b=jMmAlMZLTklJmRVhh91qxAGSw66YM8arJPj1DceEm66C7YGRJAZ5214x40EfGbMxKY19
	 vOdePvUIcRnDuf4kCFaJDHsvVvPA1TIMTiq9yvFmemkIwUCGYAeyeCgk2nkk9ZVBb2lrC
	 K3p0H734qlnoTTwTnpJ2OrI2u2SGsHZrA1sQuYFKn/Xwr5TJz3ncQFkyYc00E7mdk7o4H
	 nowXu0iWAR/UV3vaxHE7cQ3xg5RbMEG8LM0qiKRYgBfMd8U7tviohIk6tJnwhlRtUF31P
	 bQOnHNdMkIAeiZX/QnMj04OjTa53Ty+bcrkQ9fVtcM+FmM11hfo4RcS/Rbv6+Ojd8IA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727160;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2UKIomvh2QNtF9HDUo0jX15r+I2waRga+9Ukiz1lBIo=;
	b=InXbShpXNmmqorGRIn/qem7L3RaPQr69ypV51YNv6bsWRVPRPifp9qM1oxpo6W1csmUx
	 gk7NNKyarT9uege7vOKwSfhH+QWBiUgL6vfqGljDjk62m60mH4IIUa1kcejsVxZ2M+Qjy
	 LCmRJbp5M5HfCFqOGK0eGB3L8PWghVh3eglpWfge/ovNk1ql0aiJPixLwJxE7nwUyEFrm
	 H1ciF8iSICa00xe7d4VwnrAOWuUDJinwXSqXhLlfVNo3K6MApvEI9EaAS/U72x7T8JVoo
	 xOMIsSjsqz/cfEuCCfdOff12o6i6w5+7SrStFGAvKX3tSvsNZpv8/pV4Sp5x7VZVFJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=gtoI0JdK;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=EstqUuFx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863A5606A327
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 863A5606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=gtoI0JdK;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=EstqUuFx
ARC-Seal: i=1; a=rsa-sha256; t=1795727151; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Yi84tF3FXN4wdynNfBmUnQ9gciv4LvxaGy8JitPV89ylIV1Ca5f4CD6O7N/1lFlokX
    Ccb7ADHmtirYo5Hx7HgWQJmwv/l2wxmnfHE/EmHfSXXOm3M+snvzIYtW6p9bG2UPT8UQ
    zOXyOaQu0tOd+l+u/wzjeG1zJvbvpniZnsUGbyh10nHyI4VPTI6i7HzQL8dYkljQcKNE
    IAdpne7NmZCBu5R5sAi/mhcqzBJCk0pw3VILY0yC3jPkmVuLDi+ZhVUsHg9VRuiNOrWO
    rXH8zkDKRaSInp8TZqf7lLxyRmPA+FXVP7Ebvr5zlFBXijFDmIZJxQRdNuy/Lu/z5DtV
    iWhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=2UKIomvh2QNtF9HDUo0jX15r+I2waRga+9Ukiz1lBIo=;
    b=YyA4Kf7NGRxhIF+2vnCmRdmKTvbDenymIn4ezkLQ6nM/QypQ5O5olfIbKc1CssJKEY
    IbTkJ9NSIf5g/usMj7EtwWAqXnwtwfcLOkEV+haEfaxTuUJlgKlSfI3kr/OJybHYGfpV
    grmj5JjczoJPY4itz2kbwofXa41pl/e8Evi5JJz15cY8bkyKAoGpFaHLT6Wt/qgioSIt
    yGl9EEcfJKe8ZWZLBRmQDRQgzHADCHghjLxuyveZ2lZQ88B/Y6834Y3IMUGs1Uw9DJ4a
    iFEtXzySart2vpnBivsAe6bW24u19WVPr6MxwijBfj2HJTZtVlk0XSwZL4P+3q0NYuQe
    TfoQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=2UKIomvh2QNtF9HDUo0jX15r+I2waRga+9Ukiz1lBIo=;
    b=gtoI0JdKHzdK2n5kXMsOzVOD7s+nyKpI4J9pQP1Rrs8AOHRDoYAgZVQCtP0CWMzSAO
    L17J8TFch96X2BY4g7eKFIEZ4ZrWaiLsXFjgPWpbRNH6xHGLM3tDZum/6aLJEnPk4AFg
    m506KouAs16AemE34NAfl2fEpumX7G68RIm2HQegf+lgU9/swTzHrMFEmN390UPtB8Da
    p10E5OfGnLDe9VU4gI3DQRGzB/sEemCtU+kFj5cozZ9FKyMA9pu4pIblGRFa3U1qm7Hy
    LpsuEnxDep1HcTiXPvYHUmaeYJao7CT4Pq09SC+L2MKgZlf2s0ge0adxt4cNIFyO2a5v
    s/bQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=2UKIomvh2QNtF9HDUo0jX15r+I2waRga+9Ukiz1lBIo=;
    b=EstqUuFxVeV9GK9T2Bj6YwRMX9Y+71vohztnntUbQs1AkQkZ1M4t7Cb7+KXQ+62qlK
    riHhJKmEPuw7HheMuoCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5ptUe
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:51 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:50 +0100
Subject: [PATCH can-next 08/22] can: isotp: reject CAN_ISOTP_CHK_PAD_DATA
 without CAN_ISOTP_RX_PADDING
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-8-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=1469;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=10ZxO4RXRJjdgoh7tWhhGUhN5nxmUKRP0opFYqpvdx4=;
 b=Es03kB0AlX7XRWJKVcxgLKMxxV83FDD4Bv1dM2OjDAltSZ1qXs/+o2KybMRdqmVE28vJHatJZ
 KOeUPWTI204CC27flcjfi+gRC5PXBJKvsI+0rLFHOrk7MFyww82ZhgV
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

CAN_ISOTP_CHK_PAD_DATA checks the padding bytes of received frames
against the rxpad_content, which is only defined together with
CAN_ISOTP_RX_PADDING. Without CAN_ISOTP_RX_PADDING check_pad() fails
for every frame, so that no PDU can be received and every FC aborts the
transmission with EBADMSG.

Reject CAN_ISOTP_CHK_PAD_DATA without CAN_ISOTP_RX_PADDING with -EINVAL
before the options are applied. CAN_ISOTP_CHK_PAD_LEN without
CAN_ISOTP_RX_PADDING still checks for the optimized frame length.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 6471c0ef319a..0af1a689fdd3 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1756,10 +1756,15 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
 		/* limit the frame transmission time (N_As/N_Ar) */
 		if (opt->frame_txtime != CAN_ISOTP_FRAME_TXTIME_ZERO &&
 		    opt->frame_txtime > ISOTP_MAX_FRAME_TXTIME_NS)
 			return -EINVAL;
 
+		/* the padding content check needs the rx padding content */
+		if ((opt->flags & CAN_ISOTP_CHK_PAD_DATA) &&
+		    !(opt->flags & CAN_ISOTP_RX_PADDING))
+			return -EINVAL;
+
 		memcpy(&so->opt, opt, sizeof(*opt));
 
 		/* no separate rx_ext_address is given => use ext_address */
 		if (!(so->opt.flags & CAN_ISOTP_RX_EXT_ADDR))
 			so->opt.rx_ext_address = so->opt.ext_address;

-- 
2.53.0

