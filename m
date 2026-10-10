Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360E381AF4;
	Sat, 10 Oct 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640974; cv=none; b=sOT5UPP+aANEyrfgel8bTd7LhHv/ekWddYyhA0eZkDJXy5SdV/kggMMoKF82YaTDEReermMOqqw+ktMAQr8wdBkxk1K5i2vrkw/RESKyyqfyzwzypWftZIRV92mLzlxT+2lZHqhDgWj798PQ2ca4+xE/lzeP2WYaln8EhSMDolQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640974; c=relaxed/simple;
	bh=hsVeYh3gb5HrH0c+Vo644V4VaqnCUpwUMbLNtHO5smI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SwQKft6bHn7ta7s3pwhwe7NJnQoPSZG+u3HGVFAkd54AhB9ZB3ACSiMoO7FdwIlOvpQdtqn0UMzqYmXjXWAjLVgvbLnpcBWkIuGVRZm8qVOJFfh79QYz31ZySd1S3EAYDsW+c+b6qx9X5aGeBxwwrxMAt5JRcPvtKmuxpI9jTJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4VTqWJb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4VTqWJb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 427CB1F00898;
	Sat, 10 Oct 2026 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640972;
	bh=NJdA1akvPw3elh6MPd7UUehuKt2sZx7s57pv+zDWAfM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K4VTqWJb/rObiqRENU4fIaPoILerj30oYEmSEIJKgGL8dGd5BORp33y2LZDk7DZ7w
	 eXO6pVT2pG5qOGtGMGadpCxphfTFZXT/jQ+X775DCPTERXuXKuP6CtzT6oJlaNwc0y
	 ni81TwM9GHqhDssrN0V1NwCt7h0oLZyZgNfJ6mYuQmAyrhb56To8gwBNjfujd8KXXd
	 s2iJudBSXIpT3reBSz/iVvSqKULNTTSyPzL83t6B3AzgU4Y2JkP/JmmB6wHb6zaKMM
	 F6oChwCgSalBkggkcgFZNA6EYvrXwMmU2C1IqpdjrWOx5s9r6Whm2QyGm2m1/JMPg1
	 dBo1fcMG3bA0g==
Subject: Re: [PATCH net-next 10/37] can: skb: make echo skb freeing safe in
 any IRQ context
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:02:51 +0000
Message-ID: <179164097179.434549.93216443064751210@kernel.org>
In-Reply-To: <20261009134323.64064-11-mkl@pengutronix.de>
References: <20261009134323.64064-11-mkl@pengutronix.de>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Commit "can: skb: make echo skb freeing safe in any IRQ context"
  fixes a bug that is real and long-standing, but its message has no…

--

can: skb: make echo skb freeing safe in any IRQ context

This commit changes the kfree_skb() and consume_skb() calls in
can_put_echo_skb(), can_create_echo_skb(), can_dropped_invalid_skb() and
can_dev_dropped_skb() to dev_kfree_skb_any() and dev_consume_skb_any().
With this change, these paths are safe when the caller has hardware
interrupts disabled.

Link: https://patch.msgid.link/tencent_E84809CF236D0137885E7E4E4D58340B3208@qq.com

> can_put_echo_skb() can be called with hardware interrupts disabled. Its
> direct drop paths use kfree_skb(), while can_create_echo_skb() uses
> kfree_skb() when cloning fails and consume_skb() after a successful clone.
> None of these helpers is safe in every IRQ context.

[Severity: Low]
The code change looks fine, but should the commit message have a Fixes:
tag and Cc: stable?

The premise is correct. For example, janz-ican3 reaches
can_create_echo_skb() with hard IRQs disabled:

drivers/net/can/janz-ican3.c:ican3_xmit()
    spin_lock_irqsave(&mod->lock, flags);
    ...
    ican3_put_echo_skb(mod, skb);
        can_create_echo_skb(skb);
            consume_skb(skb);  /* or kfree_skb() if skb_clone() fails */

Before this patch, that consume_skb() ran the skb destructor (normally
sock_wfree()) from skb_release_head_state() with IRQs off.
dev_consume_skb_any() and dev_kfree_skb_any() exist to avoid exactly that.

The old code is also in stable trees. Could the message name an affected
caller such as ican3_xmit(), and the commit that introduced the problem?

The companion patch in this series, "can: skb: make CAN skb allocation
failure paths IRQ-safe", does have a Fixes: tag.

> [mkl: also convert can_dropped_invalid_skb(), can_dev_dropped_skb()]

Could the message also say which IRQ-disabled context reaches
can_dropped_invalid_skb() and can_dev_dropped_skb()? Right now the reason
for converting these two helpers isn't given.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
