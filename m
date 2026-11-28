Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861216;
	b=a6RUA7QmqRpnrrRs+Vq4r449NXjC7vQE7Ip1ZLUMmSjq9P+dSJjGEoqnBH+XJHA6DSzR
	 iBSY8eznQ2L7DFoeyUkOxk0bbDzXWNd6qlF9J+4BEHHtmn2GlbxHMJH8jSobOMYabABzf
	 9LRL57fNXA/CW5q3wxhd50eKAx/NaVIA653kddc8IgXZzdhgVbYbV+Ilhvn9TK2Ix9TY+
	 Y1ZfwkABIX8wpLe3Ni6yRF5Ofyx12CUPuSth6mcFaWVegvm2hSNxdF/ciFNeGJGwj3YwB
	 SyYyag+S4O6Y/2DaNHRUyiBa/1vv3xG6N6WsuuVFCT3qlE+kd+bg8dKjB61F9vyd8rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861216;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GaNz+pmU1VTniGF/jju7Ke5T5nIU3WzjrXJBTzKElWQ=;
	b=snBAfIHs7fiu3MN//PNvCzaxw/8xykh2kdht1icUKmsyO5qPRq9oxT0Z5dQiBDn7elQu
	 3r1CS920J8ze01gCUqiAq/CDVJZzWRSGcY93hB0iTX2QrEpgjcRqNAYcoUIeUAzCmEl2N
	 MICfK/FOWWr89tVEw5pj4G8flNHcG9m6q/Y/LGKgIefvwt9tj/xjj8lE/Sm5WFVtNcx9S
	 HTllqkmMA6arcxLaM0zustq4mLjGC6/6T8HDwYHJf2ayQ7Z13nLtkqS2Y8UlSQhDxabhQ
	 L+lnz1F3/1LCoiwZ4iaxxJHMXi36Huox1aCxJCrR2NsR+q+be6JCvFeVT3oqLo90Fww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OgybUzei;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92A606A31C
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 10:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OgybUzei
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B54F1F00897;
	Sat, 28 Nov 2026 10:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861216;
	bh=GaNz+pmU1VTniGF/jju7Ke5T5nIU3WzjrXJBTzKElWQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OgybUzeiMXQN8jz9wlk4uOXosZnxPhAQBOcYUn4/R75wVq44jyFe3Eadn65p15lZm
	 qOMAfL0yhNwOA4LHEuQlFyDzZ5CXwmskG3y3Y9+O4dEBj93VWzcwEpxl4WHHq3f+sF
	 5hFES3p7VghCErycjFFVIYvoicPybKPDV7/cL7K82fVGGSC46+h7mGfGR2b7+VS4hI
	 FZrKgVekrqz50nEM+J7nK+lFbLw/eUPanM/LRy97Yu0rBLplmzX0XSnVjkMrTKhTOF
	 2bumU0xgw4jyKKTAUU/CsHnXf7qPu3W+hWDGAP+82KPQnQPC3j/AtLljVuAiWPaHw8
	 TvuQAhUEdYvkg==
Subject: Re: [PATCH can-next 05/22] can: isotp: add the frame transmission
 time to the protocol timeouts
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sashiko-bot@kernel.org,
 zihanx@nebusec.ai, o.rempel@pengutronix.de, yewentian395@gmail.com,
 kuba@kernel.org
Date: Sat, 28 Nov 2026 10:20:15 +0000
Message-ID: <179586121507.3131.7944983209887671413@kernel.org>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-5-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-5-681ef8d8c2c9@hartkopp.net>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds a new rule to isotp_setsockopt_locked()
  (net/can/isotp.c:1756-1759): setsockopt(CAN_ISOTP_OPTS) now returns…

--

can: isotp: add the frame transmission time to the protocol timeouts

This patch adds so->frame_txtime (N_As/N_Ar) to the rx timeout started in
isotp_send_fc() and to the FC/echo timeout started in isotp_sendmsg(). It
also makes setsockopt(CAN_ISOTP_OPTS) return -EINVAL when frame_txtime is
above 100 ms, unless it is CAN_ISOTP_FRAME_TXTIME_ZERO.

Closes: https://lore.kernel.org/linux-can/eb5e9618-3dbf-42cb-a635-752ff9fbcb99@hartkopp.net/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 7be3d9322ad1a..197dc7bdb6ec0 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -127,6 +127,7 @@ MODULE_PARM_DESC(max_pdu_size, "maximum isotp pdu size (default "
>  
>  #define ISOTP_FC_TIMEOUT 1	/* 1 sec */
>  #define ISOTP_ECHO_TIMEOUT 2	/* 2 secs */
> +#define ISOTP_MAX_FRAME_TXTIME_NS (100 * NSEC_PER_MSEC) /* max N_Ar/N_As */

[ ... ]

> @@ -1751,6 +1753,11 @@ static int isotp_setsockopt_locked(struct socket *sock, int optname,
>  		if (hweight32(opt->flags & ISOTP_ALL_BC_FLAGS) > 1)
>  			return -EINVAL;
>  
> +		/* limit the frame transmission time (N_As/N_Ar) */
> +		if (opt->frame_txtime != CAN_ISOTP_FRAME_TXTIME_ZERO &&
> +		    opt->frame_txtime > ISOTP_MAX_FRAME_TXTIME_NS)
> +			return -EINVAL;
> +
>  		memcpy(&so->opt, opt, sizeof(*opt));

[Severity: Medium]
Could this break existing userspace? Before this patch,
setsockopt(CAN_ISOTP_OPTS) accepted any u32 value for frame_txtime. A value
above 100 ms now gets -EINVAL.

The check runs before the memcpy(), so the whole call is rejected. That
means none of the other options passed in the same call get applied either,
such as CAN_ISOTP_CF_BROADCAST, ext_address or the padding settings.

Do the timeout changes need this limit? ktime_set() takes an unsigned long
nsecs and computes secs * NSEC_PER_SEC + nsecs. Even 0xFFFFFFFE ns only
produces an FC timeout of about 5.3 s, with no overflow.

frame_txtime also works as a pacing value, not only as N_As/N_Ar.
isotp_rcv_fc() adds it to every consecutive frame gap:

    so->tx_gap = ktime_add_ns(so->tx_gap, so->frame_txtime);

In CAN_ISOTP_CF_BROADCAST mode without CAN_ISOTP_FORCE_TXSTMIN,
isotp_sendmsg() uses it as the whole gap:

    so->tx_gap = ktime_set(0, so->frame_txtime);

A broadcast gap above 100 ms was valid until now. CAN_ISOTP_FORCE_TXSTMIN
together with CAN_ISOTP_TX_STMIN can still produce such a gap. Even so,
existing configurations that use frame_txtime for this would stop working.

The uAPI header still describes frame_txtime as a plain nanosecond value:

include/uapi/linux/can/isotp.h:
	__u32 frame_txtime;	/* frame transmission time (N_As/N_Ar)	*/
				/* __u32 value : time in nano secs	*/

The CAN_ISOTP_FRAME_TXTIME_ZERO comment block and
Documentation/networking/iso15765-2.rst list only 0 and
CAN_ISOTP_FRAME_TXTIME_ZERO as special values. Neither mentions an upper
bound or an -EINVAL case, and ISOTP_MAX_FRAME_TXTIME_NS is private to
net/can/isotp.c. Later patches in the series do not seem to update either
document.

If the limit stays, should the uAPI header and the rst document it? Could
the commit message also explain why 100 ms was chosen?

>  
>  		/* no separate rx_ext_address is given => use ext_address */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9%40hartkopp.net
