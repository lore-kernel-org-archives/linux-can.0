Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172002;
	b=UbTINXpH0iR1mYpWiybRjjaHNQ5+UkjUzzSbD7d2VHGs0UMTzjDyzyzx2d63ZXlLqPvh
	 ej2AmRmWa+BHcXRIOunZKA5/iIEXGnfNniM36wQVjZhfyZ3RBcsv/xqNn832objZ1pF79
	 jM3nkIp1YOGH6N0nJz1MiHGj5JPnEGKKm26eitXdtG9KVWsVhmMLrP4bkH1s5ftVG3kV4
	 fHMAckDOptA+L+Qcw417wDZZo8Xs7+VlbKLK8oAtf276wwRISHZGnGU2tiGHiPqmwQ+Lq
	 tQ5GJhGBkdWMm0qc+eEjy0bHE/prG88JUrNL/qLCrt491C4BoS0C/Ir6kYMF5LLJFMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172002;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uQaQH7sz3A7FRITpdC1Mty4TZW+aGSt5Zvo5ak4cIPg=;
	b=0nGJpVKPUTooDo0U7p+COKNS3kYQ86erxwYX79A222WYLVmFiUMlqxG7xNkVFnJzwC8r
	 6bZHwwaKLjwxtaB7wH2Cz8ZSM5jUsUt0ndq0dfhotWV5SldNYtezPQ48qmxMGzzksTnWZ
	 xubTrUUCoVNI2E+NY1SUL57rcfw43WVDakQzuEv74s/VExN3yXGBS0bh1zEffQUdreEdq
	 oWG0xKabOg9CTu2VIJ5MKqqMnzPkGdZsDuqAFcO4YdYLoh4ZslclYwWmlabdhn7+4puJz
	 /HY+aeb8muqwHmR+Dmy4RSeKp4rXd2ufP0I8gjDdrFCMlo9rcxQ8bO0VYtQogQymg0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnfwbARn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E314D606A32A
	for <linux-can@vger.kernel.org>; Sun,  8 Nov 2026 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YnfwbARn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509611F0089F;
	Sun,  8 Nov 2026 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794172001;
	bh=uQaQH7sz3A7FRITpdC1Mty4TZW+aGSt5Zvo5ak4cIPg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YnfwbARnhOrYjHPwuBqRKCqzZQfsAvBQeq3pj1dhYiW7+G+j6zrSOrGsVA8Mk9nYu
	 Lt3rpYznvQYvNJVJnsGDnLTEUzlIfE95KN4sakXIstzEOX0dg4sHbgiZdl/LDV3g91
	 BJWG1oqmEuayBPBdetFQTkOwLTFl6gTpo6lyGfa4ZAdk9cr1t9MTLRKy3WvBJSDdSx
	 wKoblB/TUFjGZYC6XWG5Mu0SRofJFYhBaT5KhIpnTlTZVC/YZjiX0rG1C47mXtohfY
	 BoeGlqA0fu3JTvnm6Poff0Nrwz5gSMwvbMhoCQER9cAS7ujeMA4fHzWdWAyeFv+8s6
	 GHAo1CsNBeUqQ==
Message-ID: <sashiko-outbox-204055@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next v5 6/6] can: gs_usb: fix hardware timestamp
 state for mixed channels
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261108-gs_usb-fixes-v5-6-d52dd4940d46@pengutronix.de>
References: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
 <20261108-gs_usb-fixes-v5-6-d52dd4940d46@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 21:06:40 +0000
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] can: gs_usb: uninitialized timecounter race in
  gs_usb_timestamp_start()
- [Medium] can: gs_usb: uninitialized variable ts_supported in
  gs_usb_probe()
--

commit 7c42eeba5c6b2155ed555de5122751f1b8542d0f
Author: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

can: gs_usb: fix hardware timestamp state for mixed channels

This commit initializes the hardware timestamping infrastructure in
gs_usb_probe() when at least one channel supports hardware timestamps,
and tracks active timestamp-capable channels in gs_usb_timestamp_start()
and gs_usb_timestamp_stop().

> diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
> index 6327069f63c95..0a1cd14c940cc 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c

[ ... ]

