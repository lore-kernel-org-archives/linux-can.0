Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA230EF95;
	Mon,  3 Aug 2026 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785737902; cv=none; b=EnF+T38aY1EqyLHL49yGsnytXFqiYdkG7qYiDZjTiwj6JG+sxmiduDlp50fN3fUV5NvpXRPVmt98X7XuS8kaoBHC+7cC0oD/pyF28fdnYfWlgvkOmGs38+Oqac+0fk3NkX1gBm3JD4+Z968Dt22uoEOcqFnpgPs28vjNIRVY9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785737902; c=relaxed/simple;
	bh=dzrM7n778qw7znQknhNG1qeX3Oay+eQFuKXPntCG/qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OX8C8DqfLh10wNSHm9RM563zTZ4J976LuBfrflJf3fFPNpwrdB8Nc5/deEUEiJe2JK8kWE7icdaW3qvOaMXwtHy7IzzP+WEFCZgdB6/S1iLKfRMALE3FUrExjDUVJz9tcZWXD0zuAyqmUT+7FUFXMXjhWCt0A62eGE8MfgzA4jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0DB5320044D;
	Mon, 03 Aug 2026 08:18:11 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wqm02-002eFV-38;
	Mon, 03 Aug 2026 08:18:10 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wqm02-00000007isp-3duW;
	Mon, 03 Aug 2026 08:18:10 +0200
Date: Mon, 3 Aug 2026 08:18:10 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Felix Hoffmann <f3lix.dev@gmx.de>
Cc: linux-can@vger.kernel.org, Robin van der Gracht <robin@protonic.nl>,
	netdev@vger.kernel.org, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] can: j1939: avoid address-claim timer deadlock
Message-ID: <anAyok4pycHDiaLi@pengutronix.de>
References: <20260731134255.1002902-1-f3lix.dev@gmx.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260731134255.1002902-1-f3lix.dev@gmx.de>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Felix,

Please do not send CAN related patches to the netdev list, and please
use [PATCH can] tag instead.

On Fri, Jul 31, 2026 at 03:42:55PM +0200, Felix Hoffmann wrote:
> j1939_ac_process() holds priv->lock while synchronously canceling an
> ECU's address-claim hrtimer. The timer callback takes the same lock. If the
> callback starts on another CPU after the receive path takes the lock, the
> callback waits for priv->lock while hrtimer_cancel() waits for the callback
> to finish. This deadlocks both CPUs and makes the system unresponsive.
> 
> Do not wait for priv->lock from the soft hrtimer callback. If
> address-claim processing currently owns it, move the expiry forward by 1 ms
> and restart the timer. This lets a concurrent hrtimer_cancel() finish and
> remove the requeued timer. Without a cancellation, mapping is retried
> shortly.
> 
> Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT5.6-Sol
> Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
> ---
> 
> The deadlock was reproduced three times on a 2-vCPU kernel with KASAN
> and lockdep. Cross-CPU GDB stacks showed hrtimer_cancel() and the timer
> callback waiting on the same j1939_priv lock and hrtimer.
> 
> With this change, the reproducer completed 420 stress rounds, and the
> patched CAN J1939 syzkaller campaign remained operational. The trigger
> drops to UID and GID 65534 before opening its CAN sockets. A minimal
> reproducer and the complete stack capture are available privately on
> request.
> 
>  net/can/j1939/bus.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
> index cdc3c0a71937..ac654dc8872e 100644
> --- a/net/can/j1939/bus.c
> +++ b/net/can/j1939/bus.c
> @@ -131,7 +131,17 @@ static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
>  		container_of(hrtimer, struct j1939_ecu, ac_timer);
>  	struct j1939_priv *priv = ecu->priv;
>  
> -	write_lock_bh(&priv->lock);
> +	/*
> +	 * j1939_ac_process() cancels this timer while holding priv->lock.
> +	 * Don't block here, otherwise the timer and receive paths can deadlock
> +	 * waiting for each other on different CPUs. Retry shortly if address
> +	 * claim processing currently owns the lock.
> +	 */
> +	if (!write_trylock(&priv->lock)) {

write_trylock() will not take a lock even if read lock is taken on the
receive path. Means, this operation will be delayed not only by the rare
address claim frames, but also by any frame on the bus.

Since, the problem is real, and this fix is good enough for stable, i'm
ok with it + some nit picks.

Update the comment and commit message to something like this:
        /* j1939_ac_process() cancels this timer while holding priv->lock.
         * Don't block here, otherwise the timer and receive paths can
         * deadlock waiting for each other on different CPUs. Retry shortly
         * if the lock is held, by the address claim writer or by a reader
         * on the receive path.
         */

> +		hrtimer_forward_now(hrtimer, ms_to_ktime(1));

Please add a define for 1 ms retry. No magic numbers.

If the bus load will really hit us so strong that we will retry for
too long, it will be good to have some rate limited warning after ~5
retries. Also comment on that 5 retires is not spec related, it is more
"seems to be reasonable" number.

> +		return HRTIMER_RESTART;
> +	}
> +
>  	/* TODO: can we test if ecu->addr is unicast before starting
>  	 * the timer?
>  	 */
> @@ -141,7 +151,7 @@ static enum hrtimer_restart j1939_ecu_timer_handler(struct hrtimer *hrtimer)
>  	 * j1939_ecu_timer_start().
>  	 */
>  	j1939_ecu_put(ecu);
> -	write_unlock_bh(&priv->lock);
> +	write_unlock(&priv->lock);

Please explain in the commit message, why changing write_*_bh() to write_*()
is a safe option.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
