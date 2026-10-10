Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6F436D9EB;
	Sat, 10 Oct 2026 14:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640986; cv=none; b=JYTF59Wanp77Nv/eoQAgt2fvlFxCQh+lb8JOuIO9QiDpUFzRTgjcUbCI4KKZzwTFJPWHPhlXmqAGV9eyJI9rPkEtXkUtFwpQ4xQBXuEJqomqicFHRr8Fgsale6OGlP3YWigcIPFv02sZKb9MJg0xAU4L9+0C5LM7hRDOCyidDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640986; c=relaxed/simple;
	bh=9NYeoj/VUM2RFRvKLxouzg3Rsbc1alifBq0VywImzUk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Wb/oRZXvRUAV7Hgeh6rmdF7FcEqlbt7Za/EzjOU3giozbcAkQcQYZk60ic907AS0d4UIgnaxzVugpinof/JObfzRukNL8Vd58XK+9E6bq5/SrHyy+MxxxcuX/BRrORaDrrg33utT4OzVFwYtBeuEb7RilAiK0CGXT10tsXtESdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFYq2GZS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFYq2GZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BCC1F000FF;
	Sat, 10 Oct 2026 14:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640983;
	bh=qBs4WnAOylssgtZKuuyHx3yrX7VTWaoT7B1A+97VVrc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QFYq2GZSRKW1gtKciPkgnbHICV9bjR57aHLJLSKVKwrp0zido3SUfRgQ7taUkcENq
	 ClomDt0RrFManeQ92lcNK1tHSwzJ2toFjHt+SIXJtQWfLwZda8KDKsXkpYUMg26zSX
	 vM+LGw2JhIZAoZhIYrBS9RSMWdv7ZMGSMP0m0DwNiBQRLCob+zxAfuB/hA4/eMTri5
	 nApXW0w5xzLMjQ9fgBW7qikBaB19O2omnhV4VjY7HcKVNnSW4kGzCu2P5C0kx3fF55
	 DLZZ0bX7ES9dbWpnL9Xz+5gvG08OSMWaMuffhkASuVGaXoYS1FkJ5fRIOqCHF0Uh3R
	 A6AoN7vdfeuPg==
Subject: Re: [PATCH net-next 26/37] can: ems_usb: use usb_kill_urb() to stop
 the intr URB
From: netdev-bot+sashiko@kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de, hemanth.selam@gmail.com
Date: Sat, 10 Oct 2026 14:03:02 +0000
Message-ID: <179164098298.434549.8955529744448846100@kernel.org>
In-Reply-To: <20261009134323.64064-27-mkl@pengutronix.de>
References: <20261009134323.64064-27-mkl@pengutronix.de>
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

- [Low] The commit message describes the disconnect race and leaves out
  the more easily reached ifdown/reopen failure that this change also…

Pre-existing issues:
- [Critical] Double free of the DMA-coherent RX buffers in
  drivers/net/can/usb/ems_usb.c.
- [Medium] ems_usb_start() returns errors after URBs are already in
  flight and does not stop them, and ems_usb_open() does not clean up…

--

can: ems_usb: use usb_kill_urb() to stop the intr URB

This commit replaces usb_unlink_urb() with usb_kill_urb() for the
interrupt URB in unlink_all_urbs(). Teardown now waits for
ems_usb_read_interrupt_callback() to return before ems_usb_disconnect()
frees intr_in_buffer and the candev.

Link: https://patch.msgid.link/20260923030522.409344-1-fanwu01@zju.edu.cn

> The handler can therefore still be running while ems_usb_disconnect()
> frees its data: it reads the transfer buffer dev->intr_in_buffer, which
> is kfree()d there, and dereferences the private context, which is
> released via free_candev() together with the network device.

[Severity: Low]
This disconnect window does exist, but it is fairly narrow.
ems_usb_driver does not set soft_unbind, so usb_unbind_interface() does
this before calling ->disconnect:

drivers/usb/core/driver.c:usb_unbind_interface() {
    ...
	if (!driver->soft_unbind || udev->state == USB_STATE_NOTATTACHED)
		usb_disable_interface(udev, intf, false);

	driver->disconnect(intf);
    ...
}

usb_disable_interface() reaches usb_hcd_flush_endpoint(), which kills
the URBs still queued on the endpoint. The only case left is a URB that
the HCD has already dequeued but whose BH giveback has not run yet.

The ifdown path seems easier to hit. In ems_usb_close(), the old
usb_unlink_urb() call did not raise urb->reject. So if the intr URB
completed with status 0 at that moment, the handler resubmitted it:

