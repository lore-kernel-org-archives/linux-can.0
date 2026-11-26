Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727162;
	b=cX54YCDVghPci1VyBY3uF8qSx3N35koGJu9e8hQS9twcFmuniwEePaoFmqhEyAbLkm1D
	 FN+iXaTCG+jOqq6p/mtGoBfQl2ab3aYuI660hB1h/fDj19onD4fhwcLDtHQoKeymTxGPH
	 zIWTKEzGSHRkBteDpNFoAdr7ypn1HlKf+J8hQ10Q5+MK/05mWVGHXZCHDwrN18zM82mYN
	 BalNH/oQn7IsWFz8/XrT4uiQGRN4gwShfYR7UzdprJewSb0zA9ZjaAaQG41GD15xc0N3G
	 KG/nZ58zTwLoy0wfeBWWPjg+whYXsimCaivD6pYLJvs2K+EsS1HnV+BJfJdn2tGE6Jg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727162;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Hi87/X5PMNaydbtjI4hxgP3llGPWN9iO09mb0qSE5b8=;
	b=g046c9h6cLBG1TtvZ0I6Jx+2Xq5Pvj0hJPRjZPPvJ1fjcyoOB6wgJ5FGJbAQDovCzNJU
	 fDoW3v2lHZn7cQdxlckZMdhUFi7PnagQT98y/HNxDmSZgYbvI3mqpv15O4VBarjOS0q4G
	 77Nn2k5wq71N1SG1j17lRPzQ/7fT7czq/YETi78rDTnY8wZ/ERBGkvzfOiXEVDRh6WWC9
	 g21tIxoQDoDgSBADf08Qv6lnw4bopi6x4comYGyWpQ+mVmOPQ+zjYXD3BR0EYtEcWOokA
	 RCNev7r67O38dhppjAp5bSSyIQfbUZuorXxclDxYQpiXhfIk3Q7M/z8+mwD9dfrcTVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=rLGOR7lu;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=cgEVWA5E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.84
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDCA606A331
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FDCA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=rLGOR7lu;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=cgEVWA5E
ARC-Seal: i=1; a=rsa-sha256; t=1795727153; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Km+AoXwAoA35QUy+FeydVoli4SYiD6UjYSWPG8cxWz9MmLYNTfx9+jaaOp2E416EgR
    CoWVv2DBacEirgop3B5qEEN7J5/jC387/h8WvkYeTx5JPB+u18knFJmsnhTrDqd9FXd1
    Na+HLe8rVa2Q8zqWmuljucJq5ONemoSCHjM8Z2EPGQ8OhORFMQgTl35vIelO7hwBlUey
    AYQ7KA+vzmpV2RGdVYX2GqvXAakJqfAv2/XdH/fFJ/HnCOod176449dN8w8T3Uj1HiQn
    /jor5ZR34eP2ly67nj7kuxlyQkoSr4JpMdOoJe+w3Z/Th+KbjtiRyOEtQxqlrfAWQlTU
    mXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Hi87/X5PMNaydbtjI4hxgP3llGPWN9iO09mb0qSE5b8=;
    b=cod3R187n/JUEu0YYaDiDWtAY2kApcsRPASZI0G3ON0LK0ldevP8Pe9So9z0yGw4u2
    Qo61tG+vm3OY616WkcAxnBDRnqkpO+1qIpAyKV93tzwArpnj0qiGzeudwyhrkvvNQxL8
    ag/h5Cw+v8LA2RXJxMTsN1LHBjokZ6YZ3f+J1Ft9u9Z5HkzPFuVtBPJ4Hr/sLEe56K7A
    3O/JjgZ/Hj5pEKG2Uk0mDx61R1OBuNiPqeVQdxPV+iy9Q+UYl6YNx8d4nhAum3zYOipY
    RlJ3hcYR9uNZj5bTbXMEKx36NJwVMaAgjyiPxSik9jf2CW5KYB7go5v/ALUx5eF6JJFj
    dx/g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Hi87/X5PMNaydbtjI4hxgP3llGPWN9iO09mb0qSE5b8=;
    b=rLGOR7luV4vhTMF/hugpx0gUVWpfmy+oRpBWYNo2nygDNlHupkZFmXY99TOaICtirY
    KPswtOK5DfbPnCSuKCvy9NmmetyCFY1ZlnYS7nkJq5ZXICLTeI/d2djzn7JEzS7W1fXA
    hZCaWSsPf8Z2PC5M+WZjA/oU/r8fPKWKm8GPjSgJpioP83KO3fhThiS8OQoy6o5170bb
    UvkTDITEQRaiIrId3X9ew1QEUTGk7dPcCeXBYnUhXO5Lqij2IEvsX7OCMFK+lBw8sNki
    CuVt90BjNktlct8N5rEIQ3jo8bJ+MlLxOwgJji3UYCvaRPyUesMkAi68qx/rfY6Lc6tF
    oykQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727153;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=Hi87/X5PMNaydbtjI4hxgP3llGPWN9iO09mb0qSE5b8=;
    b=cgEVWA5EmUElMfsptIDl0swXhp/sA5NbzAAbfm+CCLZ5TWAhAKeolaaUp2HaeTF3Ni
    E6KpnVzuH8CTWmtc7+Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5rtUt
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:53 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:06:00 +0100
Subject: [PATCH can-next 18/22] can: isotp: rename variable for the
 required content length
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-18-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=1499;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=xvSO4gxRpitN9+qApIl53Y2j4k5baiYyCsokEaa0724=;
 b=TEBpbjrOJ4FRa+x1JyWcEHl9fcs3L1fHC37j2o5gwjHZfeLXAREbiztUcUXk5OdwpbkvT+s0c
 MT25I08nxXNBYGsw2pUyPXW91LtEPCbw5JLynoG+26ir+cAAQdTQBXU
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

Rename the meaningless 'num' variable to 'reqlen' to simplify the review
for the CAN XL integration.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1f8d767b603d..61021d7052d4 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -869,17 +869,17 @@ static void isotp_rcv(struct sk_buff *skb, void *data)
 static void isotp_fill_dataframe(struct canfd_frame *cf, struct isotp_sock *so,
 				 int ae, int off)
 {
 	int pcilen = N_PCI_SZ + ae + off;
 	int space = so->tx.ll_dl - pcilen;
-	int num = min_t(int, so->tx.len - so->tx.idx, space);
+	int reqlen = min_t(int, so->tx.len - so->tx.idx, space);
 	int i;
 
 	cf->can_id = so->txid;
-	cf->len = num + pcilen;
+	cf->len = reqlen + pcilen;
 
-	if (num < space) {
+	if (reqlen < space) {
 		if (so->opt.flags & CAN_ISOTP_TX_PADDING) {
 			/* user requested padding */
 			cf->len = padlen(cf->len);
 			memset(cf->data, so->opt.txpad_content, cf->len);
 		} else if (cf->len > CAN_MAX_DLEN) {
@@ -888,11 +888,11 @@ static void isotp_fill_dataframe(struct canfd_frame *cf, struct isotp_sock *so,
 			memset(cf->data, CAN_ISOTP_DEFAULT_PAD_CONTENT,
 			       cf->len);
 		}
 	}
 
-	for (i = 0; i < num; i++)
+	for (i = 0; i < reqlen; i++)
 		cf->data[pcilen + i] = so->tx.buf[so->tx.idx++];
 
 	if (ae)
 		cf->data[0] = so->opt.ext_address;
 }

-- 
2.53.0

