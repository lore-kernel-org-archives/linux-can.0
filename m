Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861218;
	b=lfYFJR2w59pYyYbHOwuOq+vRL1CkP1PDsudLUG3oS+PyxGD9fOmnCmlgLwORaYV8EJQ7
	 2W6LxolyocdWS+anjQn5y0K1fWwBLJfY+6DXh1MhUkjoygv0rpVAWSD+3Yg4E/+tPN46m
	 uXflqpvZRmSplIq1Fo7SDadVf3DZpSDcWUWp8FQPvZn9bUVhFtrS/Bi8kliy27Fa215C3
	 0MFQ5egqMtYQsV/fjX9EiOvCmXS8SPwbKLsm3f8u7WQt+q9VKmdwk3HuHlnlPl5lzaiAI
	 sNnga9xwkitx8Nghrmo6aDrKacUY0dCui8CWMcg4KfcdT9m5l5OASsfSDao0137BHTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861218;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=e7B1U5F7w/67JdR8I4KeCJzbft3G8djvpAGFs0o63LM=;
	b=pv75XfAA8aXYd9vex8i8qXOJ2WSy8i6C4nXPrvEry37bQJ5qFWIe3DzEBaN4VB/FplFP
	 vhL04b4k6MgfUk3iU5B1bspREhztvdUQ4lYVWgXHzaVQxSbOcwVB8tLJ2J1v6BCWExMJ0
	 7FZUc1CefQyxhq7Ze97Mvy5puInMm1SJl2lw3ly9pmxs996E9c/mox3HJh59D/u39yLAn
	 Mbsd2gQmb6aP5XuFY3cX95CZ3BFMhnRjHlSZ5WwspH0ZQmOuis+IPLkKZp3FgWJS3ibW9
	 xsXJpDC7yf6gbAEM8GiTlsOjpUOBeqK24MYLVCL2BQf/5zDGCcwCmfIC8GTL5S6ka+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFgt9y78;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF55606A324
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 10:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CFgt9y78
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0F61F000C1;
	Sat, 28 Nov 2026 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861217;
	bh=e7B1U5F7w/67JdR8I4KeCJzbft3G8djvpAGFs0o63LM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CFgt9y78mc0pfhdUMwklPOaFHsFZv/EhzagE1yopFQZ0dFwqb2cidspaJe0diNEbS
	 BEjHC6i4cCKlijMaySF7hAJUxIwF5xqohtWsYGU6nkevx9CxzhZlcn+3eLcwQtE96J
	 py272ShDeq7bV4qTB9yHA7BTfua3mmDFxaUxk4WchOzvDqRt8xlxCzYSZcq+pGmCAn
	 6R8aUoZ5GQhvSHzvByAGKa8xKFL7qL1zlQ21p5TBoTAfarcNdO802EpY++I5ZCOLY1
	 T1OeXzCKClbaHbWmBunudkKcvhpxb3vkKx/4EtfgdtLX3V3HoKRoRAOrdPFksUJuTF
	 tlz8VtgM+JZ2w==
Subject: Re: [PATCH can-next 06/22] can: isotp: check the CAN FD tx_flags in
 CAN_ISOTP_LL_OPTS
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sashiko-bot@kernel.org,
 zihanx@nebusec.ai, o.rempel@pengutronix.de, yewentian395@gmail.com,
 kuba@kernel.org
Date: Sat, 28 Nov 2026 10:20:16 +0000
Message-ID: <179586121665.3131.3927877862728730062@kernel.org>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-6-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-6-681ef8d8c2c9@hartkopp.net>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch narrows the accepted CAN FD tx_flags values in
  isotp_setsockopt_locked() (net/can/isotp.c:1803-1806) to…
- [Low] The commit message describes the old behaviour as a defect ("any
  value was accepted, so that CANFD_ESI and undefined flags were sent in…

--

can: isotp: check the CAN FD tx_flags in CAN_ISOTP_LL_OPTS

This commit restricts the tx_flags accepted by setsockopt(CAN_ISOTP_LL_OPTS)
for CAN FD sockets to CANFD_BRS and CANFD_FDF. Any other bit, including
CANFD_ESI, is now rejected with -EINVAL. Previously any value was accepted
and copied into the flags of the generated CAN FD frames.

> The tx_flags of struct can_isotp_ll_options are set into the flags of
> the created CAN FD frames. For CAN CC they have to be zero but for CAN
> FD any value was accepted, so that CANFD_ESI and undefined flags were
> sent in the CAN FD frames.

[Severity: Low]
This wording presents the old behaviour as a defect, but there is no
Fixes: tag. The unchecked CAN FD path in isotp_setsockopt_locked() dates
back to e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol").

A Fixes: tag is probably not the right answer here, though. It would invite
stable backports of a change that rejects setsockopt() input that used to
be valid. Drivers such as mcp251xfd (ESIGM) and vcan also honour CANFD_ESI
when userspace requests it.

Could the commit message state clearly whether this is a bug fix or an
intentional tightening of the uAPI?

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 197dc7bdb6ec0..6ec7b10d7136d 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1800,6 +1800,11 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
>  		    (ll->tx_dl > CAN_MAX_DLEN || ll->tx_flags != 0))
>  			return -EINVAL;
>  
> +		/* only CANFD_BRS (and the CANFD_FDF marker) for CAN FD frames */
> +		if (ll->mtu == CANFD_MTU &&
> +		    (ll->tx_flags & ~(CANFD_BRS | CANFD_FDF)))
> +			return -EINVAL;
> +

[Severity: Low]
Should the uAPI documentation be updated along with this new restriction?

Documentation/networking/iso15765-2.rst still describes tx_flags as an
open set of frame flags:

  * tx_flags: flags set into struct canfd_frame.flags at frame creation.
    Only applies to CAN FD traffic (i.e.: mtu = CANFD_MTU).

The comment in include/uapi/linux/can/isotp.h for struct
can_isotp_ll_options is similar:

	__u8  tx_flags;		/* set into struct canfd_frame.flags	*/
				/* at frame creation: e.g. CANFD_BRS	*/

Neither one says that only CANFD_BRS and CANFD_FDF are accepted, or that
other bits such as CANFD_ESI now return -EINVAL.

>  		memcpy(&so->ll, ll, sizeof(*ll));
>  
>  		/* set ll_dl for tx path to similar place as for rx */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9%40hartkopp.net
