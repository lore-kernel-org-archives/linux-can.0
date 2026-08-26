Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C9D3537E8
	for <linux-can@vger.kernel.org>; Wed, 26 Aug 2026 05:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787720419; cv=none; b=FO4SIAZzQpMfhF1M4dN+S9cut31/ztPwlOlKCSCojWJRA8OhDfl8NKoQzMV7kRjwLuxw91Gwd17ukUKYiIrV1ZxUc/ifCod2VEPGhzMMWgD8bwtB2BS0ejiNoNlq1jeLOWALebctNzXs6Ju0jAWaNLg7yTPdkTC6L76a08ja+0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787720419; c=relaxed/simple;
	bh=UXRmdD8MPLUWuE3hJ4sbIE/ZOI1vBPxw0RSPJKjZ53g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWoYjrOZubxY4cJycd0XcIIznj5vpoApdT53gF8RXKSslfWhr8d//QTeciE2Zm1o6ADup4dfn2QGTEe+WFMgv0qmzsxUtiAX7b/FNfT+wD9A70ssSx6aQ7cSGwySgvs269KYm0YbZemXi3gzE/EO72oZBrOjeg35QOA/Y5X3lNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4AC74201923;
	Wed, 26 Aug 2026 07:00:12 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wz5kC-003Nmx-0a;
	Wed, 26 Aug 2026 07:00:12 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wz5kC-0000000GEoD-0Aoq;
	Wed, 26 Aug 2026 07:00:12 +0200
Date: Wed, 26 Aug 2026 07:00:12 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: sashiko-reviews@lists.linux.dev
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: j1939: cancel all pending ECUs on device stop
Message-ID: <ao5y3Mp5yotE1zOY@pengutronix.de>
References: <20260824155406.246942-1-dmantipov@yandex.ru>
 <20260824160844.4FBFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260824160844.4FBFF1F000E9@smtp.kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Dmitry,

On Mon, Aug 24, 2026 at 04:08:43PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] AB-BA deadlock between `priv->lock` and `hrtimer_cancel()` when stopping the device.
> - [High] Unconditional cancellation of all ECUs on any socket closure breaks address claiming for the entire CAN interface.

Can you please take a look to this issues.

> Pre-existing issues:
> - [Critical] Unlocked list deletion in `__j1939_ecu_release()` leads to list corruption.

No need to worry about pre-existing, except you wont to.

> --
> 
> --- Patch [1]: [PATCH] can: j1939: cancel all pending ECUs on device stop ---
> commit f80db37c4e58ab7d9daa72ce8c93a7552521ee48
> Author: Dmitry Antipov <dmantipov@yandex.ru>
> 
> can: j1939: cancel all pending ECUs on device stop
>     
> This patch modifies the device stop routine to cancel all pending ECU
> timers to prevent a situation where an ECU continues holding a reference
> to the private data structure after the device stops processing.
>     
> Reported-by: syzbot+489e907b2a026a6f5fa0@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=489e907b2a026a6f5fa0
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> 
> > diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> > --- a/net/can/j1939/bus.c
> > +++ b/net/can/j1939/bus.c
> > @@ -96,6 +96,16 @@ void j1939_ecu_unmap(struct j1939_ecu *ecu)
> >  	write_unlock_bh(&ecu->priv->lock);
> >  }
> >  
> > +void j1939_ecu_cancel_all(struct j1939_priv *priv)
> > +{
> > +	struct j1939_ecu *ecu, *tmp;
> > +
> > +	write_lock_bh(&priv->lock);
> > +	list_for_each_entry_safe(ecu, tmp, &priv->ecus, list)
> > +		j1939_ecu_timer_cancel(ecu);
> 
> [Severity: High]
> Could this introduce an AB-BA deadlock with the timer callback?
> 
> The loop holds the lock while cancelling the timer:
> 
> write_lock_bh(&priv->lock);
> list_for_each_entry_safe(ecu, tmp, &priv->ecus, list)
>         j1939_ecu_timer_cancel(ecu);
> 
> If j1939_ecu_timer_handler() is currently executing on another CPU, it
> will unconditionally attempt to acquire the exact same lock:
> 
> net/can/j1939/bus.c:j1939_ecu_timer_handler() {
>     ...
>     write_lock_bh(&priv->lock);
>     ...
> }
> 
> Would this cause hrtimer_cancel() to spin waiting for the callback to
> finish, while the callback waits for the lock held by this thread?
> 
> [Severity: Critical]
> This isn't a bug introduced by this patch, but iterating this list might
> expose a pre-existing list corruption issue.
> 
> When j1939_ecu_timer_cancel() drops the reference via j1939_ecu_put(), or
> when a temporary reference is dropped in j1939_ac_recv(), it can trigger
> the final release:
> 
> net/can/j1939/bus.c:__j1939_ecu_release() {
>     ...
>     list_del(&ecu->list);
>     ...
> }
> 
> The list_del() executes without holding priv->lock. If this happens
> concurrently while another thread is iterating priv->ecus (like the loop
> introduced here), could it corrupt the list and cause a use-after-free or
> kernel panic?
> 
> > +	write_unlock_bh(&priv->lock);
> > +}
> > +
> >  void j1939_ecu_unmap_all(struct j1939_priv *priv)
> 
> [ ... ]
> 
> > diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
> > --- a/net/can/j1939/main.c
> > +++ b/net/can/j1939/main.c
> > @@ -306,6 +306,7 @@ struct j1939_priv *j1939_netdev_start(struct net_device *ndev)
> >  
> >  void j1939_netdev_stop(struct j1939_priv *priv)
> >  {
> > +	j1939_ecu_cancel_all(priv);
> 
> [Severity: High]
> Does unconditionally cancelling all ECUs here break address claiming for
> the shared interface?
> 
> It appears j1939_netdev_stop() is called whenever any local user closes
> a J1939 socket, but the CAN interface itself might still be in use by
> other sockets. Calling j1939_ecu_cancel_all() before checking the shared
> rx_kref count could disrupt network management for those remaining users.
> 
> >  	kref_put_mutex(&priv->rx_kref, __j1939_rx_release, &j1939_netdev_lock);
> >  	j1939_priv_put(priv);
> >  }
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260824155406.246942-1-dmantipov@yandex.ru?part=1
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
