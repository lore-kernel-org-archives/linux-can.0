Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEE73845AC;
	Fri, 16 Oct 2026 02:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118238; cv=none; b=Kcxl97Tq8JQTJJy4qrhnQ7GA0C5A8zhZrZuh9uIW3qU/BBu01BXcTWjjHxn2YOOS4X2GNN+oHP3QRv6iHqTFeHP3+P8H1wmh/Nk3e9JwB6+mX3u+A4ZFPUKQBnz/zGTgxxHARhug/LI1REqrdm0hGm9pg9/EUc/fKJ+N2hjkxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118238; c=relaxed/simple;
	bh=NLGXQ6S+UzrGweleq2coDo6hDP7rUjR1GgWAHQcJWeo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HegdBV4yyFMSabQwTDHQjdleO8vSfvrG5J2Zs62A/1nLP2xJPsiahERyiOGqHkUX3hqRBEVvIP5cJVQ475pppZ9uuer3RwbY3+8hU3BexONiiTaMO7AgdmzETdHhhGOSHKlucMZCWLj5cGqGnKPTAoU8SdclUvBTp84UhFH8Xcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaZhC4Kf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaZhC4Kf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E591F000C4;
	Fri, 16 Oct 2026 02:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792118235;
	bh=noAKhCMP/308XIoU2rOkCFa1m5zPEvdiql5A/84HVao=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WaZhC4KfXg6k68n8r7dhWD1ximVSY6zqUpMSGRDR/JYyDxoC7A/mNopGXJJ+gj/Ew
	 sM2xFM8jJQuvMKSzIQ/dnKkk8mnN3BXAULzSmUdS89kyPFp65FlXHuRJZiaxeB+3+i
	 6kXy/UvjrG43Gkx+wKgFjxIdZbrLJuIqEdyxvSZgw+78tIr/1csW0girSjbbZyfrT5
	 Izq11wvw51oKZcR0ogqsNsKGeuOpCXVuQyhwiTBCV+Rb1kl71AYgCwpqBhJMcT4s9b
	 hWRSQcROk1sLRkbbIReid+1OkVZf2ZHHjD/H2wPvp/2NPKbDPQh+PbnW6yy1WMQk6g
	 s+2OG2qD2hGdw==
Subject: Re: [PATCH net-next 28/37] can: ems_usb: use usb_kill_urb() to stop
 the intr URB
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, socketcan@hartkopp.net,
 kurt.van.dijck@eia.be
Date: Fri, 16 Oct 2026 02:37:14 +0000
Message-ID: <179211823441.434549.9677243526506061190@kernel.org>
In-Reply-To: <20261015015336.816543-29-mkl@pengutronix.de>
References: <20261015015336.816543-29-mkl@pengutronix.de>
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

- [Low] Now that unlink_all_urbs() stops the intr URB with
  usb_kill_urb(), there is a new race window on close.

Pre-existing issues:
- [Critical] unlink_all_urbs() in drivers/net/can/usb/ems_usb.c (lines
  755-757) can free the RX coherent buffers twice.
- [Medium] ems_usb_start() does not undo partial setup when it fails.

--

can: ems_usb: use usb_kill_urb() to stop the intr URB

This commit changes unlink_all_urbs() to stop the intr URB with
usb_kill_urb() instead of usb_unlink_urb(). The goal is to make sure
ems_usb_read_interrupt_callback() has returned before
ems_usb_disconnect() frees dev->intr_in_buffer and the candev.

Link: https://patch.msgid.link/20260923030522.409344-1-fanwu01@zju.edu.cn

> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
> index 24cf8f651f8f..2d31f0b86859 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -748,7 +748,7 @@ static void unlink_all_urbs(struct ems_usb *dev)
>  {
>  	int i;
>  
> -	usb_unlink_urb(dev->intr_urb);
> +	usb_kill_urb(dev->intr_urb);

[Severity: Low]
Can this now log a spurious error during a normal ifdown?

usb_kill_urb() raises urb->reject before it unlinks the URB. Suppose the
intr URB completes with status 0 while ems_usb_close()->unlink_all_urbs()
is inside usb_kill_urb(). In that case ems_usb_read_interrupt_callback()
takes the case 0 path and resubmits:

ems_usb_read_interrupt_callback() {
    ...
	err = usb_submit_urb(urb, GFP_ATOMIC);

	if (err == -ENODEV)
		netif_device_detach(netdev);
	else if (err)
		netdev_err(netdev, "failed resubmitting intr urb: %d\n", err);
}

usb_hcd_link_urb_to_ep() in drivers/usb/core/hcd.c then rejects the
resubmit:

	/* Check that the URB isn't being killed */
	if (unlikely(atomic_read(&urb->reject))) {
		rc = -EPERM;
		goto done;
	}

As a result, "failed resubmitting intr urb: -1" gets printed. The
netif_device_present() check at the top of the callback doesn't catch
this, because the device is still present during close. usb_unlink_urb()
never set reject, so this message couldn't appear here before.

The kill itself still completes, so the only effect is log noise. Would it
make sense to treat -EPERM as an expected result, alongside -ENODEV?

>  
>  	usb_kill_anchored_urbs(&dev->rx_submitted);
>  

[Severity: Critical]
This isn't a bug introduced by this patch, but it is in the same helper
and the same disconnect teardown. Can unlink_all_urbs() free the RX
coherent buffers twice?

The loop just below this hunk frees every dev->rxbuf[i] but never clears
the pointers:

	for (i = 0; i < MAX_RX_URBS; ++i)
		usb_free_coherent(dev->udev, RX_BUFFER_SIZE,
				  dev->rxbuf[i], dev->rxbuf_dma[i]);

unlink_all_urbs() is called from ems_usb_close() and also unconditionally
from ems_usb_disconnect():

ems_usb_disconnect() {
	...
		unregister_netdev(dev->netdev);

		unlink_all_urbs(dev);
	...
}

There are three ways to reach a second free:

If the interface is up at unplug, unregister_netdev() closes it and
ems_usb_close()->unlink_all_urbs() frees the buffers. ems_usb_disconnect()
then calls unlink_all_urbs() again on the same pointers.

If the interface was opened and closed earlier and is down at unplug,
ems_usb_disconnect() frees the stale pointers from the last session a
second time.

If a later ems_usb_start() breaks out of the RX loop early because an
alloc or submit fails, the slots it didn't refill still hold pointers that
the previous close already freed. The next close or disconnect frees them
again.

usb_free_coherent() only skips a NULL addr, so each stale pointer goes to
hcd_buffer_free(). Depending on the HCD, that means dma_pool_free(),
kfree() or gen_pool_free() on memory that was already freed.

This loop appears to date from commit 9969e3c5f40c ("can: ems_usb: fix
memory leak").

Could dev->rxbuf[i] be set to NULL after each free, or could the extra
unlink_all_urbs() call in ems_usb_disconnect() be dropped?

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. Does
ems_usb_start() leave URBs in flight when it fails part way through?

If usb_submit_urb(dev->intr_urb) fails, ems_usb_start() returns while the
RX URBs are still anchored on rx_submitted and in flight.

If a later ems_usb_control_cmd() or ems_usb_write_mode() call fails, it
returns with both the RX URBs and the self-resubmitting intr URB still
active:

failed:
	netdev_warn(netdev, "couldn't submit control: %d\n", err);

	return err;

On this path ems_usb_open() only calls close_candev(). ndo_stop isn't
called after a failed open, so unlink_all_urbs() never runs.

On the next open, ems_usb_start() overwrites dev->rxbuf[], so the earlier
buffers and URBs leak. usb_fill_int_urb() also rewrites the intr URB while
it is still active. usb_submit_urb() then hits:

	if (urb->hcpriv) {
		WARN_ONCE(1, "URB %p submitted while active\n", urb);
		return -EBUSY;
	}

>From then on every open fails until the device is replugged.

This doesn't reopen the disconnect use-after-free fixed here, because
ems_usb_disconnect()->unlink_all_urbs() now kills the leftover intr URB
before the frees.

Should ems_usb_start() unwind the submitted URBs on these error paths?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261015015336.816543-2-mkl%40pengutronix.de
