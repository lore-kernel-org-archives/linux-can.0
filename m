Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861223;
	b=upfHUJJReEHEK3QJ0rfHRJLX4DiAz+93nQYS8/u0MIBMiySVLSkF299jbNMVExE8Nsnv
	 4uqFWDtYSWIKX4oh+RSsSCDG0JBNkj4WSN/IKCK2+WsRT+wYB0owFAkAs2FYQRpRj6D5R
	 DzlIIB0lc6R/cEa6aCnmVt+ZRvI4hOr5DipQ+TORM3isAj9AODxBhIqRjMH76zl4tmjQk
	 HgH4/D26gd6xl4h84dAIN7Y+zYy6Ot1bqUBq0cTK1wFyxiKZMUVwui+J6PFis/+bM+z+i
	 zBkiDe1hecyQzPZPenfHsf4O9jXBMalE+qO6rrwLn8UNUu5REBCyQVE6JMWs9BASKQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861223;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=cvDB3aSMPM3hkY9j2SXKlUuav8dFQycPnl7YiE3kfEY=;
	b=SoD8z8lZ5FEVFtSqOPNW9jeGcMRSfcq91YnRzMKqJtL39VWkcDQZ861Nnrj1w1GY8PsH
	 P5PTDKk+WD9ZGwlj5mbDqC5LQCMcvg0/6gCSWDLDyhNYxBLMmpHDpwxwJL8iHpKDZ+IDw
	 67rOyZahbCsClbw/jgi/fYtHltDR5+JzHIEe/TQI8l4fb1E7rOWVqv0MbONVPP3dOhfOj
	 5MwY+bIaplNdAvyp4rQvofQGwAerjryuYusKY9eYUfOMQX+LU51Y2aeXViXTLW0EusAnX
	 /to+LnJ5FCI7WVwAeZxNhegRzGCiHPNCHQHu/CypJXbLeJMs6bI8StLzwhiECPfw3gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrGwOMSy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A620606A31C
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrGwOMSy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9021F000C1;
	Sat, 28 Nov 2026 10:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861223;
	bh=cvDB3aSMPM3hkY9j2SXKlUuav8dFQycPnl7YiE3kfEY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PrGwOMSyhd7HTyhoTw+DhL4qLhz3q85vGdllwGVksmQJ1h9QwA0uQONbn5w8giAzv
	 ox0ypv/+3V7jvP/jvLGJp+noJDdyyEUwSU6RqXgE0DBosah03rLQkUdSQh0FPP8r96
	 o1B71JPmsXWUibMEKHMwMFMydPDF3JwU81c/b9ERzkd0PZpvHVtlqTozHK0enCf2dN
	 XSeJvttb+y7wunxxL2tK/ls1h6HJLcsbq0Un7zDEXRn9E+pZKiiNQIDoQtmy1woxfX
	 3/bEpnj/xv5G/a6jPKwhj0c0lDNBl54doTJ2hSb3feeP5ngh+lLq6uN8ZPdQq1czHN
	 ouLpMAfNMeslA==
Subject:
 Re: [PATCH can-next 13/22] can: isotp: do not send FC.OVFLW in listen mode
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sashiko-bot@kernel.org,
 zihanx@nebusec.ai, o.rempel@pengutronix.de, yewentian395@gmail.com,
 kuba@kernel.org
Date: Sat, 28 Nov 2026 10:20:22 +0000
Message-ID: <179586122213.3131.13775243172879465077@kernel.org>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-13-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-13-681ef8d8c2c9@hartkopp.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit "can: isotp: do not send FC.OVFLW in listen mode" fixes a
  bug that is visible on the bus and has existed since isotp was first…

--

can: isotp: do not send FC.OVFLW in listen mode

This commit moves the CAN_ISOTP_LISTEN_MODE check out of isotp_rcv_ff()
and isotp_rcv_cf() and into isotp_send_fc(). With the check there, a
listen-mode socket no longer sends any flow control frame. That includes
the FC.OVFLW frame that isotp_rcv_ff() sent when the FF_DL exceeded the
receive buffer.

> isotp_rcv_ff() sends a FC with overflow status when the FF_DL exceeds
> the receive buffer without checking CAN_ISOTP_LISTEN_MODE. So a
> listening socket sends a FC on the bus, which can abort the transfer
> between other nodes using the same CAN IDs.
>
> Move the listen mode check from the callers into isotp_send_fc() before
> any state changes to cover all FC frames.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

[Severity: Low]
Should this have Fixes: and Cc: stable tags?

The ordering this patch fixes was there in the original isotp commit. In
isotp_rcv_ff(), the overflow branch sent FC.OVFLW before the listen-mode
check was reached:

    if (so->rx.len > MAX_MSG_LENGTH) {
        isotp_send_fc(sk, ae, ISOTP_FC_OVFLW);
        return 1;
    }
    ...
    if (so->opt.flags & CAN_ISOTP_LISTEN_MODE)
        return 0;

Without tags, stable kernels since v5.10 may not get this fix. A
listen-mode socket on those kernels would still answer an oversized First
Frame with FC.OVFLW on so->txid. The real sender would then abort a
transfer between other nodes.

Would something like this be appropriate?

    Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
    Cc: stable@vger.kernel.org

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9%40hartkopp.net
