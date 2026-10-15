Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AF447ECF0
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792049659; cv=none; b=fP8EwvQsX8TdbRtbl+zNG992/H+n/3k/e5SY7ouaGb1f5OoX+Kt5PB0iP+VXoxQYQl63vSy/zotSWK8LEhJyUKhY0qZJ7+oAV7zZaDzNc/A6tsuC+vHGGUlgFHynB3YT0APTeu70DIrDacgdQIxTX/yX//b5x5Ekc2jd5Jcf6/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792049659; c=relaxed/simple;
	bh=FEvQO/bL/k52Uu6CbAtqup/v/s7pupQZtRacxPdwECw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZEMDGAb3GBWfDOjE06/DzanIlkBWdWw0aUJKFsCJmic7dLYBrgJSV9pxfxJZjjAXwoL/m/iGO5XHWHyg289imFZZs7DSbvov9zI2M46b+4BGEGSK8xGsN57JvzMJHWY46CgiG7fCqC8ggROK5cZES7pt13jNw9LzbLIR94Or2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPMtAn0Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPMtAn0Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7CF1F000C4;
	Thu, 15 Oct 2026 07:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792049654;
	bh=PrMKxCHyVvI7s61LpOSgQUkBGLhYqrSqs+AHJzCRxKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VPMtAn0ZCUTgy/uJNKFXe3E52cZZB0yLkstJHa3xPnkpZ61Q95/eH1B3F4YkY2Awv
	 6i/nQzwkZrkyZVbhxNuMDbJrMI/ZUR+mQZ8j3b8FhGqzjQH3oZ2OOwtOR91yIA09dO
	 8eLuwz+PXQQgvsnbiuMFTiM10LcNa3q3X+i4jnYats2Qwe9z0i0LkldirXkS0lc+UD
	 D0SCXpP+vOPeaxdH3vVBGBhtktt06Dl1171v5u4DQ7B8jM7MIWD6Ui8OHOFftvxUE8
	 o8IjzzTnJHTFQsF0/uMVCe9IW2Q/x0w1M2lBdgWUjyIU3oMSYaWqo9gX1umCrMIPR4
	 SSckhNCPy/Tzw==
Date: Thu, 15 Oct 2026 08:34:10 +0100
From: Lee Jones <lee@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
Message-ID: <20261015073410.GD1182143@google.com>
References: <20260519113806.85456-1-socketcan@hartkopp.net>
 <20261014-hilarious-bold-jellyfish-f47b11-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-hilarious-bold-jellyfish-f47b11-mkl@pengutronix.de>

On Thu, 15 Oct 2026, Marc Kleine-Budde wrote:

> On 19.05.2026 13:38:05, Oliver Hartkopp wrote:
> > From: Lee Jones <lee@kernel.org>
> >
> > Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > synchronize_rcu()") removed the synchronize_rcu() call from
> > bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> > timers from being rearmed during deletion.  However, it only applied
> > this check to op->timer via bcm_rx_starttimer().
> >
> > It missed the fact that op->thrtimer can also be rearmed by an
> > in-flight bcm_rx_handler() (which runs as an RCU reader) via
> > bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
> > bcm_remove_op() has already cancelled it, leading to a use-after-free
> > when the timer fires on the deferred-freed struct bcm_op.
> >
> > Address the omission by checking the RX_NO_AUTOTIMER flag
> > in bcm_rx_update_and_send() before starting op->thrtimer, effectively
> > preventing it from being rearmed concurrently with teardown.
> >
> > [Hartkopp] Added the setting of RX_NO_AUTOTIMER also to bcm_release() before
> > removing the CAN filters following the bcm_delete_rx_op() approach.
> >
> > Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
> > the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
> > potential code reordering of RX_NO_AUTOTIMER setting after CAN filter removal.
> >
> > Signed-off-by: Lee Jones <lee@kernel.org>
> > Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly synchronize_rcu()")
> > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> 
> This patch is obsolete, right?

No, I don't think so.  I thought it was applied to the maintainer tree?

-- 
Lee Jones
