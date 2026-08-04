Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EAC2F25F5;
	Tue,  4 Aug 2026 07:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827553; cv=none; b=svAknXCIRmPywCuveINA0wjKwxUOtnaFVYKoGVqRbefUag2BQOTL3i+3yViBlfWrf1qQtT2USw8l89peqFD1ydClHxfSBM0ouzziVS+Z4n3yxyxjjN4E6/S8sVYx7zZo7anKh+bw0/5ujoBbeEF87MORqP2WTVZMxu25w6pLbE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827553; c=relaxed/simple;
	bh=8CHNoOjRnk4MkVbqj2nQ2c72oMZS36O4d55n1hfiQQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8UBvmsGIdFpognyKIJyHsf/O5IsYibZvzowZF3L+uOWdGStDYCKvBijA+MLCPzoBDrzEdBqT+mVHx8I/gGUIAFL1fs9BwJ6d8yFbfmstHNHZRpOA4CDlHQFup0oC97Z6FO+tCQhh+xhVorTFD2NbSwrqK2foOGwdncVNXpTOpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 32011200048;
	Tue, 04 Aug 2026 09:12:21 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wr9K1-002p8Y-0O;
	Tue, 04 Aug 2026 09:12:21 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wr9K1-0000000AMxv-02Eb;
	Tue, 04 Aug 2026 09:12:21 +0200
Date: Tue, 4 Aug 2026 09:12:20 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Felix Hoffmann <f3lix.dev@gmx.de>
Cc: linux-can@vger.kernel.org, Robin van der Gracht <robin@protonic.nl>,
	kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH can v2] can: j1939: avoid address-claim timer deadlock
Message-ID: <anGQ1Bx5OsMV7nAu@pengutronix.de>
References: <20260731134255.1002902-1-f3lix.dev@gmx.de>
 <20260803101503.21023-1-f3lix.dev@gmx.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260803101503.21023-1-f3lix.dev@gmx.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Felix,

Please send next patch stand alone, not in replay to the previous patch
or discussion.

On Mon, Aug 03, 2026 at 12:15:03PM +0200, Felix Hoffmann wrote:
> j1939_ac_process() holds priv->lock while synchronously canceling an
> ECU's address-claim hrtimer. The timer callback takes the same lock. If the
> callback starts on another CPU after the receive path takes the lock, the
> callback waits for priv->lock while hrtimer_cancel() waits for the callback
> to finish. This deadlocks both CPUs and makes the system unresponsive.
> 
> Replace the callback's blocking lock acquisition with write_trylock(). If
> the lock is busy, move the expiry forward and restart the timer. This lets
> a concurrent hrtimer_cancel() observe the callback finish and remove the
> requeued timer. Without a cancellation, address mapping is retried shortly.
> 
> The failed write trylock does not necessarily mean that the address-claim
> writer owns priv->lock. Receive processing also takes its read side for
> other frames, and an active reader prevents write_trylock() from
> succeeding. Document both the address-claim writer and receive-path readers
> as possible sources of contention.
> 
> Name the 1 ms retry interval J1939_ECU_TIMER_RETRY_DELAY_MS instead of
> using a literal in the callback. Track consecutive failures per ECU, reset
> the counter when its timer starts, and emit a warning guarded by
> net_ratelimit() on the fifth retry. Five is a pragmatic threshold for
> detecting unusual delay; it is not specified by J1939.
> 
> The timer uses HRTIMER_MODE_REL_SOFT, so its callback runs from
> HRTIMER_SOFTIRQ with bottom halves already disabled. write_trylock() does
> not change bottom-half state and must therefore pair with write_unlock() on
> success. The write_lock_bh()/write_unlock_bh() pair is unnecessary in this
> context.
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT5.6-Sol
> Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

Thank you!

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
