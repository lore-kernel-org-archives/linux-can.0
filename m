Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A9372EE2
	for <linux-can@vger.kernel.org>; Sat, 10 Oct 2026 13:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639836; cv=none; b=ZOt9BokW2eAiTvszBoa2MwAYflWjiLbWigrk1mPNCsUKpx+GJsyNOjXZSpABilXhZzgiuV8VrkVGwYFcSZJgosNRJrC9/EGIaxtfp1InEwxEJd+NMvWzeyOv0LUmDWxllSjV/6IwCa6R9NNmOw1f8IN2CG4oNPaPPhHQVgDI0XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639836; c=relaxed/simple;
	bh=pAfapPPCe29xgglIUmtCAcbZZbG458uMhGLp+QHv5Zc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=dsPLvrRVlhTff591tcJdEmmfIQnz+9eYU8LM9ZNo8MHlseMOT3doQJFPsIb+Q7dbZCCpdWalPhyErVR5PoW2BHnZBoq3ABtnghgKWyPHzIZXlcFMnQ1eWg3yhyswwj4CYCLnPF40jijJqkQGjFPVzAvDj3/DkxgV27tGwKn9954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBJh943J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBJh943J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2411C1F000FF;
	Sat, 10 Oct 2026 13:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639835;
	bh=2ttCRnLpcC4MqxdwlGBf6KxZK5jLxbw4V5yxInFT0GE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iBJh943JtOsrKe5sdSIDI7t/ChJAa9U40KtdP5yCaL00AnQ1fmKfBH2P+qn/8eS6b
	 lqrHyk9a8o85SjnBm9KU1VcOqNlW5SEto+H/MzuG9vje4KKF9tFxzLpxGufIZCNRJT
	 CVfKJNJSEocsLjCRVFPsef58qZKMOEqgc1T6l++8A0HrrPV93Klw4N7mtSjFEEbFvh
	 q7+9xwppD+41DgN0S8rPCB2EmMfkR7ysq2aXeBp7wXPv0cS912qyxXodaQF2j2SKla
	 T7i2YKC0fE4xP104XnuaZT9WkILi2YKjhta2+0/oI7fDAJXAvhtzpL3CZDnFF00dxf
	 jmfaonFunCX3w==
Message-ID: <sashiko-outbox-166594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 06/37] can: j1939: cancel pending address claim
 timers from j1939_ecu_unmap_all()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20261009134323.64064-7-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
 <20261009134323.64064-7-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 13:43:54 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] can: j1939: list corruption in __j1939_ecu_release due to unlocked=
 list_del
- [High] can: j1939: incomplete fix allows timer refcount leak via concurre=
nt RX packets
--

commit 9fb46427edf45ea42aa1cdb4e5ea2ab8598e49e7
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

can: j1939: cancel pending address claim timers from j1939_ecu_unmap_all()

This commit cancels pending address claim timers from j1939_ecu_unmap_all()
to fix a struct j1939_ecu refcount leak reported by syzbot. It ensures time=
rs
are cleanly stopped when bringing down the interface to prevent an unmapped
ECU from persisting.

Link: https://patch.msgid.link/9ba38419-967a-4d47-bcdf-bbb2fa7d3e9f@I-love.=
SAKURA.ne.jp

> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -99,8 +99,38 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
>  void j1939_ecu_unmap_all(struct j1939_priv *priv)
>  {
>  	int i;
> +	struct j1939_ecu *ecu;
> =20
>  	write_lock_bh(&priv->lock);

[Severity: High]
Does this completely prevent the refcount leak if a concurrent RX packet is
being processed?

In __j1939_rx_release(), j1939_can_rx_unregister() uses call_rcu() and does
not block before calling j1939_ecu_unmap_all():

net/can/j1939/main.c:__j1939_rx_release()
    j1939_can_rx_unregister(priv);
    j1939_ecu_unmap_all(priv);

Since the eventual synchronize_rcu() in j1939_sk_release() happens later,
a concurrent can_receive() could process a J1939_PGN_ADDRESS_CLAIMED frame,
acquire priv->lock after j1939_ecu_unmap_all() drops it, and invoke
j1939_ecu_timer_start() in j1939_ac_process().

Would this spawn a new active timer and map the ECU again after all cleanup
has completed, defeating the fix and hanging the netdev unregister?

> +	/* Cancel all pending address claim timers before unmapping.
> +	 * This prevents an orphaned late-firing timer from re-mapping
> +	 * an ECU after the spaces are cleared.
> +	 */
> +rescan_timers:
> +	list_for_each_entry(ecu, &priv->ecus, list) {
> +		int ret =3D hrtimer_try_to_cancel(&ecu->ac_timer);
> +
> +		if (ret =3D=3D 0) { /* Not active or already finished. */
> +			continue;
> +		} else if (ret =3D=3D 1) { /* Successfully canceled. */
> +			/* Drop a ref from j1939_ecu_timer_start(). */
> +			j1939_ecu_put(ecu);

[Severity: High]
By dropping the timer's reference early here, could we shift the final
reference drop to the network receive paths like j1939_ac_recv() or
j1939_ac_process()?

When an ECU's final reference drops, j1939_ecu_put() triggers
__j1939_ecu_release() which removes the ECU from priv->ecus:

net/can/j1939/bus.c:__j1939_ecu_release() {
    ...
    list_del(&ecu->list);
}

Since paths like j1939_ac_recv() and j1939_ac_process() call j1939_ecu_put()
completely unlocked, could this list_del() execute concurrently with list
traversals under read_lock_bh(&priv->lock), leading to list corruption?

> +		} else { /* Executing on another CPU. */
> +			/* Let j1939_ecu_timer_cancel() determine whether to
> +			 * drop a ref from j1939_ecu_timer_start(). But guard
> +			 * with a local ref in order to make sure that unlocked
> +			 * j1939_ecu_put() from j1939_ecu_timer_cancel() cannot
> +			 * be the final reference.
> +			 */
> +			j1939_ecu_get(ecu);
> +			write_unlock_bh(&priv->lock);
> +			j1939_ecu_timer_cancel(ecu);
> +			write_lock_bh(&priv->lock);
> +			j1939_ecu_put(ecu);
> +		}
> +		goto rescan_timers;
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009134323.6406=
4-1-mkl@pengutronix.de?part=3D6
