Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A142D0603
	for <linux-can@vger.kernel.org>; Thu, 23 Jul 2026 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784793312; cv=none; b=AO5Do6HGZEJmzkxr6yPdEVd7vTylBAqrGkkl56HtOcAUgvQCDo6cItv4tApaWxdMyWOzN/xDnhGs6AafXcdiMgqwUyTH9uclBixBANXoh43pVLTpOxidKSVWDJSuUgAVrxryQKeYK9opmnizv7iAt7V0SnYlvGOZxLRU9YiAEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784793312; c=relaxed/simple;
	bh=cDHrqS/Kir2lAZEbdAysFuXFecxPmUbTUJ6nHDHKbiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V27THIoQFrCJ/8tZiBawH4ze43MbfB9PbaUpb1ZLOVLFdus1ELgIffFu4z4RugZEspIQ3wpj+8YLJgLKWWnxVE7kmmgfW+hBcbdtJvhvA083H3IRzQf82iOnRqfV8hMHtE+r52hvciSOEvHRriEykB8S14mccFo/0Efv6/ZCijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT/Gvk3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT/Gvk3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFC21F000E9;
	Thu, 23 Jul 2026 07:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784793310;
	bh=TlZx96dpNSLU4g9BOX5zVy3v1IqCBt0mb4K0qRWjG5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GT/Gvk3PkSMpeW0mNI2uEINYxElHiBC1deec++6NUaPsBMWRZMLm1RUMh2AvG7mF1
	 3moSItQTWTqAXbv5Rr3WgqZNwDYPG3ntpg90njx5KvZRiiRx5x3opujcwCWQhL+KiL
	 aj3Zw9kiU0NCVzDREe54W9TGnttNb0jQiSsDZMHWFOEjbHCkgB6xFsnmKRCwsBN3xV
	 xHo74iJivAN+Cqr3JPT2/7NwEUZUUrVUqaJXkPLbG0tp//wRL9+HE75m9YEMMJjzFU
	 575eu8zfJ5P5Wa0lW9Cyo8EDQHH5SYoOzwPQa7bT4BQATchbZ9vJe2KAFBZQYNAAvs
	 i7v/i4VeuTQuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] can: usb: ixxat_usb: add core driver and
 Kconfig/Makefile
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260723072955.32575-5-stephane.grosjean@free.fr>
References: <20260723072955.32575-1-stephane.grosjean@free.fr>
 <20260723072955.32575-5-stephane.grosjean@free.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 07:55:09 +0000
Message-Id: <20260723075509.AFFC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [Critical] ixxat_usb_start_xmit returns a negative error code upon URB su=
bmission failure, causing a double-free of the SKB.
- [Critical] Missing unregister_candev() in the error path of ixxat_usb_cre=
ate_ctrl() causes a freed network device to remain registered.
- [High] TX URBs and their transfer buffers are permanently leaked across i=
nterface toggles and on device disconnect.
- [High] Transient USB bus errors or memory allocation failures permanently=
 halt the TX and RX paths.
- [High] Out-of-bounds read in ixxat_usb_decode_buf when parsing USB packet=
s due to reversed validation logic.
- [High] The command buffer used for USB control messages is undersized for=
 the request-response cycle of certain commands, leading to a heap buffer o=
verflow.
- [High] Missing netif_stop_queue() in ixxat_usb_start_xmit causes a CPU sp=
in when TX resources are exhausted.
- [Medium] The devdata and cmdbuf structures are leaked during USB probe if=
 no CAN endpoints are found or if the first controller fails to initialize.
- [Medium] Missing state change check in ixxat_usb_handle_status may flood =
userspace with redundant error frames.
- [Medium] Uninitialized kernel stack memory is leaked to the USB device du=
ring CAN message transmission.
- [Medium] Unaligned memory access when casting packed byte arrays to __le3=
2 pointer.
--

