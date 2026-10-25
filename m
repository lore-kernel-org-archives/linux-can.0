Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=85.215.255.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792963989;
	b=5XR9GaJe1PnSudBmLxyBJtHMocab9EPcKmu7NyZsi+sHol0zFHTsH7O2MhMc3ZWJT85/
	 F6vlwI4/YlU38m/C8+WoVcSKdRy6+febzLCPz+HzSgod6sFe85KngFGx9yqCxQl1KXtDp
	 n7oBDI6VdOFzwiP2e20SUEtQW17RjY1REbAswHbYiiH6eA6sj/NZ0spuPRl6hVD1hwQB4
	 1fOsJT525Q/c4bc+EUxl1+CLtq5iOTqcUIDNzjM6UJA9K9F266Jm3ddieP8Ggi32FMTTS
	 +62TcT47xgrAJnxs51HDQnRbHFOk9shno8ST/bb5+soKJzbD7kQ7NSdgL+unVVCbacw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963989;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4zfVkxgtdmjouhVY4KkeYtVlLvGFCepw10NNqy5fHAU=;
	b=EjRxYYVY+owyb+NJTvx9L41o1AawYNb1JCbtGq7fT3rB5CCok2wn3IjPAuf81FRfF0mu
	 a9QZgziJZI8v7BaziQIeeQtF/AFTDLq/p7n9O4DAjW++hu119h53N2RkacX9cTi/Gpgjt
	 n7dg07xsb6jlm5h24+GKO6Yb3UMi1q+GaBOdVChhEkWJ6iDDKKfgQmihNqCm2lQi484bD
	 oJeXvsOyuL54R9dSvHuVYjjE5QDGd+9BfQkWYdRci81zzwE5rDvBW08EyL0QBj7Bz/9U+
	 Ng+4CNF635FRye4jCu8q8zWMaKcK04GFq6yNAUrwWoHHrF5SFsDmcnXsoHfNRKwHkBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jzGWJ6t3;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=nGaulKGs;
	arc=fail smtp.remote-ip=85.215.255.54
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E5D606A320
	for <linux-can@vger.kernel.org>; Sun, 25 Oct 2026 21:33:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60E5D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=jzGWJ6t3;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=nGaulKGs
