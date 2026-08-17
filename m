Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFF644C640;
	Mon, 17 Aug 2026 16:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983577; cv=none; b=uRBJM5Apesyyy5xQEz8TUCnKOdj471BfYu+jxdMGlXMkncaADwPsmpn7+3e3H2k/0MbtAmv0Ro9lg+KRIGcCIoATk/Ih21AyQMkdZM1xVsMltpkphBNLK/XlXiilXrLnNHYuXOv5f5o6ixP2m9xiBVw2NB6y22PwL/nR3WbBkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983577; c=relaxed/simple;
	bh=84b/+m5AsnWNKdet5eIaIP/ZH48c5yvarveMK3o1AQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkFB/E4j1EFqlOPsf2vT2cif2NNRVIs6B8mrYbLacJmT3bKwf3jSRuwGfCTTnC2KyKOiwljhQl5dFOe0dZ1Wo1WVvo9VBx/rIsve6DMiUUP1iPRTAiH1Wgf9idweLN6nXpgct4yqPpjfITTolkWLds07jt+UuvxtMmUBiN+/OKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 85A7F20007B;
	Mon, 17 Aug 2026 18:19:21 +0200 (CEST)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ww03V-001z5y-1P;
	Mon, 17 Aug 2026 18:19:21 +0200
Received: from pengutronix.de (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2457E584DF8;
	Mon, 17 Aug 2026 16:19:21 +0000 (UTC)
Date: Mon, 17 Aug 2026 18:19:20 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Cheng Liu <chengliu480@gmail.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH can] can: rockchip: rk3576: fix rtnl_lock deadlock during
 interface down under bus traffic
Message-ID: <20260817-therapeutic-beetle-from-eldorado-502c6e-mkl@pengutronix.de>
References: <20260817013750.1836064-1-chengliu480@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e75pqpwafxmtib2n"
Content-Disposition: inline
In-Reply-To: <20260817013750.1836064-1-chengliu480@gmail.com>


--e75pqpwafxmtib2n
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH can] can: rockchip: rk3576: fix rtnl_lock deadlock during
 interface down under bus traffic
MIME-Version: 1.0

On 17.08.2026 09:37:50, Cheng Liu wrote:
> When bringing the CAN interface down (via `ip link set can0 down`) while
> there is heavy incoming CAN traffic or continuous hardware error frames,
> the system hangs and deadlocks. Existing and new networking operations
> (such as `ifconfig`, SSH logins, Socket operations) hang indefinitely
> waiting for `rtnl_lock`.
>
> The deadlock occurs because `rk3576_canfd_close()` calls `napi_disable()`
> before `rk3576_canfd_stop()`. Since hardware interrupts are still
> active, incoming CAN frames and error interrupts continuously trigger
> `napi_schedule()`, preventing `napi_disable()` from seeing the
> `NAPI_STATE_SCHED` bit cleared and causing it to loop infinitely in
> `msleep(1)`. Because `dev_close()` holds the global `rtnl_lock`, the
> entire networking subsystem deadlocks:
>
> Call trace:
>   __switch_to+0xdc/0x120
>   __schedule+0x2ac/0x840
>   schedule+0x54/0xe0
>   schedule_hrtimeout_range_clock+0x98/0x134
>   usleep_range_state+0x7c/0xb0
>   napi_disable+0xc0/0x110
>   rk3576_canfd_close+0x44/0xd0
>   __dev_close_many+0xb0/0x14c
>   dev_change_flags+0x28/0x64
>   do_setlink+0x618/0xe2c
>   rtnetlink_rcv_msg+0x2a8/0x380
>
> Fix this by:
> 1. Reordering `rk3576_canfd_close()` to call `rk3576_canfd_stop()` before
>    `napi_disable()`, ensuring interrupts are disabled and controller is
>    in reset mode before waiting for NAPI to complete.
> 2. Standardizing `rk3576_canfd_rx_poll()` to respect the NAPI
>    quota/budget and properly complete NAPI polling via
>    `napi_complete_done()`.
> 3. Guarding against NULL pointer dereference in `rk3576_canfd_err()` when
>    `alloc_can_err_skb()` fails, and calling `can_bus_off()` upon bus-off.
>
> Signed-off-by: Cheng Liu <chengliu480@gmail.com>
> ---
>  drivers/net/can/rockchip/rk3576_canfd.c | 61 +++++++++++++------------

The driver for the rk3576 is not mainline, yet. Maybe Elaine can pick it
up.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--e75pqpwafxmtib2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSl+MghEFFAdY3pYJLMOmT6rpmt0gUCaoM0hgAKCRDMOmT6rpmt
0p29AQC1Lomvcx6Mg8YWaOewAEvsPJFDBGflU/3z0hHmDNSwcwEAglk0E3MlwQM3
FiMTHhOAVQHuu9zUnHVZFpczMKzlIQw=
=jQAz
-----END PGP SIGNATURE-----

--e75pqpwafxmtib2n--
