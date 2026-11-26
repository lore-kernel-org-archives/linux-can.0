Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.166
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795727154;
	b=umPjXpYDaFpGrQGjykBmNXfNKC96+gMY5k3l8+lArBcfB4VHyqkFDzcHZqvoYNSW28Ef
	 /GToVJBg6V9AuqJZiM8gpdXBgKwhkBVJdk0qNp720XVzR9c5qDm0uVMkYaCCKCzueGFUK
	 xXNZXYcsDMGURuTbwB1l/HkpQ+foZ208rlcy6oPpHTMdi9qMSg9GFntK5i/RXcmgp9DRQ
	 9gyfCfuWCjGUxRN3uOmuMH5r1Jy1fbP9SstRkrjsv/I9YUw4LR62B3fkuM+HSJn0t9zXW
	 XQbzU9nxsCMA3JytmKz1gG6Zua2/4mklVFY0ul8xjw1a0f0kP12e1q0p8/dC0EgX8Xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727154;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ofH9WGP6FYXe+VUlq5/Z2OI7HNa3wBLP+2gQHzP7dTk=;
	b=bBhrGZNNwReWGyxqQg7di5g5Htd49nkyZsHtcz+ZxI4IRDgEJm1Wk3AvdE8niydD+464
	 y7jKkPfZzy69sDaF1XkkXN4CqmXhJXFmmoutLuSg62zCYP+u05f8o7XBTd/5Thh88LZsj
	 QsDthVQDPXqJhV+WCt+r9s8mBcOmjds3caygAXYAOfGeIxP6/+QJ19sqsurMWjTY4x2+h
	 /NsZBrhqhy1a8SwEREdJON15vPjxTGEAG63ojR9AoPmNwJYRRWdzVo38dkNKcb0rWBUrW
	 Od2nvZUfeIJFI8oxGHUwKK2cmqDC64kSBOrN7mPkNTIyMBCY3cjJaT00zZ/xHLvptHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ET7Sz6iV;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=EdEf1sxm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=81.169.146.166
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3F606A31C
	for <linux-can@vger.kernel.org>; Thu, 26 Nov 2026 21:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD3F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=ET7Sz6iV;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=EdEf1sxm
ARC-Seal: i=1; a=rsa-sha256; t=1795727151; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=neaGLZN8uhOKTnFxPZ9z+AmjwkAoneqZy8ClfFp5u+uU18IO7AFjc2XmIPRGW1ROP3
    op1V810mILmdMsO/ic/mowcOzJJNpKqoeGsbMdOY78SaevanSdu/F1Z/Coj0aaI0wHnx
    lzKSymByp3altnL++M+Ecx44foNPkgwiSr2px2fgWMieC7s6jQ+MyWADIo3w67hPNF2H
    +HKwjEgyl51vlmIo7PexBCaaMTMnOGDvd5Q+g9ZSfWEGKxHYKW2CFtm8Jmsr9i4njjDD
    hPfqVsMsBkUB535kWKQUgjqO8BtLppVou0kjo1330xMG0nuIeq5eWvhBYLZ+/+f6G6oQ
    ArJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ofH9WGP6FYXe+VUlq5/Z2OI7HNa3wBLP+2gQHzP7dTk=;
    b=QrTLHeYKWHIX1G2KHAYEcLmSc/C1U8phOqAGr7Rqny0Mo3wpRjThZzJCbrw2WgDVZW
    jJbLTTZzgvJiU3pYjVjLrHQqVfXXS7vh0kunaCF0Z63B+JvFbiOQOFJy8I7P4F2XLrb6
    6bC83gYgX0fOm0gHxwGCsDYl04bAsl10gapQ/i9mLxBGLyg5UvEx8D0lSe4NFYhS2i3T
    0YxLI+G88EQ6wkt+oP0E76dwzIJxiNKB56ViwX6dn3kIWYqlGQVgIKkc3CCzXrv4sJ6D
    ykYHCduvFXaiiA/RjGP5yn4SC8Jy1xb5XFFTPgPjR1e4+A2BBdRhGaImAce2PVXVMeLl
    XU0A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ofH9WGP6FYXe+VUlq5/Z2OI7HNa3wBLP+2gQHzP7dTk=;
    b=ET7Sz6iVjJ1JWhnkDFW/LfkQ33DvNz9u+MpDhFcp2DH1zLXbMDthW0+GmNQw5yZkGt
    hTSqvgZfzX1E5gJq/Hkm+68ran4JuA53Kc7Vk0sJJuT9LTrzc4KLi4ObPiMvYWK773G7
    oJmEUIP43JrC53R10XwViJhEcX80oorC/lLcK9Stubo1A4tqvYNzjRKGHy+iSajo+zw8
    MU52FAn+L9NSBfTx80ifM+Gv5keen0M0V7PQNgmPCwVD9iU4wcJfVIpZbKEDcUIZaH66
    qydFB9atj1dEUzFBYKWhTQbrax2a43fwcIGA9JfxtKg/BikHO6v8mSliCCRZruVQTnSf
    tOzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795727151;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ofH9WGP6FYXe+VUlq5/Z2OI7HNa3wBLP+2gQHzP7dTk=;
    b=EdEf1sxmVfGkDlRctQBTsHYJUGY/6afZzIedbpposaSOt9PazpJJOMG+D65TLUDzcJ
    /bwHUF446TYtRFw/zMAg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AQL5ptUa
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 26 Nov 2026 22:05:51 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 26 Nov 2026 22:05:46 +0100
Subject: [PATCH can-next 04/22] can: isotp: check the CAN_ISOTP_OPTS values
 before applying them
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
Message-Id: <20261126-getsockopt-memcg-isotp-v1-4-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795727150; l=2542;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=607VNYyNMJVtBEOcIPH6froCQXaUdHjgulvnIN2/RAM=;
 b=1It16nd2qKdtkYVilp2IRpkWtioLL11aBXUPPAeXJDva7iucKpeIhy9Ps7mhdEW5LPTE1B3Zk
 NGx4MwuzFNJDZn4DVQQhS5IJwXUJStFBMq6ZsU+JuhFyUSXELHpmevM
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

