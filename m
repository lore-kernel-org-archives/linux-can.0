Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0E643F0A9
	for <linux-can@vger.kernel.org>; Fri, 17 Jul 2026 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784306764; cv=none; b=poWa5e8E9DxKbmVvwpqM1w9M+5UYkaqpYXFBeEof02aOfzwKaQlDl0HsSmPSJj84yadylGofbQLX7ggVha8HDN0vRpFaWJCn1OKT6daJ/1qKJgln6614q1AsiXE1au3eVIM6Fktofmp9qDkoClzO/vwwfmcBvJkebT67sOgW/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784306764; c=relaxed/simple;
	bh=Aut6hFStKg4hku/YD1jyGkm2gc7WaRT1Z4ZqhxHLZko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B7jFJmf1h/MWl6vg4zwdp3liHRl32u4IBrHOfKwZxcxb8l4dab6MKY/I8r5quBFo3+jW2nL7CyvH8/dh7+J14tkZBKE/7kn8e4LYTwYwFoyrOzaVyrdP/AuFIZv3wQaQ19X4uvynAHFOpj/nryf9ZDtbm6xw0xUh/01n6xFsznA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFzTSqr6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFzTSqr6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6CB1F000E9;
	Fri, 17 Jul 2026 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784306763;
	bh=74f/Kc8Gl1/hEdKX+LW1QRpUV7OPPa8kwQjRe3ENH1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UFzTSqr6sFQB/w9siNHSe2tYq/mTsYO5eKMR32tS7q/t4XF9YroDmW229P6aYeyOt
	 pAzb4HN52bBHHY4wClREsgYXyufjMRWP5GqDMfDt7wsvzpsUIx8RVINsKnJkTmREri
	 RTncnZRIgQPJL0KCrm0I+9HUUY8S/tvqiLg/wV6ZTTW+F+nEyx/93q7+1B7RZn3hyD
	 AXnNl7EZxrTncOsQiYJugB+u3aYPAoBLKkzkSnLd6F51W1+WO6c5TCs0A9Tu0z/byQ
	 LUVJOsHqyGYo7jRzG7djqwCVYIUEbgGKOUFDnZFNAXFFV45Vt7FGweNs0TIyKmMJTU
	 0bsOqN1JL5Ezw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 17/19] can: isotp: use unconditional
 synchronize_rcu() in isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260716155528.809908-18-mkl@pengutronix.de>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-18-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 16:46:02 +0000
Message-Id: <20260717164602.CF6CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If a CAN ISOTP socket is closed concurrently with the unregistrati=
on of its bound netdevice, `dev_get_by_index()` fails, causing `isotp_relea=
se()` to skip CAN RX filter unregistration. This permanently leaks the filt=
er and leaves it active, leading to a Use-After-Free.
- [High] isotp_sendmsg() arbitrarily aborts an ongoing concurrent transmiss=
ion if interrupted by a signal while waiting.
--

--- Patch [17]: [PATCH net 17/19] can: isotp: use unconditional synchronize=
_rcu() in isotp_release() ---
commit c0a31977a8d3b86aee8a7406999fdf381f2bbded
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

isotp_notify() unregisters the CAN filters without waiting for a grace
period. This patch makes isotp_release() always call synchronize_rcu()
before cancelling the timers, closing a race condition where a timer
could be cancelled while an in-flight isotp_rcv() is still executing.

Closes: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.=
kernel.org/
Link: https://patch.msgid.link/20260712-isotp-fixes-v10-1-793a1b1ce17f@hart=
kopp.net

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..d30937345bcdc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1237,11 +1237,18 @@ static int isotp_release(struct socket *sock)
>  						  SINGLE_MASK(so->txid),
>  						  isotp_rcv_echo, sk);
>  				dev_put(dev);
> -				synchronize_rcu();
>  			}
>  		}
>  	}
> =20
> +	/* Always wait for a grace period before touching the timers below.
> +	 * A concurrent NETDEV_UNREGISTER may have already unregistered our
> +	 * filters and cleared so->bound in isotp_notify() without waiting
> +	 * for in-flight isotp_rcv() callers to finish, so this call must not
> +	 * be skipped just because so->bound is already 0 here.
> +	 */
> +	synchronize_rcu();
> +

[Severity: High]
This is a pre-existing issue, but I have a question about how the socket
teardown handles missing network devices.

If unlist_netdevice() removes the device from the index before isotp_releas=
e()
calls dev_get_by_index(), will the lookup fail?

net/can/isotp.c:isotp_release() {
    ...
    dev =3D dev_get_by_index(net, so->ifindex);
    if (dev) {
        ...
        can_rx_unregister(...);
        ...
    }
    ...
    synchronize_rcu();
}

If dev_get_by_index() fails, can_rx_unregister() is skipped. Since
isotp_release() also removes the socket from the notifier list, will the
subsequent NETDEV_UNREGISTER event also fail to unregister the filter?

If the filter remains active in the device's RCU-protected lists, does
synchronize_rcu() adequately protect against new readers? While it waits for
existing readers, could a new softirq reader start after synchronize_rcu()
returns, find the leaked filter, and cause a use-after-free by accessing the
freed socket?

Could this be mitigated by tracking the net_device directly with
netdevice_tracker?

>  	hrtimer_cancel(&so->txfrtimer);
>  	hrtimer_cancel(&so->txtimer);
>  	hrtimer_cancel(&so->rxtimer);

I also noticed another pre-existing issue in this file.

[Severity: High]
This isn't a bug introduced by this patch, but does the error handling in
isotp_sendmsg() safely manage concurrent senders?

If multiple threads attempt to send on the same socket, one thread may acqu=
ire
the ISOTP_SENDING state while another thread waits in
wait_event_interruptible(). If the waiting thread receives a signal:

net/can/isotp.c:isotp_sendmsg() {
    ...
    err =3D wait_event_interruptible(so->wait, so->tx.state =3D=3D ISOTP_ID=
LE);
    if (err)
        goto err_event_drop;
    ...
err_event_drop:
    so->tx.state =3D ISOTP_IDLE;
    hrtimer_cancel(&so->txfrtimer);
    ...
}

Does jumping to err_event_drop unconditionally force so->tx.state to ISOTP_=
IDLE
and cancel the transmission timers, directly aborting the active thread's
transmission?

If the socket state is reset, new transmissions could start, but could hard=
ware
echoes or FC frames from the aborted transmission still arrive and corrupt =
the
new transmission's state, since so->cfecho is not cleared?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716155528.8099=
08-1-mkl@pengutronix.de?part=3D17
