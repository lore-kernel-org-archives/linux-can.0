Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727160;
	b=B+ND42W3l7yFdVyGCdhKYLGP/D/OsnwUXUfkMpl+lQyFbmcC6aHm0S+71lNqX5Q8F95l
	 YzmsHJ4GAk2sRBRJcGEqRRMu5Btud8iVpOVPu2BAxiUdSB18rSia+NIQA/WdpWgxmcpoB
	 hEKEkdgvh/yqSFrzqhmuE44U0dY7/0ziUu5hvHr9gsfQMyfHReP9Xu9JIxE6J85N/WaJu
	 OzvQORhToie1KMPk7ZNW19Y8pb4FlS1EoRpDDWR1+HEt4gzBNEjE72YSlM/tDGVOHZ6Sk
	 cZjBfCO/r51BJzSGoVR8C9WjHF4MWwiG8k4vqDctN0vFzBI9C1GgY/+w/5VDETD3J5g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727160;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ARxBIvLtEKFswZCG67JoW2QJClsE5dBgNYpJWUs46Fg=;
	b=BGm1P74ixo3Zd4rcbna57VlR1lWrxfwPaqAKp+W9Dbr7mIXR1jT10eUSTqMqasMBWrJY
	 cWKYOnaxEl0ZpnvX2fA1FwqPDkVs2C0Pcaig54ZYKuUbrCESOMb5jkPbCVx2WlobM47k4
	 9oHpuypyJwR1jPqoRBtiSeGKIouYretVwBpqasGDLPk21sXzMhAZlqm9JOVHSaGM2zJIJ
	 D/iZQJIvtWH7h1OtPcFtbhd+ajHIOmAeCiaQ+Kw/A1YjDeV/dH4Of6USF9pfEJjIAZSFV
	 GE6oOlwxcTGA1TKUGIN6YkNz52OKB++RsBd5FEMa8e1WTJdIfpJc1DU5k8Xjsqq+hwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=dyMVSXug;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=HyQg2JFd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.170
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900B7606A32A
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 900B7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=dyMVSXug;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=HyQg2JFd
ARC-Seal: i=1; a=rsa-sha256; t=1795727152; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DM400Ivg7/n3dlw5cKGfvqW8pPmeKblNH+i8M/feOoCbWV4hss7IP+OtMhDU4tnLWL
    el43U79OMf56/3LYOIysEE1V+SlKeMwN7T/mqrjwZpYoWGewlOZxqD4zF3Ggmy7Nw/Nv
    Yi3uMwwqscKAMxg6alCIrLZUz3KwuzussVuoX72qYwHwcTfF26ckcdUYI0YzYMR4rWpk
    r41BgPgfKLFvRXjFPtD75goFrnnXD2/t0Tdd+CDcTb8YJ4TTDrjbCulqfo4dfL+2TQr+
    40QZAs7re/cnRGtzbFvZTHBLgJLh8fhceNDyhWUFU6yS0qQ3B8XAIXGmqMfWva77jqAD
    voBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ARxBIvLtEKFswZCG67JoW2QJClsE5dBgNYpJWUs46Fg=;
    b=G2nLD+3mJNog5pJlb5xmeI4luVICBSPxEpI8e4rcmSUYFKUpV1+vS05sXcSk+RFxBg
    MJtbC2powtOGDLFtFEzqzLNRfIa+4JOJz07q60CSDQg54JG75puZmKpqv7umm7co/8S+
    sapHLtgjissPeVSkkkr073gz4FM2ZKd+McIsvmlku5hnh5BtDHglV0HPRXC74MzUPuYr
    mBP2K0HUyf+aaAJcPcM8chnq19Z13HIZOwp4krkkKNkqkamwT22k+0PUIcSBbA7ahGvW
    Kbt6x0/MmwsjqrEnM+L2QsrEDF60U2XAbHU2N0JgI9UYvLznj49LBZmJgwywsV1TzVaq
    K+Yw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ARxBIvLtEKFswZCG67JoW2QJClsE5dBgNYpJWUs46Fg=;
    b=dyMVSXugD9plObHt3KARTrzKVhnbXgqnN+nGb5C8XYese0WrC++ix2rYkcC4YzC3lS
    SRlTbloem9nt+ej70T8cjXJB4lGVs3aKJ8scSCgODubnJlVj3pe1jYByylVinslIOome
    yKBph8JozDtmOOjDjvM/PME9XJDtjaZL5lCgWvGlBXGe6+lNHJONFPi74zXuQrecPa9f
    /ggiJnDcRopCcR/Yo8CLT97jNykwIaR1V/jQaZ9Vol3iA4Roj5xppp+mxlWXblz3cszQ
    EzIJJlbjWd8lOmyaJ0eyNDv8Va66o2UOweIvq9rNsQvPyLgty4QL7quv0W/+uIfjWOIb
    QbRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727152;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ARxBIvLtEKFswZCG67JoW2QJClsE5dBgNYpJWUs46Fg=;
    b=HyQg2JFdNrk2xXbN4RwTGm8olkEhIXT2hRkr3DH8YZNR9OE5BrmPdmrR6Hn6DGI2TL
    CcjiXcdewv+PYyTxmOCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5qtUi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:52 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:54 +0100
Subject: [PATCH can-next 12/22] can: isotp: check the data length of the
 last CF
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-12-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=1414;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=Cjs1/w1cF+clXTk1Ygf4aliK5LOpKU4N8DzytqO1/1s=;
 b=+epavONYqvaBh65HHMnzF9wUHUxfVrwc0DoZax71q/hiNhDBkJlqzopGMn1KhKV4D1TxeLyeW
 fvnOY8hQm2+DZAowKji5z2NGR7MJdkQqHg6rsPBtjNiHj5BURBD6eqk
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

A CF shorter than LL_DL is only allowed as last CF and therefore has to
carry all missing bytes of the PDU. But the missing bytes were compared
with the payload of a full CF. So a short CF without all missing bytes
was accepted and the reception continued with further CFs.

Drop a short CF when the missing PDU bytes exceed its possible payload
(cf->len - ae - N_PCI_SZ). Padding is still possible as it only
increases cf->len. isotp_rcv() ensures cf->len >= ae + N_PCI_SZ, so
the payload size can not underflow.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 8aeec4ca1d19..8ae314fe68d2 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -672,12 +672,14 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
 	if (cf->len > so->rx.ll_dl)
 		return 1;
 
 	/* CFs have usually the LL_DL length */
 	if (cf->len < so->rx.ll_dl) {
-		/* this is only allowed for the last CF */
-		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
+		/* only the last CF may be shorter: drop it when the
+		 * missing PDU bytes exceed its possible payload
+		 */
+		if (so->rx.len - so->rx.idx > cf->len - ae - N_PCI_SZ)
 			return 1;
 	}
 
 	if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
 		return 0;

-- 
2.53.0

