Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D362D7D2E
	for <linux-can@vger.kernel.org>; Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783771636; cv=none; b=k+u7BWT+RR957yC+QzKIwWdT9jGY6OqONF948V7MY2XTYgSrncOqguF7oCnQ1GgN2cDRA3CN/ETutH30upKlqU2bkxaQFmZodx3HHVrbVn2G1NvL2Y3YS+82eGtmFlJuIphxWR1u2LSsvOj2F1xpWRQ8bCOG8xDn0JX+xZM5JXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783771636; c=relaxed/simple;
	bh=12oYQTF06y7EZTDFDxvMuQLvorddmmzlWvLt5KfmSXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QSdr72QZg05q065wz5WKA57pfyE78oP9fo3clrTkCzpRpKKlw+jgFLPxPv9n73CIqcvAMnrZlGzf+VdV64BcZVXVQF3ZWIXzFtFyNMgUu1QeESO/fXKFZ/OQ/XsVeAnVGU/0kbvddZxekAqn/aLfdlFFUUBoImCbRxFrrCXH2Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJPCz0MQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJPCz0MQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32FC1C2BCF4;
	Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783771636;
	bh=12oYQTF06y7EZTDFDxvMuQLvorddmmzlWvLt5KfmSXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hJPCz0MQxzYupz3IW1XMZxPsy4MjgB31GJjbdgashss/ASewlHIAWwjs8Fexe8rCl
	 ammHgvc+wm9ySXod2h4B1tN6SxfTMHySOlYoMwHQEjGKNwp9yNOEYjG7Oi+DP/onqO
	 EAUXYqqZ/7VZIeTSrvPXzNQ/YzhNAN+2gA9ash3vxNxNEiZLBRJC+oyqvGD1shZwgN
	 B/6M0V4SHzMwIjAtA9HBFgOkUoyL4TDiRVsnyLW3ibec2Lx9+6iu3zYax0jrkFMFXv
	 6R8ghsaTtcaSaZKigzkO3cwnIob4xnsysZD0IpRPIoo6PVidZPbKfZi3o9c2JjkNfJ
	 /RY1dNB2yB0MQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B97C43458;
	Sat, 11 Jul 2026 12:07:16 +0000 (UTC)
From: Oliver Hartkopp via B4 Relay <devnull+socketcan.hartkopp.net@kernel.org>
Date: Sat, 11 Jul 2026 14:07:16 +0200
Subject: [PATCH v7 5/5] can: isotp: fix state machine corruption on signal
 interruption
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-isotp-fixes-v7-5-f03af24d8397@hartkopp.net>
References: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
In-Reply-To: <20260711-isotp-fixes-v7-0-f03af24d8397@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783771634; l=1184;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=DD+TppSdrai1Iw0roPDDTFR1Usz3uK/bpVoyGPmzuq8=;
 b=jc7b3ezFetZsSxV17tdBKsIcC/KNxSgI3PMjVotmCc3AnrKh3pCWOgmD0EJEl5GxTlr5g31uu
 0PSPr8LD4qWC49zxlCIddVeU1cGiLkiveiCe4gyzRWJ9OH9arF+VOo7
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=
X-Endpoint-Received: by B4 Relay for socketcan@hartkopp.net/20260128 with
 auth_id=620
X-Original-From: Oliver Hartkopp <socketcan@hartkopp.net>
Reply-To: socketcan@hartkopp.net

From: Oliver Hartkopp <socketcan@hartkopp.net>

If a thread blocked in isotp_sendmsg() waiting for a previous transfer
to finish is interrupted by a signal, jumping to the cleanup labels
incorrectly cancels active timers and forces 'so->tx.state' back to
ISOTP_IDLE. Since this thread never owned the active transmission, it
abruptly aborts another thread's legitimate transfer, so return the
interruption error directly.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index fdb2109d7c27..c9cd78df3a6e 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1017,11 +1017,11 @@ static int isotp_sendmsg(struct socket *sock, struct msghdr *msg, size_t size)
 			return -EADDRNOTAVAIL;
 
 		/* wait for complete transmission of current pdu */
 		err = wait_event_interruptible(so->wait, so->tx.state == ISOTP_IDLE);
 		if (err)
-			goto err_event_drop;
+			return err;
 	}
 
 	/* new transfer: bump generation and drop any echo tag left behind
 	 * by a previously aborted transfer
 	 */

-- 
2.53.0


