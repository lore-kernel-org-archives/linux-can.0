Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9556547063
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 00:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792024044; cv=pass; b=LwNz6XUxS6ypN8jeON1X6aVx4mRLZYVcJbgfBhQ8RsTsSlmqcPLZPETY187N7Rg+Z8btxCinxg+VdGLlercSCa0CcQcYPQlCrgP7t1VckcUoYhppKbutRsmLUzBbfd8bxxOPaPxKih6hNO89TnA2oUGcpi6jh4oB3KWQM6mwhnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792024044; c=relaxed/simple;
	bh=nrYKuLOs9AgCc+1ftxQ8aF6C3mWazW0tAoFxR/FAX40=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=l+UWqeZMhZ4Ak07xK3qImjzDRVHezgYsrCwgWAa77XZJ4niqpOWd1zce2qOXsvZx0kmZS37KO6V4fbTAGVTN47Mve8wLW4ypOnv7OO05roTTplkZeEijJVjRcDOYdbvXLDep1Qkl+LgeGGK581KlELtHlje5DoP49efU56K6oPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=avrzMsTd; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="avrzMsTd"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 943682004B4;
	Thu, 15 Oct 2026 02:27:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792024038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRYHtat/BFl76rQGhT/Qsv+l5UvbmcgGLxb4CM7WVFM=;
	b=avrzMsTd2JHRZ4eRTKOB1C9FfbV6xg4AFLeJx6IX4iwx2ox0fiIuK2LYPomVQY5llTl9pE
	meaTTeNnN5pwce6sqAp3zlrnVmtfJafAQ9U/PPvGzdn1+Tels6jghfr5e8MKYeToUVe3Ol
	eki/8Y1nib1Oz1iZECOWpQ8SmU18461TqWlKK2mzu2mYL+RpB9lM/BpH0N9rWZwJABTgrF
	hEe4+hRWqFHZxL3Xm9D61iBSMFcaSyhThTIeME+k4szXhSk9Tkqoz9TUWVvEv7ybP6S0Iv
	4rcMVu+WwhnRpnRuNO1dgrdJ5Kg3d0MsIIwOdyTZgEGtTwPLgysu4anZuqbL9A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792024038; a=rsa-sha256;
	cv=none;
	b=a+xvyv0V3U4KMZSZtvIo5wNBaiHA7TsaDgdLzhv/MwmHBDkz+MparyxfU95unnrRG21G9w
	ujazhVW3pqBFQRO+X3uuUsnn+Ut2kA+ePDnlv0H3TBWrJnDCq+u3/sI9QqMvmvY+R6ItVx
	+oCnuCGix71mpqbwCghJjlmygfr/tN+Q2tH8A5mgYR3FH05hccr5aEnqcoi2OeH/+ZuTve
	FWDj4mxjcD5Zdrnka56Eso1PAfhmlVVBCQDrOVSmgMKJinSDKJTCNLGv64xVacr/XG6gvC
	0JlMJOZEDuOiNW9zqMFrdtGv/BsuCW3wA0uHIbjJ9pMmcgjBbsxssEdsdWcucg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792024038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DRYHtat/BFl76rQGhT/Qsv+l5UvbmcgGLxb4CM7WVFM=;
	b=cyW4UyszJhYv3K3mf5QtoW5/RFhg0zNmNJNgz6MQ5uxE49Jj3o4KKjfRxEuHM68uPubYQv
	E0SYi42rsw7AHxo73NwB49E5vjAiOyfLNUH5pcV4h0r9H5FY+TVtqtWiS001uY1W9xxy4g
	u2Zuzc75GvjW7+o4/RBWYbWnIkVUf853KntBG9fET0nDDAOTvmfMZIkEBdUPyIs9bS4Bm3
	eEZ40WqVZLr7m2LWtGiGBCg+Mss+lsv9OEPiJNEj3Ns1nRVoYSWpqJW75uQH6S9HvaB/ce
	rpQOyaZICecRYFQB1H00wVMn6xH9JcVc0D3foNzP0G/pEgBvFNFwrRLBaR10Gg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH9JW-005wK6-1X;
	Thu, 15 Oct 2026 02:27:18 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2D9295C465C;
	Thu, 15 Oct 2026 00:27:18 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] can: j1939: cancel pending address claim timers
 from j1939_ecu_unmap_all()
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de, 
 Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <9ba38419-967a-4d47-bcdf-bbb2fa7d3e9f@I-love.SAKURA.ne.jp>
