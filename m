Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CFD3EC82C
	for <linux-can@vger.kernel.org>; Mon, 24 Aug 2026 09:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562798; cv=none; b=Am9N7AC1Z4ndtwIyxx0sWVd5cYfluOJDIl8sSvo0frWyG8q0fd9wvXDpiSm9EBCY4tiycauo0yaOtnwKeoHQ3MOZ3cTFFdGH/PGGXqNlHNEdccYb4yF49IAU9tprI8FN7L7IRykf1hppTEFyz1719SnCCjl9bY4O5Pqz5D0R1rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562798; c=relaxed/simple;
	bh=GI1SeMD+djksEvIBp7T7ggNe6lfalVYGb+vAnm5rxBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f/NN5oAS7T/0TRiPc3xSIvf1VY7LkrtJ0i00QvDmfU0K9bfZKjgVNpJsDvht+h3lVXor47HxXKO2eFqpj0hI/kSKphKUg0cdNaiHcUVEDsjV9n+Hud4zK3l+s6U4b1Xo85c0NqZG4nh97lN4g6rV3VxiruuvXtlnztqv+K3/WoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IySUbILr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IySUbILr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494601F000E9;
	Mon, 24 Aug 2026 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787562796;
	bh=zQvGQgE12dAIzyoMdfHe2h3QuFFj1gwdL3a6NqlrY4s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IySUbILrvCmGHgvIZ78S181DqdTNUB2v6qBAPRNueBB1mbjcq5JAKUnDvNlombMzs
	 ktoZYkcFWAlB1rbVHbKunWCHCpOHO0u6xw0VJf2S8T24yQSoWixaxDHAewu71c2k9+
	 daFNTvQmngVLxJusWpeSnOskFy/Uf2Yj3kmqiOFZNczdoJS+LfZ4KKTb8A5WPy+Sx8
	 Xue73IIQcRJlYSVBVlKg/4uT3/4P5GgVsOPiB87BUImLSWluJwhqugm8Cnsm19KfyP
	 MxPqzhohM+eknF7kmnMJ8mpqOAvMRAXJ3Yb2EmIKPsYvVeh2Lv2OkULvZfE+66Xork
	 daoUCbsHok2nA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] can: usb: f81604: fix struct f81604_int_data size
 mismatch
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?UFMxMCBQRVRFUiBIT05HIOa0que5vOa+pA==?= <peter_hong@fintek.com.tw>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260824082758.9118-1-peter_hong@fintek.com.tw>
References: <20260824082758.9118-1-peter_hong@fintek.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 09:13:15 +0000
Message-Id: <20260824091316.494601F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Improper teardown ordering in f81604_close() causes a use-after-fr=
ee of the driver's private data via clear_reg_work.
- [High] Unbounded memory and URB resource leak during CAN bus-off recovery=
 and interface toggle.
- [High] Soft lockup (CPU Denial of Service) due to bypassed URB status che=
cks in the interrupt callback.
--

--- Patch [1]: [PATCH] can: usb: f81604: fix struct f81604_int_data size mi=
smatch ---
commit 53e24ec343d9d1cbf17bed31729c1ccebdbe512a
Author: PS10 PETER HONG =E6=B4=AA=E7=B9=BC=E6=BE=A4 <peter_hong@fintek.com.=
tw>

can: usb: f81604: fix struct f81604_int_data size mismatch

The struct f81604_int_data was padded to 12 bytes but hardware sends exactly
9 bytes, causing short URB checks to discard valid messages and resulting in
transmission failures. This commit removes the padding attribute so the str=
uct
size matches the 9-byte hardware data length.

> diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
> index f12318268e46b..4c147b9d6d690 100644
> --- a/drivers/net/can/usb/f81604.c
> +++ b/drivers/net/can/usb/f81604.c
> @@ -169,7 +169,7 @@ struct f81604_int_data {
>  	u8 rxerr;
>  	u8 txerr;
>  	u8 val;
> -} __packed __aligned(4);
> +} __packed;
> =20
>  struct f81604_sff {
>  	__be16 id;

[Severity: High]
This isn't a bug introduced by this patch, but is the teardown ordering in
f81604_close() correct?

drivers/net/can/usb/f81604.c:f81604_close() {
...
	cancel_work_sync(&priv->clear_reg_work);
	close_candev(netdev);

	f81604_unregister_urbs(priv);
...
}

Because f81604_unregister_urbs() is called after cancel_work_sync(), URBs a=
re
still active. A concurrently executing interrupt URB callback can schedule =
the
work again via f81604_handle_can_bus_errors():

drivers/net/can/usb/f81604.c:f81604_handle_can_bus_errors() {
...
	if (priv->clear_flags)
		schedule_work(&priv->clear_reg_work);
...
}

When the device is later disconnected, f81604_disconnect() frees the netdev
and its embedded priv structure. Will the pending clear_reg_work then execu=
te
and access the freed priv pointer, leading to a memory corruption or crash?

[Severity: High]
This is a pre-existing issue, but does the driver leak URBs and their alloc=
ated
buffers during bus-off recovery and interface toggles?

When the CAN bus recovers from a bus-off condition, f81604_set_mode() calls
f81604_start() which registers new URBs:

drivers/net/can/usb/f81604.c:f81604_set_mode() {
	switch (mode) {
	case CAN_MODE_START:
		ret =3D f81604_start(netdev);
...
}

f81604_start() blindly calls f81604_register_urbs(), allocating and submitt=
ing
5 new URBs. The old URBs were never killed because can_bus_off() does not s=
top
them, seemingly leaking 5 URBs on every recovery.

Additionally, during f81604_close(), if an URB callback is executing
concurrently, it checks netif_device_present() instead of netif_running():

drivers/net/can/usb/f81604.c:f81604_read_bulk_callback() {
...
	if (!netif_device_present(netdev))
		return;
...
resubmit_urb:
	usb_anchor_urb(urb, &priv->urbs_anchor);
	ret =3D usb_submit_urb(urb, GFP_ATOMIC);
...
}

Will this cause the URB to be resubmitted even after ndo_stop has run, and =
when
the interface is brought back up, multiply the number of active URBs leadin=
g to
resource exhaustion?

[Severity: High]
This is a pre-existing issue, but can the short length check in the interru=
pt
callback cause a soft lockup?

In f81604_read_int_callback(), the short URB check is performed before the
status check:

drivers/net/can/usb/f81604.c:f81604_read_int_callback() {
...
	if (urb->actual_length < sizeof(*data)) {
		netdev_warn(netdev, "%s: short int URB: %u < %zu\n",
			    __func__, urb->actual_length, sizeof(*data));
		goto resubmit_urb;
	}

	switch (urb->status) {
...
}

When a USB hardware error occurs, the host controller completes the URB wit=
h an
error status and an actual_length of 0. Because 0 < 9, the code logs a warn=
ing
and jumps straight to resubmit_urb, bypassing the error-handling switch.

Will the host controller then immediately fail the resubmitted URB again,
triggering an infinite loop of hardware errors in softirq context and leadi=
ng
to a CPU soft lockup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824082758.9118=
-1-peter_hong@fintek.com.tw?part=3D1