> @@ -481,18 +482,35 @@ static void gs_usb_timestamp_init(struct gs_usb *pa=
rent)
>  	cc->mult =3D clocksource_hz2mult(GS_USB_TIMESTAMP_TIMER_HZ, cc->shift);
> =20
>  	spin_lock_init(&parent->tc_lock);
> -	spin_lock_bh(&parent->tc_lock);
> -	timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
> -	spin_unlock_bh(&parent->tc_lock);
> =20
>  	INIT_DELAYED_WORK(&parent->timestamp, gs_usb_timestamp_work);
> +	disable_delayed_work(&parent->timestamp);
> +}
> +
> +static void gs_usb_timestamp_start(struct gs_usb *parent)
> +{
> +	scoped_guard(spinlock_bh, &parent->tc_lock) {
> +		parent->active_timestamp_channels++;
> +		if (parent->active_timestamp_channels > 1)
> +			return;
> +
> +		timecounter_init(&parent->tc, &parent->cc, ktime_get_real_ns());
> +	}
> +
> +	enable_delayed_work(&parent->timestamp);
>  	schedule_delayed_work(&parent->timestamp,
>  			      GS_USB_TIMESTAMP_WORK_DELAY_SEC * HZ);
>  }

[Severity: High]
Can moving timecounter_init() into gs_usb_timestamp_start() race with
incoming RX URBs and cause a NULL pointer dereference or read an
incompletely initialized timecounter?

On a mixed-channel device where channel 0 does not support hardware
timestamps and channel 1 does, opening channel 0 submits the shared bulk
IN URBs while parent->tc.cc remains NULL.  When channel 1 is opened
later, __dev_open() sets __LINK_STATE_START (making netif_running() true)
before calling gs_can_open(), and timecounter_init() ->
gs_usb_timestamp_read() also drops parent->tc_lock for a synchronous USB
control transfer before finishing parent->tc initialization:

CPU0                                  CPU1 (<softirq>)
__dev_open(ch1)
  set_bit(__LINK_STATE_START, ...)
  gs_can_open(ch1)
                                      gs_usb_receive_bulk_callback()
                                        netif_running(ch1) =3D=3D true
                                        gs_usb_rx_offload()
                                          gs_usb_skb_set_timestamp()
                                            timecounter_cyc2time(&parent->t=
c)
                                              tc->cc->mask  <-- NULL deref
    gs_usb_timestamp_start()
      spin_lock_bh(&parent->tc_lock)
      timecounter_init(&parent->tc, ...)
        tc->cc =3D cc
        gs_usb_timestamp_read()
          spin_unlock_bh(&parent->tc_lock)
          gs_usb_get_timestamp()
                                      gs_usb_receive_bulk_callback()
                                        ...
                                          timecounter_cyc2time(&parent->tc)
                                            <-- uses uninitialized tc->mask

If an RX URB for channel 1 (such as a frame queued in firmware as
described in commit 5886e4d5ecec ("can: gs_usb: fix time stamp counter
initialization")) completes before timecounter_init() sets tc->cc,
timecounter_cyc2time() dereferences a NULL tc->cc; if it completes while
gs_usb_timestamp_read() has dropped parent->tc_lock, it reads an
incompletely initialized struct timecounter.

[ ... ]

> @@ -1526,6 +1541,7 @@ static int gs_usb_probe(struct usb_interface *intf,
>  	};
>  	struct gs_device_config dconf;
>  	unsigned int icount, i;
> +	bool ts_supported;
>  	int rc;
> =20
>  	rc =3D usb_find_common_endpoints(intf->cur_altsetting,
> @@ -1599,6 +1615,9 @@ static int gs_usb_probe(struct usb_interface *intf,
>  		parent->canch[i] =3D dev;
>  		parent->canch[i]->parent =3D parent;
> =20
> +		if (parent->canch[i]->feature & GS_CAN_FEATURE_HW_TIMESTAMP)
> +			ts_supported =3D true;
> +
>  		/* set RX packet size based on FD and if hardware
>  		 * timestamps are supported.
>  		 */
> @@ -1616,6 +1635,9 @@ static int gs_usb_probe(struct usb_interface *intf,
>  		parent->hf_size_rx =3D max(parent->hf_size_rx, hf_size_rx);
>  	}
> =20
> +	if (ts_supported)
> +		gs_usb_timestamp_init(parent);

[Severity: Medium]
Is ts_supported used uninitialized when probing a device where no
channel has GS_CAN_FEATURE_HW_TIMESTAMP set?  ts_supported is declared
without an initializer and is only assigned when the feature bit is
present.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-gs_usb-fix=
es-v5-0-d52dd4940d46@pengutronix.de?part=3D6