References: <9ba38419-967a-4d47-bcdf-bbb2fa7d3e9f@I-love.SAKURA.ne.jp>
Date: Thu, 15 Oct 2026 02:27:08 +0200
Message-Id: <179202402875.794844.18141702206663586949.b4-review@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=14882; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=nrYKuLOs9AgCc+1ftxQ8aF6C3mWazW0tAoFxR/FAX40=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6IPu45Gggm8KrnsS/j6czfssz+yV643H6w0Q/beumC
 yYfHITvdZSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAii5gZ/rvU6cT3VkwX3XMg
 Xa3G9P77TeskJ73uOHdVqPXIYvc5UU4Mf2VS/hwp2s1//nqyzMHOZRGTu9SMqwV2/z6ouO3lu3+
 nz3MCAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

> syzbot is reporting "struct j1939_ecu" refcount leak, for
>
>   j1939_ecu_get(ecu);
>   priv->ents[ecu->addr] = ecu;
>
> in j1939_ecu_map_locked() from j1939_ecu_timer_handler() can succeed
> even after
>
>   priv->ents[ecu->addr] = NULL;
>   j1939_ecu_put(ecu);
>
> in j1939_ecu_unmap_locked() from j1939_ecu_unmap_all() from
> __j1939_rx_release() from j1939_netdev_stop() has completed.
>
>   unregister_netdevice: waiting for vxcan1 to become free. Usage count = 3
>   ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
>        __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
>        netdev_hold include/linux/netdevice.h:4525 [inline]
>        j1939_ecu_create_locked+0x1c9/0x400 net/can/j1939/bus.c:159
>        j1939_local_ecu_get+0xeb/0x220 net/can/j1939/bus.c:293
>        j1939_sk_bind+0x70a/0xc60 net/can/j1939/socket.c:529
>        __sys_bind_socket net/socket.c:1920 [inline]
>        __sys_bind+0x2e3/0x410 net/socket.c:1951
>        __do_sys_bind net/socket.c:1956 [inline]
>        __se_sys_bind net/socket.c:1954 [inline]
>        __x64_sys_bind+0x7a/0x90 net/socket.c:1954
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>   ref_tracker: netdev@ffff8880710f0700 has 1/2 users at
>        __netdev_tracker_alloc include/linux/netdevice.h:4496 [inline]
>        netdev_hold include/linux/netdevice.h:4525 [inline]
>        j1939_priv_create net/can/j1939/main.c:140 [inline]
>        j1939_netdev_start+0x387/0xb20 net/can/j1939/main.c:268
>        j1939_sk_bind+0x946/0xc60 net/can/j1939/socket.c:506
>        __sys_bind_socket net/socket.c:1920 [inline]
>        __sys_bind+0x2e3/0x410 net/socket.c:1951
>        __do_sys_bind net/socket.c:1956 [inline]
>        __se_sys_bind net/socket.c:1954 [inline]
>        __x64_sys_bind+0x7a/0x90 net/socket.c:1954
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0x174/0x580 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fix this race condition by canceling address claim timers from
> j1939_ecu_unmap_all().
>
> Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928193312.553632-1-mkl%40pengutronix.de # [PATCH net 06/22]
> Assisted-by: Gemini-Pro gpt-6-astra opus-5-5
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

I've dropped this patch from the queue for now, as the review bot is not
happy:

regards,
Marc

pw-bot: cr

--- Patch [6]: [PATCH net-next 06/37] can: j1939: cancel pending address claim timers from j1939_ecu_unmap_all() ---
commit 7c02defe26504a34c2dadf178f83b26787eb129d
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: cancel pending address claim timers from j1939_ecu_unmap_all()

