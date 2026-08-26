Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A63A3D9DAA;
	Wed, 26 Aug 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787746246; cv=none; b=GRGCx/ajpb+jrU8pFsEELG6LiwkRumYMafgD5N+WrC+PbMOhD3UBkNmB6CBfGRbcIhnzia0WAm8gw1+4UJjl5xEY3BygzP77uz/kZQFpsYJ2S1m2jpH2VhyLwZ1RInqHFxIcIq8QRMTz23a0h6S0nm0AS6U6O64Iug2yexH4D9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787746246; c=relaxed/simple;
	bh=kaVjVidOO+UxwiGfslctg2HCBUVBZcPtI31zKg3tvgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pbkoagcc4H1mUsdmMGxUbvu+LCjwbK9anGxfIs5K8fedjp3eqZnH24ABYVN/R2NS7bbF8WeM2Lx1HxWuk/y4G8hQQoVhOQABQT5yq29RRI9ofOKxCqeyo5fD/nEsJ8J/YDXt9f9nQG4CXV9YZmi3psHs4aCqvwnly4V422OqT8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 93CC9202148;
	Wed, 26 Aug 2026 14:10:38 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wzCSk-003R8v-1c;
	Wed, 26 Aug 2026 14:10:38 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 193B258CCFA;
	Wed, 26 Aug 2026 12:10:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sureshkumar S <ssureshmsd7@gmail.com>,
	stable@kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 03/14] can: bittiming: fix divide-by-zero in can_calc_bittiming()
Date: Wed, 26 Aug 2026 14:02:13 +0200
Message-ID: <20260826121036.2706424-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826121036.2706424-1-mkl@pengutronix.de>
References: <20260826121036.2706424-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sureshkumar S <ssureshmsd7@gmail.com>

can_calc_bittiming() scans the possible time segment combinations and
computes the prescaler for each of them as:

	brp = priv->clock.freq / (tsegall * bt->bitrate)

bt->bitrate is supplied by userspace via IFLA_CAN_BITTIMING and
tsegall * bt->bitrate is a 32 bit multiplication, so the product wraps
to zero as soon as bt->bitrate carries enough factors of two for the
tsegall values walked by the loop. The division then faults:

  Oops: divide error: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:can_calc_bittiming+0x32e/0xcc0
  Call Trace:
   can_changelink+0x8ba/0x2060
   __rtnl_newlink+0x1013/0x18a0
   rtnl_newlink+0x6b/0xa0
   rtnetlink_rcv_msg+0x6f9/0xb70
   netlink_rcv_skb+0x11f/0x350
   netlink_unicast+0x5f5/0x860
   netlink_sendmsg+0x70a/0xba0

This does not require an absurd bitrate. With the segment limits of a
typical controller tsegall reaches 256, so a bitrate of 16777216 is
already enough to wrap the product, and that value is below the
20 Mbit/s CAN XL data bitrate ceiling. Any CAN driver providing a
bittiming_const is affected; reproduced on dummy_can. Triggering it
needs CAP_NET_ADMIN in the netns owning the device.

priv->bitrate_max cannot guard against this: it is populated from the
optional "max-bitrate" device tree property, so it is zero for most
drivers, and can_changelink() only consults it after can_get_bittiming()
has already returned.

Compute the product with mul_u32_u32(), as can_fixup_bittiming() already
does for bt->brp * NSEC_PER_SEC, and divide with div64_u64(). div_u64()
cannot be used here because its divisor is a u32, which would truncate
the product back to the faulting value.

Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Signed-off-by: Sureshkumar S <ssureshmsd7@gmail.com>
Link: https://patch.msgid.link/20260803091426.29050-2-ssureshmsd7@gmail.com
Cc: stable@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/calc_bittiming.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 42498e9d3f38..4809f5e0c96e 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -119,8 +119,12 @@ int can_calc_bittiming(const struct net_device *dev, struct can_bittiming *bt,
 	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
 		tsegall = CAN_SYNC_SEG + tseg / 2;
 
-		/* Compute all possible tseg choices (tseg=tseg1+tseg2) */
-		brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
+		/* Compute all possible tseg choices (tseg=tseg1+tseg2).
+		 * A 32 bit tsegall * bt->bitrate can wrap to zero for large
+		 * userspace bitrates, so compute the product in 64 bit.
+		 */
+		brp = div64_u64(priv->clock.freq,
+				mul_u32_u32(tsegall, bt->bitrate)) + tseg % 2;
 
 		/* choose brp step which is possible in system */
 		brp = (brp / btc->brp_inc) * btc->brp_inc;
-- 
2.53.0

