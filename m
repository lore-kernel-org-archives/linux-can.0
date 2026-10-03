Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109F1A9FB7
	for <linux-can@vger.kernel.org>; Sat,  3 Oct 2026 05:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791006519; cv=none; b=GT96RpMElKYaxAOfwi6tX/Evf82LN2QKoPOk0tewwy2mL2DfflLkWOlFjZMxiY/dJ3AMIYicVrvwmeRZJC2z3KMocljNRPqAoCCJJoXD/3Nt/GAXROBT53Jd4l9oU46LZWAARikKrBT1rojrF3AGoS7HiS2TCEaG12UrULtrAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791006519; c=relaxed/simple;
	bh=BAsrtAiRRPpoVcJSPL0GVeHQ4CivtiLbGJ9cGqZKTo8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uHqnsVHdL9k4sp/EnBMHZSJZ05hF7vC/l3elk4znUqatpDyJ+lTZbTSRJ/n79ruAXiMj9wClxcN0JKY1j14lFt/2Q0gbW/C4Oy8wBfpTlqT0YKfDfVGTFoZqQSNWlmgHvyG6yV4lHj+TspGJLpKYKhTIV/nKOnCzBHsBJE7l0Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdU1+BZ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdU1+BZ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1703B1F0089D;
	Sat,  3 Oct 2026 05:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791006517;
	bh=Q8qT2eyiFzZWTvLt1Uw1zu0VERIXq+4dSS+CR9Oen1o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cdU1+BZ7VMR0N8iQwtYXTE2SVVF+hKeak8BMaCMjdRugPqc4C98MK1cPGTendrpZV
	 EUrTcDsQdTdjEd/2zw6tKH6n3Np7Q4Hv0yr84m1vfDMXITQoahjNKJcbNyNcr56IOU
	 +Md1mJv+LZXwRHuDklnCMp5g4XymS5H85KZIUJ9o6pF0T0RseCSmYbAS0TlZnk2sE4
	 UzgxE/0WqLynskjk1MquZ9sev1PpA7J4FeNFTKmOHhIXnZTsY92rtUJNXxH7nHv4iu
	 TWLp4Hw4BoPILw7NOnciZCilzl8AU+nZpoLF9fl1Eoe88BmCZycJ+qeNrU/9UtwI7J
	 ROkTT/c34+0MQ==
Subject:
 Re: [PATCH v5 3/3] can: fix unique skb identifier regression under RPS
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, stable@kernel.org, o.rempel@pengutronix.de,
 kuba@kernel.org
Date: Sat, 03 Oct 2026 05:48:36 +0000
Message-ID: <179100651661.1406898.2220274776875042114@kernel.org>
In-Reply-To: <20260929163424.16382-4-socketcan@hartkopp.net>
References: <20260929163424.16382-4-socketcan@hartkopp.net>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message says that frames sharing an extension with
  another clone (tc mirred, netem duplicate) get a private copy before…

--

can: fix unique skb identifier regression under RPS

This commit moves the CAN per-skb unique identifier that raw_rcv() uses
for duplicate detection out of skb->hash and into a new can_skb_uid field
in struct can_skb_ext. The receive handlers now give a shared extension a
private copy before they assign the UID, and can-gw and vxcan clear the
UID on forwarded frames.

Closes: https://lore.kernel.org/linux-can/2859AD3D-C805-41A0-9036-C5E8EE152419@clnt.de/

> diff --git a/net/can/af_can.c b/net/can/af_can.c
> index ef435f22ac933..dc27ace43719d 100644
> --- a/net/can/af_can.c
> +++ b/net/can/af_can.c
> @@ -641,13 +641,10 @@ static int can_rcv_filter(struct can_dev_rcv_lists *dev_rcv_lists, struct sk_buf
>  	return matches;
>  }
>  
> -void can_set_skb_uid(struct sk_buff *skb)
> +void can_set_skb_uid(struct can_skb_ext *csx)
>  {
> -	/* create non-zero unique skb identifier together with *skb */
> -	while (!(skb->hash))
> -		skb->hash = atomic_inc_return(&skbcounter);
> -
> -	skb->sw_hash = 1;
> +	while (!(csx->can_skb_uid))
> +		csx->can_skb_uid = atomic_inc_return(&skbcounter);
>  }
>  EXPORT_SYMBOL(can_set_skb_uid);

