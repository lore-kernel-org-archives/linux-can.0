Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933359;
	b=i802EOuKoyK3EvLdAjBV/4kqu1JpqHoiqwARAr4k4C8zVFYDQYznm4cHkc0CJ8eebTyl
	 +SNlrFyQ6HL78pKhQSVTbXalWuhNsJ+p5S35Mbxb+f8qn50sv9Y5QuQONQEWse8nkhQTK
	 VQe6n17SJsynYKSmF2XR51qHQmOQZIus0+6dO+00xl7wlRc1PTVNUAhT8m6GsTZWvhwBW
	 uFLIVcSs2aoSgNjseV8QFy6JXRt/XHRhYOAYWjppd+7/vH9Pf0WEsvnTvSXSB/y0VteQd
	 F/ilWpfMxAtu0WW+3A1Ig/keXFjHi0YFToXk/GKvZtWaDjTtfV+DmQCnm6Q0FGvWlzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933359;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=nI8Z3lBhIZ8iv540ArlzGn6Yla1bfKnN9wOLCvHtrvQ=;
	b=tNm+ZD2dcLf0SnVYKW7NSdqmww6BlhK3wGxoBc8ciQBLNIA0JzzpqWUNhH/DCkhL9c9s
	 Q+IGPAzoT75uRb+NEcyabRGyuCt+gh4GrFd+NdbAFDNyqoMYOYGrWYQ2s8i04+gMO+GtH
	 zTMoQxgcivnnnzPeCkKI0LBMu+uWKzVzCl2+9tHBnF0KrnWFjjZd1mKuSlVHlyqd3ctKH
	 ulzM+3JiPtDCP+WzytP+2GBTGKZyuGkzPWrO6HWenBY0o4SqByUHo2fEzqGfCUhykjGhU
	 t2d+znmVuLI5I5nZaCLLt1TM3diSvYxEGhAFv8i0df63cBsQC+1rSCs9EDJbp7ueSww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mlpMTzKP;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=uBgPqGiW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF3C606A32A
	for <linux-can@vger.kernel.org>; Tue, 17 Nov 2026 16:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BF3C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mlpMTzKP;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=uBgPqGiW
ARC-Seal: i=1; a=rsa-sha256; t=1794933349; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HF2iyy/0g1s8E9nDQDTy1WfMoHs8S6HxkSfKGabRhe9f6oxbnI/vO9LYM5MseEIPqo
    FDi9u1VP+nUo8Ji3gAYGwYNHst+GzbpM9rGWbkDEWxPNaDDjpaG+VVNlyGBFgiCdi26+
    7v/rmFF2gw6aLhh/lMr1AEMz5B/vkF57CzIqDoLyQojhQoT2uwvC4gWvCnbaNVE+GpWu
    KmOuu6S4k6K4Gj0KOpoz5+hJA2a6FQFmV9v51XebyN3H1zB1Fe8ZUP89JtgGnyGHRrQ+
    1j5Z8Y4wQ8GfwXYoXDVdMsTncJs/G7aPye++3o2/wqXCOzjPoPxef6fLmZKJ65ecfl84
    BBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933349;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=nI8Z3lBhIZ8iv540ArlzGn6Yla1bfKnN9wOLCvHtrvQ=;
    b=dHmcLnBMBURes+JBLrOcXtxypmA9kJD93oPZZ/V3/0jVAabnDI7pCNRnXrzvtrdJWz
    QH+OMdT7Q5Lbb7WWGVJobH6EBFmQeX2Cia43aFVvI7FApqX5REzTouf2cnDnd94bhwXp
    HUpUa79lgDIvXRz/Po+ePeMnxisai9Wf9zNbXvl3pE6yG2ZQoM6GMjfX5YPMUu7T6TwL
    YYnn46IRzHizH00r+NN/MYds6s0FBO1HAv7loqDzLWqlNjqusn9179AnTraLv5+QWRlk
    0Z07e4rznKek5ChAC5+juvvXWMD+qy69kM0rGVBdXBAht4UoniNU0DFwUIDnLbNvmZp4
    VAMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933349;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=nI8Z3lBhIZ8iv540ArlzGn6Yla1bfKnN9wOLCvHtrvQ=;
    b=mlpMTzKPjAsB4S91r6rLhqGc1a3c5OXZXBG4QJK6pc6he+lnUF/O/IndrB1jMIeCpY
    c5342jP5aRxQQqmq2bpQPs1S1ifhQoHk4FJnkFKuoUuq/WB07mUwMUpaQZbN6r7MEOyW
    43VWaCoffSMBgPRH8uY8nakhNt5nxllTdPU3/eWeKTGl80+ycc9KFo8nW8xLKvYAqRZm
    iwYUbf0kgAX1Bw3r0hmIMxya0IALg26WVu8H8mmd37e1p34C9jYdqBXILMmooM7uZb/V
    qoH7+TauoVcCCCoghzEL274hIALla3II0kqCF2GHxlWlpvO+DWrB3a1/b5oHTQUekNSE
    4VFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794933349;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=nI8Z3lBhIZ8iv540ArlzGn6Yla1bfKnN9wOLCvHtrvQ=;
    b=uBgPqGiWq/pxSJ4aq73DiPc13/rA1/2SvXvbH8IX2IpefOmDQTi4sMKUU+38vH6gth
    HDc5Cd1ZV4AMXe+pRpCA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [127.0.1.1]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AHGZncei
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 17:35:49 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Tue, 17 Nov 2026 17:35:49 +0100
Subject: [PATCH v6 8/8] can: netlink: fix static FD-NON-ISO mode validation
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
Message-Id: <20261117-can-bcmlock-memcg-v6-8-6826a6227d36@hartkopp.net>
References: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
In-Reply-To: <20261117-can-bcmlock-memcg-v6-0-6826a6227d36@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Zhu Ling <zhuling0805@qq.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794933347; l=3310;
 i=socketcan@hartkopp.net; s=20260128; h=from:subject:message-id;
 bh=Jcyp7DaVrbq4wHlDgGvCxc/oywDiIHnHVLfdhYJ/mjg=;
 b=D/eyS/9AKvSjl40Ok+Nf4mT4px9oasfBlko0AtBTEEneLJVaCWatI3ArQcZsvFWNV+0FuVUmD
 GDJBL3oPYMECBnHYvejWtX8RDTJH0a/kwN0RlbVV+e/6ipr7Lq6Ou3k