--- Patch [4]: [PATCH 4/4] can: usb: ixxat_usb: add core driver and Kconfig=
/Makefile ---
commit 8336d17fb638f567613895aa76d6c98b3f55faa7
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>
Subject: can: usb: ixxat_usb: add core driver and Kconfig/Makefile

This commit adds the main USB driver entry point for the IXXAT USB-to-CAN=20
adapter family. It implements device matching, protocol selection, per-chan=
nel=20
net_device allocation, URB management, and TX/RX data paths.

> --- /dev/null
> +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
> @@ -0,0 +1,2567 @@
[ ... ]
> +static int ixxat_usb_send_cmd_internal(struct usb_device *dev,
> +				       struct ixxat_usb_device_data *devdata,
> +				       const u16 port, void *req,
> +				       const u16 req_size, void *res,
> +				       const u16 res_size,
> +				       const unsigned long cmd_delay)
> +{
> +	struct ixxat_usb_dal_req *dal_req =3D req;
> +	struct ixxat_usb_dal_res *dal_res =3D res;
> +	u8 *req_buf =3D (u8 *)devdata->cmdbuf;
> +	u8 *res_buf =3D (u8 *)devdata->cmdbuf + req_size;

[Severity: High]
Does this offset calculation overflow the allocation for the command buffer?

The cmdbuf is allocated to the size of union ixxat_usb_cmd. The response
buffer is offset by req_size, and the driver reads res_size bytes into it.

Since req_size includes both sizeof(cmd.req) and sizeof(cmd.res), and
res_size is sizeof(cmd) - sizeof(cmd.req), the total span accessed reaches
sizeof(cmd) + sizeof(cmd.res), overrunning the union allocation by 12 bytes.

[ ... ]
> +static void ixxat_usb_free_usb_communication(struct ixxat_usb_candevice =
*dev)
> +{
> +	struct net_device *netdev =3D dev->netdev;
> +	u32 skb_idx, urb_idx;
> +
> +	netif_stop_queue(netdev);
> +	usb_kill_anchored_urbs(&dev->rx_anchor);
> +	usb_kill_anchored_urbs(&dev->tx_anchor);
> +	atomic_set(&dev->active_tx_urbs, 0);
> +
> +	/* reset msg idx store */
> +	ixxat_usb_msg_free_idx(dev, 0xFFFFFFFF);
> +
> +	for (skb_idx =3D 0; skb_idx < dev->can.echo_skb_max; skb_idx++)
> +		can_free_echo_skb(netdev, skb_idx, NULL);
> +
> +	for (urb_idx =3D 0; urb_idx < IXXAT_USB_MAX_TX_URBS; urb_idx++)
> +		dev->tx_contexts[urb_idx].urb_index =3D IXXAT_USB_FREE_ENTRY;
> +}

[Severity: High]
Does this leak the URBs and transfer buffers allocated for transmission?

In ixxat_usb_setup_tx_urbs, the driver dynamically allocates URBs and
transfer buffers for TX. When stopping the interface here, the URBs are
never freed via usb_free_urb.=20

If the interface is brought down and back up, the setup function will blind=
ly
allocate new URBs and overwrite the pointers, permanently leaking the previ=
ous
allocations.

[ ... ]
> +static int ixxat_usb_handle_status(struct ixxat_usb_candevice *dev,
> +				   struct ixxat_can_msg *rx)
> +{
> +	struct net_device *netdev =3D dev->netdev;
> +	struct can_frame *can_frame;
> +	struct sk_buff *skb;
> +	enum can_state new_state =3D CAN_STATE_ERROR_ACTIVE;
> +	u32 raw_status;
> +	u8 min_size =3D sizeof(rx->base) + sizeof(raw_status);
> +
> +	if (dev->adapter =3D=3D &usb2can_cl1)
> +		min_size +=3D sizeof(rx->cl1) - sizeof(rx->cl1.data);
> +	else
> +		min_size +=3D sizeof(rx->cl2) - sizeof(rx->cl2.data);
> +
> +	if (rx->base.size < (min_size - 1)) {
> +		netdev_err(netdev, "Error: CAN Invalid status message size\n");
> +		return -EBADMSG;
> +	}
> +
> +	raw_status =3D (dev->adapter =3D=3D &usb2can_cl1) ?
> +		le32_to_cpup((__le32 *)rx->cl1.data) :
> +		le32_to_cpup((__le32 *)rx->cl2.data);

[Severity: Medium]
Can this pointer cast trigger unaligned memory accesses?

Casting a u8 array embedded inside a __packed structure directly to a
__le32 pointer discards the packed attribute. This allows the compiler to
generate an aligned 32-bit load instruction, which may trap or panic on
architectures that enforce strict alignment if the payload offset is unalig=
ned.

[ ... ]
> +	if (new_state =3D=3D CAN_STATE_ERROR_ACTIVE) {
> +		dev->bec.txerr =3D 0;
> +		dev->bec.rxerr =3D 0;
> +	}
> +
> +	if (new_state !=3D CAN_STATE_MAX)
> +		dev->can.state =3D new_state;
> +
> +	skb =3D alloc_can_err_skb(netdev, &can_frame);

[Severity: Medium]
Is it intended to allocate and emit an error frame on every status update
even if the hardware state has not changed?

This logic bypasses the standard can_change_state checks and will emit a
stream of CAN_ERR_CRTL active error frames into userspace on every periodic
status message from the controller if the state remains active.

[ ... ]
> +static int ixxat_usb_decode_buf(struct urb *urb)
> +{
> +	struct ixxat_usb_candevice *dev =3D urb->context;
> +	struct net_device *netdev =3D dev->netdev;
> +	int err =3D 0;
> +	u8 *data =3D urb->transfer_buffer;
> +	u32 len =3D urb->actual_length, pos, size;
> +	u64 time;
> +
> +	for (pos =3D 0; pos < len; pos +=3D size) {
> +		struct ixxat_can_msg can_msg;
> +		u32 type;
> +
> +		/* Since struct ixxat_can_msg is packed and starts with a byte,
> +		 * we have no choice but to copy the whole message into a local
> +		 * variable to avoid bus violation.
> +		 */
> +		size =3D data[pos] + 1;
> +		if (size > sizeof(can_msg) ||
> +		    size < sizeof(struct ixxat_can_msg_base)) {
> +			netdev_err(netdev, "Error: USB Invalid msg size %u\n",
> +				   size);
> +			return -EBADMSG;
> +		}
> +
> +		memcpy(&can_msg, data + pos, size);
> +		if (!can_msg.base.size) {
> +			netdev_err(netdev, "Error: USB Unsupported msg size\n");
> +			return -EOPNOTSUPP;
> +		}
> +
> +		size =3D can_msg.base.size + 1;
> +		if (size < sizeof(can_msg.base) || (pos + size) > len) {

[Severity: High]
Could this memcpy result in an out-of-bounds heap read?

The code copies 'size' bytes (calculated from the untrusted data buffer)
into the can_msg stack variable before verifying if pos + size > len. A
truncated or malformed USB payload can cause the memcpy to read past the end
of the URB transfer buffer.

[ ... ]
> +static int ixxat_usb_encode_msg(struct ixxat_usb_candevice *dev,
> +				struct sk_buff *skb, u8 *obuf)
> +{
> +	int size;
> +	struct canfd_frame *cf =3D (struct canfd_frame *)skb->data;
> +	struct ixxat_can_msg can_msg;

[Severity: Medium]
Does this expose uninitialized kernel stack memory to the USB device?

The can_msg struct is allocated on the stack without zero-initialization.
Not all members and padding bytes are explicitly written before the entire
relevant length of the structure is copied into obuf and sent over the USB =
bus,
potentially leaking stale kernel stack bytes.

[ ... ]
> +static void ixxat_usb_read_bulk_callback(struct urb *urb)
> +{
> +	struct ixxat_usb_candevice *dev =3D urb->context;
> +	struct net_device *netdev;
> +	int err;
> +
> +	if (WARN_ON_ONCE(!dev))
> +		return;
> +
> +	netdev =3D dev->netdev;
> +
> +	err =3D ixxat_evaluate_usb_status(netdev, urb, dev->ep_msg_in);
> +	switch (err) {
> +	case 0:
> +		if (urb->actual_length > 0 &&
> +		    dev->state & IXXAT_USB_STATE_STARTED) {
> +			err =3D ixxat_usb_decode_buf(urb);
> +			if (err)
> +				return;

[Severity: High]
Will an error from ixxat_usb_decode_buf permanently halt the RX path?

Returning early on a decoding error or memory allocation failure entirely s=
kips
the usb_submit_urb block at the end of the callback. This leaves the endpoi=
nt
un-armed and permanently wedges the receive path until the device is restar=
ted.

[ ... ]
> +static void ixxat_usb_write_bulk_callback(struct urb *urb)
> +{
> +	struct ixxat_tx_urb_context *context =3D urb->context;
> +	struct ixxat_usb_candevice *dev;
> +	struct net_device *netdev;
> +	int echo_bytes;
> +	u32 msg_idx;
> +	int err;
> +
> +	if (WARN_ON_ONCE(!context))
> +		return;
> +
> +	dev =3D context->dev;
> +	netdev =3D dev->netdev;
> +
> +	err =3D ixxat_evaluate_usb_status(netdev, urb, dev->ep_msg_out);
> +	if (err =3D=3D -1)
> +		return;

[Severity: High]
Does this early return permanently leak the TX context on failure?

If a status error occurs, returning early skips the cleanup block that frees
the message index and decrements active_tx_urbs. This permanently wedges
the transmission path once all contexts are exhausted by transient USB erro=
rs.

[ ... ]
> +static netdev_tx_t ixxat_usb_start_xmit(struct sk_buff *skb,
> +					struct net_device *netdev)
> +{
> +	int err, size;
> +	struct ixxat_usb_candevice *dev =3D netdev_priv(netdev);
> +	struct ixxat_tx_urb_context *context;
> +	struct net_device_stats *stats =3D &netdev->stats;
> +	struct urb *urb;
> +	u8 *obuf;
> +	u32 msg_idx;
> +
> +	if (can_dev_dropped_skb(netdev, skb))
> +		return NETDEV_TX_OK;
> +
> +	/* find free URB */
> +	context =3D ixxat_usb_get_tx_context(dev);
> +	if (!context)
> +		return NETDEV_TX_BUSY;

[Severity: High]
Does this omit pausing the transmission queue when TX resources are empty?

Returning NETDEV_TX_BUSY without first calling netif_stop_queue causes the
kernel's queueing discipline to immediately retry transmitting the exact sa=
me
packet. This creates an infinite spin loop that consumes 100% of the CPU in
softirq context until an active TX URB completes.

[ ... ]
> +	err =3D usb_submit_urb(urb, GFP_ATOMIC);
> +	if (err) {
> +		/* submit failed. Should only free if it's exist */
> +		can_free_echo_skb(netdev, msg_idx, NULL);
> +		ixxat_usb_msg_free_idx(dev, msg_idx);
> +		ixxat_usb_rel_tx_context(dev, context);
> +
> +		usb_unanchor_urb(urb);
> +		atomic_dec(&dev->active_tx_urbs);
> +
> +		if (err =3D=3D -ENODEV) {
> +			netif_device_detach(netdev);
> +		} else {
> +			stats->tx_dropped++;
> +			netdev_err(netdev, "Submitting tx-urb failed err %d\n",
> +				   err);
> +		}
> +	} else {
> +		/* update trans_start */
> +		netif_trans_update(netdev);
> +	}
> +
> +	return err;

[Severity: Critical]
Is this returning a negative error code instead of a valid netdev_tx_t?

When usb_submit_urb fails, the driver explicitly frees the SKB via
can_free_echo_skb but then propagates the negative error code (such as
-ENOMEM).

The ndo_start_xmit API expects a netdev_tx_t constant like NETDEV_TX_OK.
Returning a negative value causes the network core's dev_hard_start_xmit to
hit the default case and call kfree_skb on the already-freed SKB, triggering
a double-free.

[ ... ]
> +static int ixxat_usb_create_ctrl(struct usb_interface *intf,
> +				 const struct ixxat_usb_adapter *adapter,
> +				 u16 ctrl_index,
> +				 struct ixxat_usb_device_data *devdata)
> +{
[ ... ]
> +	SET_NETDEV_DEV(netdev, &intf->dev);
> +	err =3D register_candev(netdev);
> +	if (err) {
> +		dev_err(&intf->dev, "Error %d: Failed to register can device\n",
> +			err);
> +		goto free_candev;
> +	}
> +
> +	netdev->addr_len =3D sizeof(devdata->dev_info.device_id);
> +	dev_addr_mod(netdev, 0, devdata->dev_info.device_id,
> +		     sizeof(devdata->dev_info.device_id));
> +
> +	err =3D sysfs_create_group(&netdev->dev.kobj, &ixxat_pdev_group);
> +	if (err < 0) {
> +		netdev_err(netdev, "Error: %d: sysfs group failed\n", err);
> +		goto free_candev;
> +	}
> +
> +	netdev_info(netdev, "%.*s: Connected channel %u (device %.*s)\n",
> +		    (int)sizeof(devdata->dev_info.device_name),
> +		    devdata->dev_info.device_name, ctrl_index,
> +		    (int)sizeof(devdata->dev_info.device_id),
> +		    devdata->dev_info.device_id);
> +
> +	return err;
> +
> +free_candev:
> +	sysfs_remove_group(&netdev->dev.kobj, &ixxat_pdev_group);
> +	usb_set_intfdata(intf, dev->prev_dev);
> +	free_candev(netdev);
> +
> +	return err;
> +}

[Severity: Critical]
Does this error path fail to unregister the network device before freeing i=
t?

The network device is registered to the core network stack earlier in this
function via register_candev. If sysfs_create_group subsequently fails, the
code jumps to the free_candev label and releases the memory, but misses a c=
all
to unregister_candev(netdev). This leaves the core network stack with a
dangling pointer, leading to a use-after-free.

[ ... ]
> +static int ixxat_usb_probe(struct usb_interface *intf,
> +			   const struct usb_device_id *id)
> +{
[ ... ]
> +	ctrl_count =3D le16_to_cpu(dev_caps.bus_ctrl_count);
> +	for (ctrlidx =3D 0; ctrlidx < ctrl_count; ctrlidx++) {
> +		u16 dev_bustype =3D le16_to_cpu(dev_caps.bus_ctrl_types[ctrlidx]);
> +		u8 bustype =3D IXXAT_USB_BUS_TYPE(dev_bustype);
> +
> +		if (bustype !=3D IXXAT_USB_BUS_CAN)
> +			continue;
> +
> +		err =3D ixxat_usb_create_ctrl(intf, adapter, ctrlidx,
> +					    devdata);
> +		if (err) {
> +			/* deregister already created devices, free devdata
> +			 * and return immediately
> +			 */
> +			ixxat_usb_disconnect(intf);
> +			return err;
> +		}
> +	}
> +
> +	return 0;
> +
> +lbl_err:
> +	kfree(cmdbuf);
> +	kfree(devdata);
> +	return err;
> +}

[Severity: Medium]
Will this early return leak the devdata and cmdbuf allocations?

If ixxat_usb_create_ctrl fails for the very first controller, it sets intfd=
ata
back to NULL. Calling ixxat_usb_disconnect then returns early because
usb_get_intfdata is NULL, which skips the kfree(devdata) and
kfree(devdata->cmdbuf) cleanup. The probe function returns the error direct=
ly
without falling through to the lbl_err cleanup block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723072955.3257=
5-1-stephane.grosjean@free.fr?part=3D4
