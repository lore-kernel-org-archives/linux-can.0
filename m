Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861224;
	b=zOWoEg5cxJBzV036ZZkH+pBFVly7azBlENmaz+IXFXPlEeGQ5MkzOuiIBg7OqGDXHrJ6
	 XfNvN8rOxeEKuCyJAdI5COCKCncqlxznmut8XhE4wkU62IUSJW3fN1RW+uOoncLW4RnY9
	 L6OQEdOW0/Eifbe4LZiKZqW7yTcheCBE9hg5wD9eHnGLdgOWKLe2EhxK/J0bslg2jsRDz
	 p4gAYpqcBbG3upGEdBKpIEMqMEHBqT+yL8Cy0g+pwJeVfNtx8E0y3zJG6bm2lE0vaudml
	 S8Tej+hC8g6Pv8NlozDyWctefw6v04Q2Sg1F2Q5Qs9ifAPNQnSP732Jo68aWIlK29qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861224;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pi+NE1p8H9yhkySmxKgLlqzbR+9YvJtEz/RQlfZuxqU=;
	b=KndCPP8cm9h10icPKoLPRVyghySjowxQ6iRKMKiARaW09guAqv13iXsUOQVjnwVk3HSy
	 actMP25K8/NGXvY0da5RrjPYWpRhAkGhQAOd75EQHHlVjsbPG5gg7pNWmPn1C9/u/MTTc
	 c3gYl+QXhRLwFZ9YZPLoOqQJyM1edVHAPHbfvixlIz+otsyudaISni38tenSSVLu++Ova
	 3PzgpDP4KpXDzA5vVon2NfxADQeefjDBd28vYuR5S2p7YpO8b6AAtnPMFNnrUmZ/lajrT
	 qug7ajSZ8Opc0he7PotZ/i2j4qewbcvc1pBfehX0+RwJ5tX+buHbpCkUhyGnjtjAfiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maA8BbGn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672C9606A31F
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maA8BbGn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 972E31F000C1;
	Sat, 28 Nov 2026 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861224;
	bh=pi+NE1p8H9yhkySmxKgLlqzbR+9YvJtEz/RQlfZuxqU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=maA8BbGnNdUamaH+DpCuFZDrFgPrEUc2lohiWAO/w+gXHrU5dVRjeFx7xF3d+WY0l
	 Jb+ifZLMa4vAcaQqHk6sVEVVCNDAaI4bBOyRup4hFzDfPR0R0bsToYAc59g16fL9sy
	 5WNAThtfHjKp+6nRFza8d8mkDro6lIrS1QE+AJPWtrpCKvTNYHn2wLmwzpgXnuc/2w
	 tJ31bCCd9ldbnIBTjTgn1+L7R8ggD4FaqDDeqmasKhWML50AM8Ih8dWxLiIqOcBaJ7
	 9a4ayZcBxGgwH0+999KmRoHxZTG4+K34snQHMNC1k3zV3JMAvzlB1HWJU+G0R39CHx
	 qKBw4BEvbIYZQ==
Subject: Re: [PATCH can-next 14/22] can: isotp: ignore invalid SF and FF
 frames during a reception
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sashiko-bot@kernel.org,
 zihanx@nebusec.ai, o.rempel@pengutronix.de, yewentian395@gmail.com,
 kuba@kernel.org