[ ... ]

> @@ -696,6 +692,14 @@ static int can_rcv(struct sk_buff *skb, struct net_device *dev,
>  		return NET_RX_DROP;
>  	}
>  
> +	/* create unshared CAN skb_extension for netem/mirred skb clones */
> +	csx = skb_ext_add(skb, SKB_EXT_CAN);
> +	if (unlikely(!csx)) {
> +		kfree_skb_reason(skb, SKB_DROP_REASON_NOMEM);
> +		return NET_RX_DROP;
> +	}
> +
> +	can_set_skb_uid(csx);

[Severity: Medium]
Do independently received clones get different UIDs if the UID was already
set before the clone was made? The same question applies to canfd_rcv()
and canxl_rcv().

The commit message says:

  Frames whose extension is still shared with another clone (e.g. via
  tc mirred or netem duplicate) are given a private extension copy
  before the UID is assigned, so that independently received clones
  never end up with the same UID.

skb_ext_add() copies the shared extension through skb_ext_maybe_cow(),
which is a memcpy(). Any non-zero can_skb_uid that is already set ends up
in the private copy. can_set_skb_uid() then keeps that value, because it
only assigns a UID when the value is 0.

isotp sets a non-zero UID before transmission, in both isotp_sendmsg()
and isotp_send_cframe():

	/* set uid in tx skb to identify CF echo frames */
	can_set_skb_uid(csx);
	...
	can_send(skb, 1);

Suppose that TX skb is duplicated on egress. netem_enqueue() calls
skb2 = skb_clone(skb, GFP_ATOMIC) for duplicates, and mirred egress
mirroring also clones. Every copy then has the same UID X. Could the
following happen on an IFF_ECHO device such as vcan with echo=1?

vcan_tx(skb)
  can_create_echo_skb()
    nskb = skb_clone(skb)        /* echo e1, UID X */
    consume_skb(skb)
netif_rx(e1)
  can_rcv(e1)
    raw_rcv()                    /* per-cpu uniq = {e1, X} */
    can_receive()
      consume_skb(e1)            /* e1 slab slot freed */

netem watchdog dequeues skb2
vcan_tx(skb2)
  can_create_echo_skb()
    nskb = skb_clone(skb2)       /* e2 reuses e1's slot, UID X */
netif_rx(e2)
  can_rcv(e2)
    raw_rcv()

The check in raw_rcv() would then match:

	if (this_cpu_ptr(ro->uniq)->skb == oskb &&
	    this_cpu_ptr(ro->uniq)->can_skb_uid == csx->can_skb_uid) {
		if (!ro->join_filters)
			return;

The duplicated frame would be silently dropped for every raw socket that
already received e1. With join_filters set, join_rx_count would be
counted too high instead.

This is the same false duplicate drop that the patch fixes for skb->hash.
Here it is limited to frames with a UID set before transmission. The old
skb->hash scheme behaved the same way in this case, because skb_clone()
copies the hash. can-gw and vxcan clear the UID explicitly, but generic
clone paths such as netem and mirred do not.

Clearing the UID whenever the extension is shared would not fix this
either. For devices without IFF_ECHO, can_send() does the loopback with
newskb = skb_clone(skb) while the original skb is still alive. isotp echo
matching depends on that clone keeping the UID.

Should the commit message be toned down for this case, or is there
another way to tell these clones apart?

>  	can_receive(skb, dev);
>  	return NET_RX_SUCCESS;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929163424.16382-1-socketcan%40hartkopp.net