ems_usb_read_interrupt_callback() {
    ...
	case 0:
		dev->free_slots = dev->intr_in_buffer[1];
    ...
	err = usb_submit_urb(urb, GFP_ATOMIC);
    ...
}

The URB then kept polling after ifdown. The next ems_usb_open() failed
with -EBUSY, and usb_submit_urb() printed the "URB submitted while
active" WARN. This patch fixes that case too.

Should the commit message mention it, since stable backporters may use
it to judge impact?

> The handler treats the -ENOENT completion of a killed URB as terminal and
> does not take RTNL or any sleeping lock, so the resubmit loop is cut and
> no RTNL deadlock occurs.

If the URB completes with status 0 just as it is being killed, the
handler does not see -ENOENT. In that case the loop is stopped by
urb->reject in usb_kill_urb(): the resubmit fails and "failed
resubmitting intr urb" is logged. Could the wording reflect both cases?

> diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
> index 24cf8f651f8f1..2d31f0b86859c 100644
> --- a/drivers/net/can/usb/ems_usb.c
> +++ b/drivers/net/can/usb/ems_usb.c
> @@ -748,7 +748,7 @@ static void unlink_all_urbs(struct ems_usb *dev)
>  {
>  	int i;
>  
> -	usb_unlink_urb(dev->intr_urb);
> +	usb_kill_urb(dev->intr_urb);
>  
>  	usb_kill_anchored_urbs(&dev->rx_submitted);
>  

[Severity: Critical]
This is a pre-existing issue and was not introduced by this patch. It is
in the same function and on the same disconnect path, though. Can the
RX coherent buffers be freed twice here?

The loop right after this frees each buffer but never clears the saved
pointers:

	for (i = 0; i < MAX_RX_URBS; ++i)
		usb_free_coherent(dev->udev, RX_BUFFER_SIZE,
				  dev->rxbuf[i], dev->rxbuf_dma[i]);

If the interface has been opened at least once, the first free happens
in ems_usb_close(). That runs on a normal ifdown, or from
unregister_netdev() when the device is unplugged while up.
ems_usb_disconnect() then calls unlink_all_urbs() again:

ems_usb_disconnect()
    unregister_netdev(dev->netdev);   -> ems_usb_close()->unlink_all_urbs()
    unlink_all_urbs(dev);             -> usb_free_coherent() on same rxbuf[]

hcd_buffer_free() only skips NULL addresses. So the stale pointers go on
to dma_pool_free(), kfree() or gen_pool_free() a second time.

A similar case: after an open/close cycle, a later ems_usb_start() can
leave its RX loop early on an alloc or submit failure. The remaining
rxbuf[] slots then still point at buffers that were already freed.

The free loop came from commit 9969e3c5f40c ("can: ems_usb:
ems_usb_start(): fix possible memory leak"). Would setting
dev->rxbuf[i] = NULL after the free fix this? Another option would be to
avoid the second unlink_all_urbs() call in ems_usb_disconnect().

[Severity: Medium]
This is also pre-existing and was not introduced by this patch. Can
ems_usb_start() return an error while URBs are still in flight?

If the intr URB submit fails, the function returns with the RX URBs
still anchored on dev->rx_submitted and running:

	err = usb_submit_urb(dev->intr_urb, GFP_KERNEL);
	if (err) {
		netdev_warn(netdev, "intr URB submit failed: %d\n", err);

		return err;
	}

If a later ems_usb_control_cmd() or ems_usb_write_mode() fails, the
failed label only prints a warning and returns. The intr URB and the RX
URBs keep running.

ems_usb_open() handles this with only close_candev(). ndo_stop is not
called after a failed ndo_open, so unlink_all_urbs() never runs. Both
completion handlers keep resubmitting while the interface is down.

On the next open, usb_submit_urb() on the still-active intr_urb hits:

	if (urb->hcpriv) {
		WARN_ONCE(1, "URB %p submitted while active\n", urb);
		return -EBUSY;
	}

The open keeps failing until the device is replugged.

Each retry also overwrites dev->rxbuf[] and dev->rxbuf_dma[]. That leaks
the coherent buffers from the earlier attempt: disconnect kills their
URBs through the anchor but never frees the buffers.

With this patch, disconnect at least kills the leftover intr URB
synchronously.

Should the ems_usb_start() error paths kill the intr URB and the
anchored RX URBs before returning?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009134323.64064-2-mkl%40pengutronix.de