X-Developer-Key: i=socketcan@hartkopp.net; a=ed25519;
 pk=/gU/7/wBqak3kTsTeFbCCqUi9dnh+1i6ITEkfPj/BvU=

From: Zhu Ling <zhuling0805@qq.com>

Controllers with a static CAN_CTRLMODE_FD_NON_ISO mode (M_CAN v3.0.x and
v3.1.x, PEAK pcan_usb_fd with firmware < 2.x) do not require the
'fd-non-iso' option to be provided when CAN FD is not switched on by the
IFLA_CAN_CTRLMODE request.

Since commit 6742ca18cb41 ("can: netlink: add userland error messages")
ctrlstatic_missing is calculated before this exception is applied to
ctrlstatic, which is not evaluated afterwards. As a result every
IFLA_CAN_CTRLMODE request on such controllers that does not contain
'fd-non-iso on' is rejected with -EOPNOTSUPP and "missing required
FD-NON-ISO static control mode", e.g. 'fd off', 'loopback on' or
'one-shot on', regardless of the current CAN FD state.

Apply the exception to ctrlstatic_missing instead.

The exception must only relax the requirement to *provide* the static
FD-NON-ISO mode. It must not allow to *switch off* a static mode: before
the above mentioned commit a request like 'fd-non-iso off' passed the
check and removed the static CAN_CTRLMODE_FD_NON_ISO bit from
priv->ctrlmode. As can_get_static_ctrlmode() derives the static modes
from priv->ctrlmode, this information was lost permanently. Therefore
reject any request that explicitly switches off a static control mode
with a dedicated error message. With this check in place a static mode
can never be cleared by the 'priv->ctrlmode &= ~cm->mask' operation as
every static bit in cm->mask is also set in maskedflags.

The request is rejected independent of the resulting CAN FD state, as
accepting it while CAN FD is switched off would remove the static mode
from priv->ctrlmode as well.

Fixes: 6742ca18cb41 ("can: netlink: add userland error messages")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
Link: https://lore.kernel.org/all/tencent_3A964832542399A780E646D6A6246335C409@qq.com/
[Hartkopp: reject switching off static control modes instead of restoring
 them, extend the commit message (Sashiko review)]
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261115095746.709371-1-mkl%40pengutronix.de
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dev/netlink.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 081dfddda000..521e2496e2cc 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -328,13 +328,21 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 				   "requested control mode %s not supported",
 				   can_get_ctrlmode_str(notsupp));
 		return -EOPNOTSUPP;
 	}
 
+	/* static control modes can not be switched off */
+	if (deactivated & ctrlstatic) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "static control mode %s can not be switched off",
+				   can_get_ctrlmode_str(deactivated & ctrlstatic));
+		return -EOPNOTSUPP;
+	}
+
 	/* do not check for static fd-non-iso if 'fd' is disabled */
 	if (!(maskedflags & CAN_CTRLMODE_FD))
-		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
+		ctrlstatic_missing &= ~CAN_CTRLMODE_FD_NON_ISO;
 
 	if (ctrlstatic_missing) {
 		NL_SET_ERR_MSG_FMT(extack,
 				   "missing required %s static control mode",
 				   can_get_ctrlmode_str(ctrlstatic_missing));

-- 
2.53.0