ARC-Seal: i=1; a=rsa-sha256; t=1792963981; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Gucoglypxv40QdfnbZQ4E9kISJn9C0+5hC1tOLuBRhrjuebLbORrPWKzzfzy7RlgcW
    tjlhoIRyICEeM4ObA6TLRRqGWMIO00XEyp86aRmdN+0RWlmxMPbOo8r+gpVK5OFb2HdB
    dWF0Hkpo/V4DWvVYk9lWkbzzb6Qa0arH3W17nvQhIHL+WTl2zqf4aMZ4+EL6IIaFllZJ
    hOzRjExrmSQTNriFegtnLgpri2yVqJhIUACDrijjHb5U2aZYgEW3Pad72jlQ5kv4VT13
    fIhsp41+kDcF/z2KjXPmpWlEjHwfUmgYLwlAzReG98fTadU4hzkUaGdDt/6WMermUX7s
    t9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1792963981;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=4zfVkxgtdmjouhVY4KkeYtVlLvGFCepw10NNqy5fHAU=;
    b=rlstbkl1Oj460Wjomk/Xa2+wvepg0Sbjuq7h/n8BB7MUCAIHJHx/J8h5QAf8Q4aBZn
    BKvrmEHbDeogisnYiaE5YexRY2ZrdctaJbixzIihJzYZTjBKoKSDE2LGwx16ko99Kzj9
    tGkvIOsjNNFOYFQYdoaVPMz6DRAboMPg1lbpM2DwGo798g91ZmJ//OFKlujgI8V06V+v
    3VpULWGY5q9lcM2PMGtr5Hdhmaxt5QWL8mugaz28NIg3UbNwmlU/DAdLkmpiewa7/9qw
    joYwgzoOb0+RbnhAo1ME/PyDvNRs8jJKAqTdNqbYOkp/OhMUiV4mXpkPmG8c5+WFg6Np
    r1KQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1792963981;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=4zfVkxgtdmjouhVY4KkeYtVlLvGFCepw10NNqy5fHAU=;
    b=jzGWJ6t3fO30lwASOycct/AIXrJZaJ4t30u1jcz+LBZnsgSro6v8VOW6TwFIEi+EUp
    JkFaOoJh7Uh1SG6m83+vEeybpH2gVcUy0Bz9ZiLLVUshmWg6ok68KGaHk5c6piUSBBJq
    0s6X63+UHfDO3/Ib2UA5TSvQQm1X3wxEiRpKbWyCzh6mUjJgLL2IhRWs77UYsnI39mcq
    FplFsDTxmyxA6bL3YxbUcInFYt9rCjAp3YlwIVeu5+ILF6qlK2B9O702jGsM+ISNBTX8
    L8fTgfEYrXsImap2kyMXF9a3SRBRbRcdypJIVcL6BMBJM7lIZ9NatIP0VZd8++OHfbUh
    Muig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1792963981;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=4zfVkxgtdmjouhVY4KkeYtVlLvGFCepw10NNqy5fHAU=;
    b=nGaulKGswMSJZJrlO0W6w6DToHoVnPYDfn46Gyi8izcjI09oVz+UZf0piua+YIVt0J
    vcj5oPLemkIbIB4R49Dg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29PLX1z81
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 25 Oct 2026 22:33:01 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Sun, 25 Oct 2026 22:32:47 +0100
Subject: [PATCH v9 5/7] can: isotp: check the return values of
 can_rx_register() in isotp_bind()
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
Message-Id: <20261025-can-rx-lock-v9-5-7ef2a2b5c2b4@hartkopp.net>
References: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
In-Reply-To: <20261025-can-rx-lock-v9-0-7ef2a2b5c2b4@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792963979; l=2216;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=1B4QHYeS0Is/UmqkvNmaDXYmi959/2tSgsD2hhNtpY0=;
 b=4g+7e1fuS48gJ6auMnjUp2UAk4NQo2NQ6ft7ccDoup5l2mIvj/jKO1n2qeyiEqZSU+MTtP5+P
 XCUvVs+QZJXAM3UZU8x24n5UaZGMyTvts7B1LyILG9sMmUSu3KKYMdh
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

isotp_bind() ignores the return values of can_rx_register() for the RX
and the echo receiver and binds the socket anyway. When a receiver can
not be allocated, bind() succeeds without this receiver, so the socket
does not receive frames or its transmissions time out. isotp_release()
and isotp_notify() later try to remove the missing receiver, which
triggers the "receive list entry not found" warning in
can_rx_unregister().

As the device has been checked before and RTNL prevents a namespace
change during bind(), only -ENOMEM can be returned here.

Check the return values, remove an already registered RX receiver when
the echo receiver can not be registered and return the error.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1a272ce6a2bd..da80ef606ce0 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1622,20 +1622,29 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 	if (!(dev->flags & IFF_UP))
 		notify_enetdown = 1;
 
 	ifindex = dev->ifindex;
 
-	if (isotp_register_rxid(so))
-		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
-				isotp_rcv, sk, sock_i_ino(sk), sk);
+	if (isotp_register_rxid(so)) {
+		err = can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
+				      isotp_rcv, sk, sock_i_ino(sk), sk);
+		if (err)
+			goto out_put_dev;
+	}
 
 	/* no consecutive frame echo skb in flight */
 	WRITE_ONCE(so->cfecho, 0);
 
 	/* register for echo skb's */
-	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
-			isotp_rcv_echo, sk, sock_i_ino(sk), sk);
+	err = can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			      isotp_rcv_echo, sk, sock_i_ino(sk), sk);
+	if (err) {
+		if (isotp_register_rxid(so))
+			can_rx_unregister(net, dev, rx_id, SINGLE_MASK(rx_id),
+					  isotp_rcv, sk);
+		goto out_put_dev;
+	}
 
 	/* switch to new settings */
 	so->ifindex = ifindex;
 	so->rxid = rx_id;
 	so->txid = tx_id;

-- 
2.53.0

