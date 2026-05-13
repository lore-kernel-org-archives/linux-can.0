Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3128C009;
	Wed, 13 May 2026 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680758; cv=none; b=Xk/l68sWaHtEZFzWhgVcfvMqJtfEyyt/H2PBgDHbMluFyGjA5JKx/0sGIH1dtQxqWpMuquIIBZi5Zw+9tz3VDBKT7JjUD06Ss7zJrxFjtwqSeLdo+QQI+P1JLI8ZlMT2karNtsbBGzewKLHyvhrbrdePb7KdS08z0A/tArBaLcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680758; c=relaxed/simple;
	bh=VVfsn0ts3DNQGY513zh5bpdUknKzKyhIkCScbG4liAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Psu1jxqhI7iR4ZwmqsUR6nLwKPpSv1wJOzgnoKAZ7y61E+R7f9H2n7ZxWeZz+o3JnbJzPypEYfeQj+Gu5Ivs/k32V4Tm91+psVmv4uQIlwQGStzqQ/fGyR4xEbXc77sPqbrITjOX487yDUTaFoWIIt9iCEPu57VRUTGqx51gtXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDcr57zi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDcr57zi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59CC8C19425;
	Wed, 13 May 2026 13:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778680757;
	bh=VVfsn0ts3DNQGY513zh5bpdUknKzKyhIkCScbG4liAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDcr57zi1SAofzL0nLwmvXSJm/0HQrNciAXCfvVaeN/gw5gIPftdX68kwLhuusuEM
	 VarKo46K0EPTVyth47KRmsuOrQaEeCJCth2+XQ+TrcPBOTzs0CBCZvD4g00Mn7DY1s
	 Uf5yJG6tYJwL+EPOXVxYCJD+qpWtrKa/YBI4n+gJuHWnR/1cAXLwJcTD2C3hbKLezC
	 sOoeHp++vOwRgleM3cTdFfT4keYwAtSffRztZtcmZ1khTW0NserWFgs4q+7PW94zWW
	 m0PeOTwSPRO7n/VcpIsoS3xcGlXm9ME7/FWFQIUmav7jXT3yxRbQ91KpXOSXhwMshd
	 TvRDcEab449lg==
Date: Wed, 13 May 2026 14:59:13 +0100
From: Lee Jones <lee@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org,
	davem@davemloft.net, linux-can@vger.kernel.org,
	kernel@pengutronix.de, Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH net 2/6] can: bcm: prevent thrtimer UAF in rx path by
 checking RX_NO_AUTOTIMER
Message-ID: <20260513135913.GA305027@google.com>
References: <20260507112321.439968-1-mkl@pengutronix.de>
 <20260507112321.439968-3-mkl@pengutronix.de>
 <20260508151237.7d0a9105@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508151237.7d0a9105@kernel.org>

On Fri, 08 May 2026, Jakub Kicinski wrote:

> On Thu,  7 May 2026 10:22:24 +0200 Marc Kleine-Budde wrote:
> > Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > synchronize_rcu()") removed the synchronize_rcu() call from
> > bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> > timers from being rearmed during deletion.  However, it only applied
> > this check to op->timer via bcm_rx_starttimer().
> 
> All AIs point out this is insufficient:
> 
>     reader (bcm_rx_handler, RCU) | writer (bcm_delete_rx_op)
>     -----------------------------+-------------------------------
>     test op->flags (no AUTOTIMER)|
>                                  | op->flags |= RX_NO_AUTOTIMER
>                                  | bcm_remove_op()
>                                  |   hrtimer_cancel(&op->thrtimer)
>                                  |     /* not armed: no-op */
>                                  | call_rcu(bcm_free_op_rcu)
>     hrtimer_start(&op->thrtimer) |
>     return from RCU section      |
>                                  | grace period elapses
>                                  | bcm_free_op_rcu() -> kfree(op)
>     thrtimer fires               |
>       bcm_rx_thr_handler(op)     | <-- UAF

Noted.  Leave it with me and I'll follow up shortly.

-- 
Lee Jones
