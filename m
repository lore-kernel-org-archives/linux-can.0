Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861222;
	b=yh0YCGWQ1XUiEtgXjWQFBOmiccF9VTcTlrroSIr3SFQfMQ+QrK44vWhX3X6zqHD+HXBR
	 c8JgCy0HOfFn9Kijr5HnAOBtgGGCbk4sUxNCOkO2DVEBbIWseQ7AeL4k8FSGh9tB04q/m
	 woQQVNaZVwATiRHU3a9GNTlsOIR49Be9nv/N482bHf0MTvzHbCXPWH2RNReLcSJaYuGiA
	 3Py0NQve6f0rio//okEBOhRZ5vr19ybK8acueKZuZNOIgtiLxSnuDWmq0Qxd/BbpZMMct
	 CE77IjQqHFf+OQmcCC+Bfu22tPTAZPIp7UUSFQCY5io82c3gHSDxh/vgBVoEWWvyE0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861222;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GRQBO8BtDy1hYJNZ6MofCXfjRdnrq9Z4h1ICIF+/z0g=;
	b=NzlvO3z4kc/kAij0bi36Ang4D88J4XwOtU7GAjoj562lWdjUOfX/yY+Zt2loVg34oNyf
	 tKW0Ap4W5TDTYLgUIZk9up+IpICC+h5QFDWMF/UKTRpqRWT75TXmRFYvB1oNd0891xazC
	 uGln3DwMJ41Gsh2+x/cVnbGWLsv3M2Q/RCmEoXyGVq4zh/kuj+J+R8gT3vkNGsI3WQwDI
	 GYzLETrEvqx5TnJFxH2MOLZPhVz4hz5FFms4ln2M5BEV7GAd3EMRbfY6dWNJ+ClUR5SfE
	 ykk+47yj6c5c8aKUCEji9WCybPKQsDsCXIDPBGjIYYadgeFmjwPCZCEiPBPSxKEdHcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ddeW/FIa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C260606A31F
	for <linux-can@vger.kernel.org>; Sat, 28 Nov 2026 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddeW/FIa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E181F000C1;
	Sat, 28 Nov 2026 10:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861221;
	bh=GRQBO8BtDy1hYJNZ6MofCXfjRdnrq9Z4h1ICIF+/z0g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ddeW/FIapTYvhFs7WrDiSCf7dXM3zOcMWtxNWlahJDpQLzFI+xm1lNyhUjmimS6OL
	 3noEr5VrYQ4dhpPjAkXVm3uBD7s6A+mNDobttoUw3YJXQfGccWRTqHt+ZL3S9eUyK/
	 Io3JT8u8M8dgGNx9ZlpSfKgAvYiJPHb03sPTxKoG+0am2Or04X7+qfiXFuQfemtY5R
	 CQUbXejHMzY+xj7senxcLMI2QhenSDYcEoYl9I8rM6zIlndRNnNRAfQ2pJnD+dsvqs
	 r/FdAMWTiHdUEAjr+jdOx+bKtCKmI/j3trlFa024sTjOFEldoICIaF9uZXIu1o4Vo5
	 XPzkwLU36Qk7A==
Subject:
 Re: [PATCH can-next 12/22] can: isotp: check the data length of the last CF
From: netdev-bot+sashiko@kernel.org
To: socketcan@hartkopp.net
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, sashiko-bot@kernel.org,
 zihanx@nebusec.ai, o.rempel@pengutronix.de, yewentian395@gmail.com,
 kuba@kernel.org
Date: Sat, 28 Nov 2026 10:20:20 +0000
Message-ID: <179586122073.3131.6440099329577042033@kernel.org>
In-Reply-To: <20261126-getsockopt-memcg-isotp-v1-12-681ef8d8c2c9@hartkopp.net>
References: <20261126-getsockopt-memcg-isotp-v1-12-681ef8d8c2c9@hartkopp.net>
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

- [Low] The commit "can: isotp: check the data length of the last CF"
  fixes a long-standing receive-path validation bug in isotp_rcv_cf()…

--

can: isotp: check the data length of the last CF

This commit fixes the short CF length check in isotp_rcv_cf(). A CF
shorter than LL_DL now has to carry all of the missing PDU bytes in its
own payload (cf->len - ae - N_PCI_SZ), not in the payload of a full CF.

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index 8aeec4ca1d19a..8ae314fe68d25 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -674,8 +674,10 @@ static int isotp_rcv_cf(struct sock *sk, struct canfd_frame *cf, int ae,
>  
>  	/* CFs have usually the LL_DL length */
>  	if (cf->len < so->rx.ll_dl) {
> -		/* this is only allowed for the last CF */
> -		if (so->rx.len - so->rx.idx > so->rx.ll_dl - ae - N_PCI_SZ)
> +		/* only the last CF may be shorter: drop it when the
> +		 * missing PDU bytes exceed its possible payload
> +		 */
> +		if (so->rx.len - so->rx.idx > cf->len - ae - N_PCI_SZ)
>  			return 1;
>  	}

[Severity: Low]
Should this commit have a Fixes: tag and Cc: stable?

The old check against so->rx.ll_dl - ae - N_PCI_SZ seems to date back
to the original isotp code in e057dd3fc20f ("can: add ISO 15765-2:2016
transport protocol").

Take classic CAN with ll_dl = 8, ae = 0 and 7 bytes still missing. A 4
byte CF carries only 3 bytes, but the old check evaluates 7 > 7. The
frame is accepted and reception keeps waiting for more CFs.

Commit 4b558c0ccb62 ("can: isotp: always start the rx timeout in
ISOTP_WAIT_DATA state") moved this block ahead of hrtimer_cancel() but
left the comparison as it was. That commit has Fixes: e057dd3fc20f and
Cc: stable@vger.kernel.org.

Stable trees that pick up 4b558c0ccb62 would get the moved check with
the old comparison. Nothing in this commit would tell them to take this
fix as well.

Would tags like these fit?

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org

None of the patches in this series seem to have Fixes: tags. If the
series is meant only for net-next, could the commit message say so?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261126-getsockopt-memcg-isotp-v1-0-681ef8d8c2c9%40hartkopp.net
