Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.164
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793004929;
	b=B//+QOYsenKZg7ZEfamfHY2Q9NgbFXfU3L+d7vbMT8N+mCGqtPlf4r5tBEQoE9fwyNzR
	 Zpt896PDc7/Sg02crf1LG+e3jd6Dd3jBEg589oCWnRKdledbIt9qH7A8C/4o1hyYbSK+L
	 Ab3/mIQDppksxSGkax6KRnkzF39RhZZcGs0iRTrOHdFhLzmiq1opZE3P6ZXTLfA9oECDu
	 Rhoth9lViHVB2MaLjBXpTlxrOodEQetBqlsZFToefIa//qwXI3DeiI7ZwiE5HsZL8CO72
	 Gy+a6JTm7wt8JWvIOvj+qdMFYUyZDYvEgFObZgavVYtP7mlAMNUj4nHhyqvcWc5KASg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004929;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IryQLpkwlJlpN5YeQDhqD+qCR9mqmI/aqp5T3C/bXm8=;
	b=uTNPjsY7PFShCs6gSVwjM8Po56ApWdViMBHAjyY1t35bv804/NiLfYZ8OOEDAMNfgKAa
	 99lEO5H3iY8dDNnBIkttioGvkhsqv8h2V2uSiGz8v2qaxaUiKuiWig01SMQ9HgJXG5dYC
	 NlwFxHo+sYYY6F6fkQ/xRcPGIAYxgJkTrEf1LONazm7FpqXNd2VN9nz4wiD+ncVtzQ7NH
	 AJEL8yCTHYXXnHNpVy1IJUTh66qJ+6DYuh9nO9qwgi7zqJFXKjnGF5BC4vDmsaCSR5yA8
	 cJrqOUb4TVu0diXxZOAU9ufC4wsgeIHPcLc7eTtcCE17IoHE5kvHLSU/CqhJTaKU4kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=NCh0ZVl1;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=bY3ltTgm;
	arc=fail smtp.remote-ip=81.169.146.164
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E6606A32E
	for <linux-can@vger.kernel.org>; Mon, 26 Oct 2026 08:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E5E6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=NCh0ZVl1;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=bY3ltTgm
ARC-Seal: i=1; a=rsa-sha256; t=1793004920; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=JaCRs63+jsGQ+PLxl98v1/8Mu29dXkiu57sUUvxvcQ/2/2aTVnu0zwvwgrI5UcD3Hc
    h52Ck/MpE8hMia5bB6REQPzj12KZ3UdIlJcOmP9gfBnkTXA86DdTuLVbQ7j2ZKe+eZ71
    KEeA4OsQYpSVVyvKaWWZq/FhsgJiiNxCuD5rkI8indznRA6e1degwHhvm+CxyP9ns/qR
    uTOdWApbshU3gc4eRSiDdM2eo2UouWKJ76J4PMTNxPbEiyoQmDNFhws1Rwa4Um9AuXGj
    0U4hWV/XRo/q6UO9c26721Jou5YmQxhr+AjQnHZakd6pcblUqDhKURX6TQ/c2GkWH5w0
    AXWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793004920;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=IryQLpkwlJlpN5YeQDhqD+qCR9mqmI/aqp5T3C/bXm8=;
    b=Uo0tmTZyHIypHE5zoD779rlp9k0OJi1F6wEKWxr69eBZQrGgNYaDDA20rjWpC4vzZI
    ljIVaDpC9iT4f9kshJvxMYAZ8qm6C0PFtmwDVml9pR5VJ5HLkR+nCEdZsAzCH9JJvkDE
    HczuUUj1mNSa6fftD91O4FdYyi12DXWdvuShAxDJ68teaWNguwPGbGs3T0UL/5ve8n6k
    g7qn1Hgphf7ZBin7rU9uiGLQJumbPBzf/ruX26d6hwxT/BNeE8HvFB6AeqdVxxzR+lco
    Zsd/1C2M4WBRxA4JeKU15o7WiZEJVLaTHa3BmJw3V4F9cCshFefwwchXrYNOiKhWN7Jw
    ZidQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793004920;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=IryQLpkwlJlpN5YeQDhqD+qCR9mqmI/aqp5T3C/bXm8=;
    b=NCh0ZVl1YYd0Hwde+ruoH1BOBWS7hpxDlh66iUjBcEaa0PO8ja38ymYwC7IN4u0Tk1
    DXwrVhPRbzKsuYz2x/9yA+NfwiaqS81fkHJNLiZIHqhh25Te9g0ViCYElLZzaeTPUBXO
    aCXJO3lPlEGjGZ8vTGgMd7K/LKCglkFf4BIVY8pZRgidFEitAM+hPzBaxeroxgAMS0Ky
    2rTNG7wVRJkwEYbpGVgtNjFMh4ROSdR6KusC1pe5SiJH1wfuDLQYHJfxJrWxWltyG++P
    kSImkHoZtQnsA5elfwaGCoSW5vLc1yMIvMnV9dnpkSQa5O9E1pegMDhfugb1/WDTU1WU
    odNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793004920;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=IryQLpkwlJlpN5YeQDhqD+qCR9mqmI/aqp5T3C/bXm8=;
    b=bY3ltTgms2Lu7+Xx2Mi5EZUK9z+7+rRzFR0waZo+TbeKTV1oucNyO2mHeTXyft+2Ms
    zuXswAjkfDvvS8DkhdCQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a29Q8tK0mF
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 26 Oct 2026 09:55:20 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Mon, 26 Oct 2026 09:54:20 +0100
Subject: [PATCH v10 5/7] can: isotp: check the return values of
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
Message-Id: <20261026-can-rx-lock-v10-5-281c4b556a1a@hartkopp.net>
References: <20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net>
In-Reply-To: <20261026-can-rx-lock-v10-0-281c4b556a1a@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793004919; l=4360;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=UoUbl8+3VwOU36uhFCF9goVxXDCNnR5SjwXqq4KlbBE=;
 b=jZWD7500t9nXXhuoht6M9SvrGIkOzSHZZ4kSBLvqQJGlwINO8SIWwMu618GgNtcIBjwS9RlHW
 MOBdf2kav+iC/5nTXkw4dBCsDZUGqY7DRcgjYv8M9asLHxvdej0K0ty
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