isotp_setsockopt_locked() copies the CAN_ISOTP_OPTS values into so->opt
before it checks them. When CAN_ISOTP_SF_BROADCAST and
CAN_ISOTP_CF_BROADCAST are set together, CAN_ISOTP_CF_BROADCAST is
removed and the remaining options are applied, although -EINVAL is
returned to give user feedback on the wrong configuration.

Since commit "can: isotp: use a private mutex instead of lock_sock()"
the option values are copied from user space into a local buffer before
conf_lock is taken. Check the broadcast flags in this copy and reject an
invalid combination before so->opt is changed. A rejected setsockopt()
now leaves all socket options untouched instead of applying a modified
set of options.

Use hweight32() to check that only one of the broadcast flags is set, so
that further broadcast flags can be added to ISOTP_ALL_BC_FLAGS without
changing the check.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index 3b83507a8c21..7be3d9322ad1 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1742,34 +1742,32 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
 	if (READ_ONCE(so->tx.state) != ISOTP_IDLE ||
 	    READ_ONCE(so->rx.state) != ISOTP_IDLE)
 		return -EAGAIN;
 
 	switch (optname) {
-	case CAN_ISOTP_OPTS:
-		memcpy(&so->opt, val, sizeof(so->opt));
+	case CAN_ISOTP_OPTS: {
+		const struct can_isotp_options *opt = val;
+
+		/* only one broadcast flag at a time */
+		if (hweight32(opt->flags & ISOTP_ALL_BC_FLAGS) > 1)
+			return -EINVAL;
+
+		memcpy(&so->opt, opt, sizeof(*opt));
 
 		/* no separate rx_ext_address is given => use ext_address */
 		if (!(so->opt.flags & CAN_ISOTP_RX_EXT_ADDR))
 			so->opt.rx_ext_address = so->opt.ext_address;
 
-		/* these broadcast flags are not allowed together */
-		if (isotp_bc_flags(so) == ISOTP_ALL_BC_FLAGS) {
-			/* CAN_ISOTP_SF_BROADCAST is prioritized */
-			so->opt.flags &= ~CAN_ISOTP_CF_BROADCAST;
-
-			/* give user feedback on wrong config attempt */
-			ret = -EINVAL;
-		}
-
 		/* check for frame_txtime changes (0 => no changes) */
 		if (so->opt.frame_txtime) {
 			if (so->opt.frame_txtime == CAN_ISOTP_FRAME_TXTIME_ZERO)
 				so->frame_txtime = 0;
 			else
 				so->frame_txtime = so->opt.frame_txtime;
 		}
 		break;
+	}
 
 	case CAN_ISOTP_RECV_FC:
 		memcpy(&so->rxfc, val, sizeof(so->rxfc));
 		break;
 

-- 
2.53.0

