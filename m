Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B5B3E277C
	for <linux-can@vger.kernel.org>; Wed, 20 May 2026 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284438; cv=none; b=DnvOIxVn+zX+Ayl/plYHxLXfb45KxGwfDCD0Le6kg1TxZtFeFOY0AB0/bagDIu+ih2znSE5FBhmk9tyJCM16mVgWkUTJQtHsN05UO49QzRLhpfNJYNCSJyN1hfSViwtibIfjhlO0ONEtBnu6jU9YV1KxWJywHh71aWfHefsDl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284438; c=relaxed/simple;
	bh=1imjxTPxq+v5T+epeSfsXS/6rfYBKouwYYMDI0zP+mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kVDbZxFHoXYE6RY0FUzrok5gDiZSpdpKmg2FwcQxJyKog+z9E694QB/Nu5GoBy8eNYdD/knoLZ59j89CpvUIlCkt5G2zwOBtVRW6DO7A/11TUvcy9xDW9EndeFb3Cs+jBeDYTZtRlYU8UMYS1Rm7mcUm1b64/eGncUL48gq7KMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyHFskCR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyHFskCR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06961F000E9;
	Wed, 20 May 2026 13:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779284436;
	bh=KIZc3yfEeN3W1oG3PY+vpU/ImmJDTO97cF6g14O44M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QyHFskCRLLrDHu1JXh6O/paAcVnXKo+Smpz8aU88EMvX/Ruc3Alfr17RK1GASWCnY
	 e0VWimQ+M6e0ZDGXg9K47CSeiYaacolKJGyLSiZ3OwnisBnKOT09MwljFtbVn/JJ9X
	 2K6m4KcSlIAZMAqnQIp6SYfv0/2Ww/yu98S/qdEi7/fQMX4jk+u/3uaKwuJVXhYLwQ
	 WCKo3C4fYbW4Dxh4dhOUi9vEyW0pPjb2gq4L4yS0PEQULTynnFPT+ejrerhbIzBeml
	 rxhET4K6jrE+gict2zjjlxmDNzz/AVZnDzJ4uuw5MK2Aup/L+VhZE1gjXvBBwGJ4oP
	 L7l5HAp/1Dskg==
Date: Wed, 20 May 2026 14:40:32 +0100
From: Lee Jones <lee@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org
Subject: Re: [PATCH v2] can: bcm: prevent thrtimer UAF in rx path by checking
 RX_NO_AUTOTIMER
Message-ID: <20260520134032.GA2767592@google.com>
References: <20260519113806.85456-1-socketcan@hartkopp.net>
 <20260520124758.GA305027@google.com>
 <20260520124907.GB305027@google.com>
 <442a92c9-5810-4fcd-ab05-5b0acd0f345c@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442a92c9-5810-4fcd-ab05-5b0acd0f345c@hartkopp.net>

On Wed, 20 May 2026, Oliver Hartkopp wrote:

> 
> 
> On 20.05.26 14:49, Lee Jones wrote:
> > On Wed, 20 May 2026, Lee Jones wrote:
> > 
> > > On Tue, 19 May 2026, Oliver Hartkopp wrote:
> > > 
> > > > From: Lee Jones <lee@kernel.org>
> > > > 
> > > > Commit f1b4e32aca08 ("can: bcm: use call_rcu() instead of costly
> > > > synchronize_rcu()") removed the synchronize_rcu() call from
> > > > bcm_delete_rx_op() and introduced the RX_NO_AUTOTIMER flag to prevent
> > > > timers from being rearmed during deletion.  However, it only applied
> > > > this check to op->timer via bcm_rx_starttimer().
> > > > 
> > > > It missed the fact that op->thrtimer can also be rearmed by an
> > > > in-flight bcm_rx_handler() (which runs as an RCU reader) via
> > > > bcm_rx_update_and_send().  This allows op->thrtimer to be queued after
> > > > bcm_remove_op() has already cancelled it, leading to a use-after-free
> > > > when the timer fires on the deferred-freed struct bcm_op.
> > > > 
> > > > Address the omission by checking the RX_NO_AUTOTIMER flag
> > > > in bcm_rx_update_and_send() before starting op->thrtimer, effectively
> > > > preventing it from being rearmed concurrently with teardown.
> > > > 
> > > > [Hartkopp] Added the setting of RX_NO_AUTOTIMER also to bcm_release() before
> > > > removing the CAN filters following the bcm_delete_rx_op() approach.
> > > > 
> > > > Additionally WRITE_ONCE()/READ_ONCE() macros have been introduced for
> > > > the changes of RX_NO_AUTOTIMER at rx op removal time to prevent a
> > > > potential code reordering of RX_NO_AUTOTIMER setting after CAN filter removal.
> > > > 
> > > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > > Co-developed-by: Oliver Hartkopp <socketcan@hartkopp.net>
> > > 
> > > You did?  Can you add a note saying what you changed please?
> > 
> > FYI, did you also see the second swing I took at this:
> > 
> > https://lore.kernel.org/r/20260520080523.2513957-1-lee@kernel.org
> 
> Yes, and I answered to your patch.
> 
> Is there some lag in the e-mail communication right now?
> 
> That's why I also wondered why you sent a patch one day after my v2
> proposal.

Right.  I only saw your proposal today.

I've been working the alternative since Jakub NACKed the first submission.

-- 
Lee Jones
