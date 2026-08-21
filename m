Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F79A3AD529
	for <linux-can@vger.kernel.org>; Fri, 21 Aug 2026 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300679; cv=none; b=QYqOJ1uIAcH0kC7lPN5CPFgRsX24Tpw3dWYvmRS42PiFEttsPlrmsZRrXqznMgJxd5tdmutwH3tWeY2Ma2PyC9JJkSg4K0cVIreFfOH4Fy4GH4YWrasOhqZ+wdlEg3eaKRPfMMLWzZ65iK3i/k9oAlXESyQ4hRpFXgnqNaBOvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300679; c=relaxed/simple;
	bh=YpxlG0B+wKngu8vICvtLg4grodoKRvc+ttY9uwk8Tjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IChOQ2XaV5ZMgDlmaDN0gJKKl/WuZ0uqb5cBOtRcG0Tj4TwiXsQjF3bw91yOrl5Cw5zU7Hdt55xok1fDuyK9ntAw7qSCljTu1CFez7Q+RaI6hVIGxi25I7ePfYu+mZcDVBfgZRpHjAGoJM16Ts60hlKXviunKux4vcSlWHkeV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 6D207201BD1;
	Fri, 21 Aug 2026 10:24:25 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wxKY5-002amg-1A;
	Fri, 21 Aug 2026 10:24:25 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wxKY5-00000002syr-12dj;
	Fri, 21 Aug 2026 10:24:25 +0200
Date: Fri, 21 Aug 2026 10:24:25 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH] can: j1939: j1939_sk_bind(): fix j1939_ecu leak when
 re-bind failed
Message-ID: <aogLOf_0rctRWYN3@pengutronix.de>
References: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8063b5c1-6171-4350-a7d1-6ccd079fb0ff@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Fri, Aug 21, 2026 at 01:28:13AM +0900, Tetsuo Handa wrote:
> syzbot is reporting "struct j1939_ecu" refcount leak, which occurs when
> netdev_hold() is called during ECU creation but the corresponding
> netdev_put() is never executed because the parent "struct j1939_ecu"
> object is leaked.
> 
....
> 
> The root cause lies in the error handling of j1939_sk_bind() during a
> re-bind operation (binding an already bound socket to the same interface).
> Currently, the function prematurely drops the old ECU references by calling
> j1939_local_ecu_put() before verifying whether the new configuration can be
> successfully acquired via j1939_local_ecu_get().
> 
> If j1939_local_ecu_get() subsequently fails, the function unconditionally
> calls j1939_netdev_stop() and clears jsk->priv. This leaves the socket in a
> half-broken state where the old ECU's refcount has already been decremented
> incompletely, but the socket destruct pathway (j1939_sk_sock_destruct) can
> no longer perform proper cleanup because jsk->priv is NULL. As a result,
> the old "struct j1939_ecu" remains orphaned on the priv->ecus list,
> permanently leaking both the ECU object and the net_device reference held
> inside it.
> 
> Fix this by deferring the removal and release of the old ECU references
> until after j1939_local_ecu_get() has successfully acquired the new
> resources. As a side effect of this change, the socket's state no longer
> changes when the re-bind operation failed.
> 
> Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
> Analyzed-by: AI Mode in Google Search (no mail address)
> Fixes: f214744c8a27 ("can: j1939: j1939_sk_bind(): call j1939_priv_put() immediately when j1939_local_ecu_get() failed")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