Date: Sat, 28 Nov 2026 10:20:23 +0000
Message-ID: <179586122316.3131.4927340987108567833@kernel.org>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-14-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-14-681ef8d8c2c9@hartkopp.net>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In isotp_rcv_sf() (net/can/isotp.c), the patch moves the
  termination of an ongoing reception (hrtimer_cancel(&so->rxtimer);…
- [Low] The commit 'can: isotp: ignore invalid SF and FF frames during a
  reception' fixes a real, user-visible bug, but it has no Fixes: tag…

--

can: isotp: ignore invalid SF and FF frames during a reception

This commit moves the rx timer cancel and the ISOTP_IDLE state reset in
isotp_rcv_sf() and isotp_rcv_ff() so they run after the frame validity
checks. An invalid SF or FF should then no longer end an ongoing
reception. isotp_rcv_ff() now parses LL_DL and FF_DL into local variables
and stores them in so->rx only after the FF has been validated.

> Check the SF/FF first and terminate an ongoing reception only for a
> valid SF/FF. isotp_rcv_ff() reads the LL_DL and FF_DL into local
> variables to keep the data of an ongoing reception for invalid FFs.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

[Severity: Low]
Should this patch have a Fixes: tag and Cc: stable?

The hrtimer_cancel() calls that run before the validity checks in
isotp_rcv_sf() and isotp_rcv_ff() come from commit e057dd3fc20f ("can: add
ISO 15765-2:2016 transport protocol"). The WRITE_ONCE() state resets in the
same place were last changed by commit 050f010f920d ("can: isotp: fix timer
drain order, wakeup handling and tx_gen ordering").

In those kernels, any node on the bus can end an ongoing reception without
any notice. It only has to send an invalid SF (SF_DL 0) or an invalid FF
(CAN_DL != padlen(CAN_DL), FF_DL below FF_DLmin, or an unneeded 32 bit
escape). isotp_rcv_cf() then drops the remaining CFs:

    if (READ_ONCE(so->rx.state) != ISOTP_WAIT_DATA)
        return 0;

Because the timer has been cancelled, no ETIMEDOUT is reported for the lost
PDU either. Earlier isotp fixes such as 050f010f920d had both Fixes: and
Cc: stable.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index f6801c18172cf..39bae46701cc3 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -549,12 +549,14 @@ static int isotp_rcv_sf(struct sock *sk, struct canfd_frame *cf, int pcilen,
>  	struct isotp_sock *so = isotp_sk(sk);
>  	struct sk_buff *nskb;
>  
> -	hrtimer_cancel(&so->rxtimer);
> -	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
> -
> +	/* ignore invalid SFs (ongoing reception is not affected) */
>  	if (!len || len > cf->len - pcilen)
>  		return 1;
>  
> +	/* terminate a potentially ongoing reception */
> +	hrtimer_cancel(&so->rxtimer);
> +	WRITE_ONCE(so->rx.state, ISOTP_IDLE);
> +
>  	if ((so->opt.flags & ISOTP_CHECK_PADDING) &&
>  	    check_pad(so, cf, pcilen + len, so->opt.rxpad_content)) {
>  		/* malformed PDU - report 'not a data message' */

[Severity: Medium]
Has the SF been fully validated at this point?

When CAN_ISOTP_CHK_PAD_LEN or CAN_ISOTP_CHK_PAD_DATA is set, an SF with a
valid SF_DL but wrong padding is still rejected as malformed by the
check_pad() test. That test now runs after the ongoing reception has
already been aborted.

Take a socket that has received a valid FF, so rx.state is ISOTP_WAIT_DATA
and the rx timer is running. An SF with a valid SF_DL and bad padding then
arrives:

isotp_rcv()
  isotp_rcv_sf()
    SF_DL length check passes
    hrtimer_cancel(&so->rxtimer)
    WRITE_ONCE(so->rx.state, ISOTP_IDLE)
    check_pad() fails -> sk->sk_err = EBADMSG, return

isotp_rcv_cf() then drops the remaining CFs of the interrupted PDU, because
rx.state is no longer ISOTP_WAIT_DATA. Since the timer was cancelled, no
ETIMEDOUT is reported for that PDU. The application only sees EBADMSG for
the SF, which was never delivered.

This seems to contradict the new comment "ignore invalid SFs (ongoing
reception is not affected)". It also contradicts the commit message, which
says "terminate an ongoing reception only for a valid SF/FF".

Should the termination also move after the padding check?

The ordering stays the same later in the series, after these functions
are changed to return void and check_pad() is renamed to chk_pad_fail().

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9%40hartkopp.net