This patch makes j1939_ecu_unmap_all() cancel pending address claim
hrtimers on priv->ecus before it clears priv->ents[]. The goal is to stop
a late j1939_ecu_timer_handler() from re-mapping an ECU after teardown,
which leaks the ECU's references and hangs unregister_netdevice().

Link: https://patch.msgid.link/9ba38419-967a-4d47-bcdf-bbb2fa7d3e9f@I-love.SAKURA.ne.jp

> Reported-by: syzbot+e2af46126e0644cbebdd@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e2af46126e0644cbebdd

Discovered by: gpt-6-astra, opus-5-5, opus-5, sonnet-5 · Missed by: sashiko-gemini
Should this have a Fixes: tag and a Cc: stable@vger.kernel.org trailer?

j1939_ecu_unmap_all(), j1939_ecu_timer_start(), j1939_ecu_timer_cancel()
and j1939_ecu_timer_handler() all appear unchanged since:

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

Other fixes in the same series do carry Fixes: and Cc: stable trailers.
Examples are "can: proc: reset pkg_stats atomics individually" and "can:
convert unreliable ARPHRD_CAN type checks to robust can_get_ml_priv()".

> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a719379..0d109d1a3b4ae 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -99,8 +99,38 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
>  void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  {
>  	int i;
> +	struct j1939_ecu *ecu;
>
>  	write_lock_bh(&priv->lock);
> +	/* Cancel all pending address claim timers before unmapping.
> +	 * This prevents an orphaned late-firing timer from re-mapping
> +	 * an ECU after the spaces are cleared.
> +	 */

Discovered by: gpt-6-astra, opus-5-5, opus-5, sashiko-gemini · Missed by: sonnet-5
Does this fully close the race? The cancel loop only sees timers that are
armed while priv->lock is held. Nothing seems to stop a new timer from
being armed after the final write_unlock_bh() in this function.

In __j1939_rx_release(), j1939_can_rx_unregister() reaches
can_rx_unregister(). That function only does hlist_del_rcu() and
call_rcu(). It does not wait for a j1939_can_recv() that is already running
on another CPU:

net/can/j1939/main.c:__j1939_rx_release() {
	j1939_can_rx_unregister(priv);
	j1939_ecu_unmap_all(priv);
	j1939_priv_set(priv->ndev, NULL);
	...
}

Could this sequence happen?

CPU A                              CPU B
j1939_can_recv()
  j1939_ac_recv()
    j1939_ac_process()
                                   __j1939_rx_release()
                                     j1939_can_rx_unregister()
                                     j1939_ecu_unmap_all()
                                       write_lock_bh(&priv->lock)
      write_lock_bh(&priv->lock)       <cancel timers, clear ents[]>
      <spins>                          write_unlock_bh(&priv->lock)
      j1939_ecu_create_locked()
      j1939_ecu_timer_start()
                                     j1939_priv_set(priv->ndev, NULL)

250 ms later, j1939_ecu_timer_handler() calls j1939_ecu_map_locked() with
no teardown check. The ECU then goes back into priv->ents[] with an extra
reference.

j1939_priv_get_by_ndev() now returns NULL, so no later
j1939_ecu_unmap_all() can run for this priv. Would the ECU, its
netdev_hold() tracker and its priv reference then leak? That would give the
same "waiting for vxcan1 to become free" hang this patch is meant to fix.

The comment above seems to hold only for timers armed before the loop runs.

Would a synchronize_net() between j1939_can_rx_unregister() and
j1939_ecu_unmap_all() close this? Another option is a teardown flag checked
under priv->lock in j1939_ac_process(), j1939_ecu_timer_start() and
j1939_ecu_timer_handler().

> +rescan_timers:
> +	list_for_each_entry(ecu, &priv->ecus, list) {
> +		int ret = hrtimer_try_to_cancel(&ecu->ac_timer);
> +
> +		if (ret == 0) { /* Not active or already finished. */
> +			continue;
> +		} else if (ret == 1) { /* Successfully canceled. */
> +			/* Drop a ref from j1939_ecu_timer_start(). */
> +			j1939_ecu_put(ecu);

Discovered by: sashiko-gemini · Missed by: opus-5-5, opus-5, sonnet-5, gpt-6-astra · Confirmed by: opus-5-5
This looks pre-existing, but the new cancel loop depends on it. When
the last reference to a j1939_ecu goes away, __j1939_ecu_release()
does list_del(&ecu->list) on priv->ecus and frees the ECU. It does
not take priv->lock itself. It therefore relies on every final
j1939_ecu_put() being done under write_lock_bh(&priv->lock).

The lookup helpers do not guarantee that. j1939_ecu_get_by_addr()
and j1939_ecu_get_by_name() take read_lock_bh(&priv->lock), take a
reference and release the lock again. Their callers, for example
j1939_ac_recv(), then call j1939_ecu_put() with no lock held.

In the meantime another path may drop the remaining references under
priv->lock. The unlocked put is then the final one. Its list_del()
can run concurrently with a reader such as j1939_ecu_get_by_name()
walking priv->ecus under read_lock_bh(). It can also race with a
writer such as the rescan loop added here, or the list_add_tail() in
j1939_ecu_create_locked().

Can that corrupt priv->ecus, or let a walker step onto a freed
j1939_ecu?

With this patch, the timer reference of a pending ECU is dropped here
during teardown instead of later by j1939_ecu_timer_handler(). That
makes it more likely that a transient lookup reference ends up being
the last one.

The comment in the -1 branch shows the invariant is already
understood for j1939_ecu_timer_cancel(): an unlocked put must never
be the final reference. Should it also be enforced for the existing
unlocked callers?

Taking priv->lock inside __j1939_ecu_release() would deadlock for
the many callers that already hold it. Would a separate put helper
that wraps kref_put() in write_lock_bh(&priv->lock) work for the
unlocked callers? Or would you rather convert priv->ecus to RCU?

Discovered by: gpt-6-astra, opus-5-5, opus-5 · Missed by: sonnet-5, sashiko-gemini
This put is a new third release site for the timer reference. The comment
in j1939_ecu_timer_start() still lists only two:

	/* The ECU is held here and released in the
	 * j1939_ecu_timer_handler() or j1939_ecu_timer_cancel().
	 */

Should that comment be updated to mention j1939_ecu_unmap_all()? The same
applies to the ref counting notes in j1939_ac_process().

> +		} else { /* Executing on another CPU. */

Discovered by: opus-5 · Missed by: opus-5-5, sonnet-5, gpt-6-astra, sashiko-gemini · Confirmed by: opus-5-5
Is "Executing on another CPU" accurate? The hrtimer_try_to_cancel()
kernel-doc defines -1 only as "the timer is currently executing the
callback function and cannot be stopped".

On PREEMPT_RT without CONFIG_PREEMPT_RT_NEEDS_BH_LOCK, local_bh_disable()
only disables migration. The soft callback can therefore be preempted on
the same CPU before it takes priv->lock. The comment above
hrtimer_cancel_wait_running() describes this case.

The fallback to hrtimer_cancel() handles this correctly, so only the
comment is affected.

> +			/* Let j1939_ecu_timer_cancel() determine whether to
> +			 * drop a ref from j1939_ecu_timer_start(). But guard
> +			 * with a local ref in order to make sure that unlocked
> +			 * j1939_ecu_put() from j1939_ecu_timer_cancel() cannot
> +			 * be the final reference.
> +			 */
> +			j1939_ecu_get(ecu);

Discovered by: opus-5-5 · Missed by: opus-5, sonnet-5, gpt-6-astra, sashiko-gemini · Confirmed by: gpt-6-astra
This is a pre-existing issue, but can this kref_get() find an ECU whose
refcount has already reached zero?

__j1939_ecu_release() calls list_del(&ecu->list) on priv->ecus under
whatever lock the final putter holds. j1939_ac_recv() drops its reference
with no lock held, after j1939_ecu_get_by_addr() has released
read_lock_bh:

net/can/j1939/address-claim.c:j1939_ac_recv() {
	...
		ecu = j1939_ecu_get_by_addr(priv, skcb->addr.sa);
		if (ecu) {
			skcb->addr.src_name = ecu->name;
			j1939_ecu_put(ecu);
		}
	...
}

Take a mapped remote ECU that holds only its ents[] reference:

CPU X                              CPU Y
j1939_ac_recv()
  j1939_ecu_get_by_addr()   /* 2 */
                                   j1939_ac_process()  /* idle SA */
                                     write_lock_bh(&priv->lock)
                                     j1939_ecu_get_by_name_locked() /* 3 */
                                     j1939_ecu_unmap_locked()       /* 2 */
                                     j1939_ecu_put()                /* 1 */
                                     write_unlock_bh(&priv->lock)
  j1939_ecu_put()           /* 0 */
    __j1939_ecu_release()
      list_del(&ecu->list)  /* priv->lock not held */
      kfree(ecu)

A third CPU may be walking or changing priv->ecus under priv->lock at the
same time. Examples are this new rescan loop, j1939_ecu_find_by_name_locked()
and the list_add_tail() in j1939_ecu_create_locked().

Could that corrupt priv->ecus or lead to a use-after-free of the
j1939_ecu? The comment above describes the very invariant that
j1939_ac_recv() breaks: an unlocked j1939_ecu_put() must not be the final
reference.

> +			write_unlock_bh(&priv->lock);
> +			j1939_ecu_timer_cancel(ecu);

Discovered by: gpt-6-astra, opus-5-5, opus-5, sonnet-5 · Missed by: sashiko-gemini
This isn't a bug introduced by this patch. Here the lock is dropped before
j1939_ecu_timer_cancel(), but j1939_ac_process() still calls it with
write_lock_bh(&priv->lock) held:

net/can/j1939/address-claim.c:j1939_ac_process() {
	...
	write_lock_bh(&priv->lock);
	...
	/* cancel pending (previous) address claim */
	j1939_ecu_timer_cancel(ecu);
	...
}

hrtimer_cancel() waits for a running callback to finish, and
j1939_ecu_timer_handler() starts with write_lock_bh(&priv->lock). Suppose
an AC frame for a NAME with a different or idle SA arrives just as that
ECU's ac_timer expires:

CPU0 (CAN rx)                      CPU1 (HRTIMER_SOFTIRQ)
j1939_ac_process()
  write_lock_bh(&priv->lock)
                                   j1939_ecu_timer_handler()
                                     write_lock_bh(&priv->lock)
                                     <spins>
  j1939_ecu_timer_cancel()
    hrtimer_cancel()
      <waits for callback>

Can these two CPUs deadlock? On !PREEMPT_RT,
hrtimer_cancel_wait_running() is just cpu_relax(). On PREEMPT_RT this
looks like an ABBA between priv->lock and softirq_expiry_lock.

The new unlocked j1939_ecu_timer_cancel() call here runs with
j1939_netdev_lock or RTNL held. It would also hang behind such a deadlock.

> +			write_lock_bh(&priv->lock);
> +			j1939_ecu_put(ecu);
> +		}
> +		goto rescan_timers;

Discovered by: opus-5-5, opus-5 · Missed by: sonnet-5, gpt-6-astra, sashiko-gemini · Called a false positive by: gpt-6-astra
Can this goto make the walk quadratic? Every nonzero return from
hrtimer_try_to_cancel() restarts the walk from the head of priv->ecus,
with write_lock_bh(&priv->lock) held. ECUs that survive cancellation are
scanned again on every restart.

On the NETDEV_DOWN path, j1939_netdev_notify() calls j1939_ecu_unmap_all()
while sockets are still bound. j1939_sk_netdev_event_netdown() does not
drop their local ECU references.

Consider N bound sockets with distinct NAMEs, each with a 250 ms timer left
pending by AC frames. That looks like O(N^2) work with BH disabled and RTNL
held.

The restart is only needed in the -1 branch, where the lock is dropped. In
the ret == 1 case only the current entry can be freed. Would
list_for_each_entry_safe(), with a restart only in the -1 branch, keep the
common case linear?

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