Check the return values and register the RX receiver as the last step.
The echo receiver is registered first, as it only handles the socket's
own echo frames and does nothing while no transmission is in progress.
So a failed RX registration only needs to remove the echo receiver, and
isotp_rcv() has never processed a frame for this socket.

Set so->ifindex before the registrations, so that a First Frame received
before so->bound is set can be answered with a Flow Control frame and
the RX timeout is started as usual. As the RX receiver is registered
last, this can only happen for a bind() that succeeds. Reset so->ifindex
when bind() fails.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
Changes in v10:
- register the echo receiver first and the RX receiver as the last step,
  so that a failed RX registration only needs to remove the echo
  receiver and isotp_rcv() has never processed a frame for this socket
  (Sashiko review)
- set so->ifindex before the registrations and reset it when bind()
  fails
- v9: https://lore.kernel.org/linux-can/20261025-can-rx-lock-v9-5-7ef2a2b5c2b4@hartkopp.net/
---
 net/can/isotp.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 1a272ce6a2bd..894582cd9ddd 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1540,11 +1540,10 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 {
 	struct sockaddr_can *addr = (struct sockaddr_can *)uaddr;
 	struct sock *sk = sock->sk;
 	struct isotp_sock *so = isotp_sk(sk);
 	struct net *net = sock_net(sk);
-	int ifindex;
 	struct net_device *dev;
 	canid_t tx_id = addr->can_addr.tp.tx_id;
 	canid_t rx_id = addr->can_addr.tp.rx_id;
 	int err = 0;
 	int notify_enetdown = 0;
@@ -1620,37 +1619,48 @@ static int isotp_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int l
 		goto out_put_dev;
 	}
 	if (!(dev->flags & IFF_UP))
 		notify_enetdown = 1;
 
-	ifindex = dev->ifindex;
-
-	if (isotp_register_rxid(so))
-		can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
-				isotp_rcv, sk, sock_i_ino(sk), sk);
+	/* switch to new settings */
+	so->ifindex = dev->ifindex;
+	so->rxid = rx_id;
+	so->txid = tx_id;
 
 	/* no consecutive frame echo skb in flight */
 	WRITE_ONCE(so->cfecho, 0);
 
-	/* register for echo skb's */
-	can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
-			isotp_rcv_echo, sk, sock_i_ino(sk), sk);
+	/* register for echo skb's first (no echo traffic at this point) */
+	err = can_rx_register(net, dev, tx_id, SINGLE_MASK(tx_id),
+			      isotp_rcv_echo, sk, sock_i_ino(sk), sk);
+	if (err)
+		goto out_put_dev;
+
+	if (isotp_register_rxid(so)) {
+		err = can_rx_register(net, dev, rx_id, SINGLE_MASK(rx_id),
+				      isotp_rcv, sk, sock_i_ino(sk), sk);
+		if (err) {
+			/* unregister echo skb subscription */
+			can_rx_unregister(net, dev, tx_id, SINGLE_MASK(tx_id),
+					  isotp_rcv_echo, sk);
+			goto out_put_dev;
+		}
+	}
 
-	/* switch to new settings */
-	so->ifindex = ifindex;
-	so->rxid = rx_id;
-	so->txid = tx_id;
 	so->bound = 1;
 
 	/* bind() ok -> hold a reference for so->dev so that isotp_release()
 	 * can safely reach the device later, even if a concurrent
 	 * NETDEV_UNREGISTER has already unlisted it by ifindex.
 	 */
 	so->dev = dev;
 	netdev_hold(so->dev, &so->dev_tracker, GFP_KERNEL);
 
 out_put_dev:
+	if (err)
+		so->ifindex = 0; /* reset on failed bind() */
+
 	/* remove potential reference from dev_get_by_index() */
 	dev_put(dev);
 out:
 	release_sock(sk);
 	rtnl_unlock();

-- 
2.53.0

