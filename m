Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E1F509EE5
	for <linux-can@vger.kernel.org>; Thu, 15 Oct 2026 09:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057539; cv=none; b=o8a+XvQKycn7oTsNcY4ZvU7YBfT/Zz1KqPOg5E2ZWDDBKWez9oxYYEipjh5eyX5k7B81DpSxTcHrY16ZEtDP6u1aF0DBoK2sHGod5ux/CcgOFNHLI9i5qIqAOPlEL8v1bHrfj+mgWFGubKObG1pFtAOPalCWq2Q9PTG83wsKh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057539; c=relaxed/simple;
	bh=OOl0Mvkt5OeMhFpkcHIb5voWh6x9N1yPHqh21SDs5W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN8CsS7L/sh7GaPYyHFaWH6Okd8fZ39D4CGHcQ88M1lkMNGwzNTtPSttahho8rox8e2prT17VxYCFw3QylRt3B9QxS5MFnOZPIMPd8bGdBBgVfWMV6xJfc/sy2inGe4hENSVMNgDIWQXTEIHe3tU/W9hLMizDHNwA55UbmfI9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqWW0SLD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqWW0SLD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337C91F000C4;
	Thu, 15 Oct 2026 09:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057538;
	bh=7wciB/J7tOQSNukcdmM9rwqI41i4aIigkAD6y0pX2H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CqWW0SLDhXDo3df9ah6mGG9IzWp7nQNmxJQbiUxfjOZbRLgtcu1KrWcOPocBACmcx
	 Tu6+SO6fmwJCZcEPCrfqMTdsMmFeH21ah0e7nF8eNzmJtlqgp/k5pb0Rf4opjNtYtN
	 8NcCuaBlOFlfVq7h+0vhGlYt9qA1gTzfgdmEUAV1esx70aSILetIRghpeEEu8g96iV
	 tD8O61scowxSk65snt36Dn1eEtKH9cZ4wPwmCg9MxtW4VVZJ/0R6vzUAGprnglB8Ke
	 WeX22pC5jhnjEAYLbotFqOxBdOH2BLXAr278syr8xIc2m25yd1Tk5QHZcSsInVtqKg
	 2BPGprXGHJepg==
Date: Thu, 15 Oct 2026 10:45:34 +0100
From: Lee Jones <lee@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
Message-ID: <20261015094534.GE1182143@google.com>
References: <20260519113806.85456-1-socketcan@hartkopp.net>
 <20261014-hilarious-bold-jellyfish-f47b11-mkl@pengutronix.de>
 <20261015073410.GD1182143@google.com>
 <310d797e-00d8-4737-a308-1aecbeac4c75@hartkopp.net>
 <c03a99d4-5ae1-415c-9f3d-de6855755f93@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c03a99d4-5ae1-415c-9f3d-de6855755f93@hartkopp.net>

On Thu, 15 Oct 2026, Oliver Hartkopp wrote:

> Answering myself:
> 
> This patch from Lee with READ_ONCE() and WRITE_ONCE() had been completely
> reworked to use a workqueue:
> 
> "can: bcm: defer rx_op deallocation to workqueue to fix thrtimer UAF"
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68973f9db76144825e4f35dfdc80fb8279eb2d57
> 
> which is also from Lee and upstream as said.
> 
> So THIS patch here is obsolete.

Thanks for the clarifications Oliver.

> p.s. And the READ_ONCE() and WRITE_ONCE() in this patch also became
> obsolete. It would have no effect for race conditions only for KCSAN
> annotations - which we do not have. So we are completely done.
> 
> 
> On 15.10.26 10:03, Oliver Hartkopp wrote:
> > 
> > 
> > On 15.10.26 09:34, Lee Jones wrote:
> > > On Thu, 15 Oct 2026, Marc Kleine-Budde wrote:
> > > 
> > > > On 19.05.2026 13:38:05, Oliver Hartkopp wrote:
> > > > > From: Lee Jones <lee@kernel.org>
> > > > > 
> > > > > Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > > > > synchronize_rcu()") removed the synchronize_rcu() call from
> > > > > bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> > > > > timers from being rearmed during deletion.  However, it only applied
> > > > > this check to op->timer via bcm_rx_starttimer().
> > > > > 
> > > > > It missed the fact that op->thrtimer can also be rearmed by an
> > > > > in-flight bcm_rx_handler() (which runs as an RCU reader) via
> > > > > bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
> > > > > bcm_remove_op() has already cancelled it, leading to a use-after-free
> > > > > when the timer fires on the deferred-freed struct bcm_op.
> > > > > 
> > > > > Address the omission by checking the RX_NO_AUTOTIMER flag
> > > > > in bcm_rx_update_and_send() before starting op->thrtimer, effectively
> > > > > preventing it from being rearmed concurrently with teardown.
> > > > > 
> > > > > [Hartkopp] Added the setting of RX_NO_AUTOTIMER also to
> > > > > bcm_release() before
> > > > > removing the CAN filters following the bcm_delete_rx_op() approach.
> > > > > 
> > > > > Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
> > > > > the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
> > > > > potential code reordering of RX_NO_AUTOTIMER setting after
> > > > > CAN filter removal.
> > > > > 
> > > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > > Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > > > > Fixes: f1b4e32aca08 ("can: bcm: use call_rcu() instead of
> > > > > costly synchronize_rcu()")
> > > > > Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > > > 
> > > > This patch is obsolete, right?
> > > 
> > > No, I don't think so.  I thought it was applied to the maintainer tree?
> > > 
> > 
> > I think it became obsolete through all the recent (and stable) changes
> > that addressed multiple races. The UAF problem is solved today.
> > 
> > Btw. the use of READ_ONCE() and WRITE_ONCE() can be seen as some
> > addditional hardening but the entire patch does not fit to the current
> > bcm.c code.
> > 
> > The READ_ONCE() and WRITE_ONCE() may be added for the 7.5 net-next
> > window cycle. No pressure here.
> > 
> > Best regards,
> > Oliver
> > 
> > 
> 

-- 
Lee Jones
