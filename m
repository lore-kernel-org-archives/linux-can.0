Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FC45013D6
	for <linux-can@vger.kernel.org>; Wed, 16 Sep 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566519; cv=none; b=OTkwwL7pP6VddB+yFYfTXOUeMwVi+G2vVChc+uxoIiXufFJHXuDapOC1hDNZKl9hDKX9PBzpp5j4hw9tjP7B8SRwVbVvlMeUWfD7r2oMkFpXUiOZ4Hgt7u3DEMm0uExsJwnNuWlm0HKbW9sbL4GZ7qXMd/wQPwRMLbooq9nzhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566519; c=relaxed/simple;
	bh=Yxu9HejTVX0C94JW5L+4LVsqMT8FCn0ff6cfwcGFyIA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uY+iWG6k8Tsd9d6Hqhxl9S2ZW/oDzIdzcX4cC0C2cDdrMC0i+FHh2NljvsAIQdH3cmb5IzbKgWBAfhVUKQt9bMP3+Phx7wV1qXxFvsSVjojJPfwxCQnlu+Mr76s0PW9uc+mBUjqTrFMxHMpn9QY9vhxs8NBK1468ifEqkGtPK5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPq+URrD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LPq+URrD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F031F00893;
	Wed, 16 Sep 2026 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566510;
	bh=pSVXfz/0M5VuNUVfnxMrtWeBFUw85Gcy3wIoC+5Vl9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LPq+URrDnBFXDiFlG2W0nmHm3pBfT602ZEblGgQeWLjMjUW23IHDwG0Sz/Ndhjawt
	 B/2KzXNATUcExptrecE4Y0Qf0hSguxviPISxaWKL5gkE13i5Eyd/sevd7nE5EIA7hu
	 Y1m1KflauTyNsnACXwCfY4sbTYTiJu3I2GAzamISe8Z40Ockv3gaj+YfHTK9KwNj5l
	 fRLUsKdU5qgKKYd6Pb4YwNsm+F0rfsklbepzXcQkk0D0amVvQiSt0AzJAWAmS4VjWM
	 yVg/o8PCf2KmUj9112sBkeGJ1GFoIo1m9EZO4djgY5xw+VskcnmO0S82WOU6pkkhd8
	 gU2MSXGMi+9BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] can: ixxat_usb: add driver skeleton for IXXAT
 USB-to-CAN adapters
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?U3TDqXBoYW5lIEdyb3NqZWFu?= <stephane.grosjean@free.fr>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260916-ixxat_usb_can-v2-1-9b892e362d9e@peak-system.fr>
References: <20260916-ixxat_usb_can-v2-0-9b892e362d9e@peak-system.fr>
 <20260916-ixxat_usb_can-v2-1-9b892e362d9e@peak-system.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 13:48:29 +0000
Message-Id: <20260916134829.E2F031F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] net/can: FORTIFY_SOURCE critical kernel panic from field-spann=
ing memcpy in USB command payload
- [High] net/can: kernel BUG_ON triggered by unregistering an unregistered =
CAN device
- [High] net/can: infinite loop and divide-by-zero panic from unvalidated U=
SB timestamp parameters
- [High] net/can: FORTIFY_SOURCE read overflow panic from oversized CAN-FD =
messages on CL1 adapters
- [High] net/can: permanent leakage of transmission slots and echo_skb buff=
ers on hard USB errors
- [High] net/can: out-of-bounds read indexing endpoint arrays via untrusted=
 controller count
- [Medium] net/can: memory leak of devdata and cmdbuf on probe if no CAN co=
ntrollers are found
- [Medium] net/can: driver drops the DLC length bits when transmitting CAN =
RTR frames
- [Medium] net/can: TOCTOU race condition exposing uninitialized MAC addres=
s and sysfs nodes
--

commit b6d4cd22829b6f53b45ff0c4a4fce1127ba119e7
Author: St=C3=A9phane Grosjean <s.grosjean@peak-system.fr>

    can: ixxat_usb: add driver skeleton for IXXAT USB-to-CAN adapters
   =20
    Add the initial skeleton of the ixxat_usb driver: Kconfig, Makefile
    and the USB core (probe/disconnect, CAN netdev ops, USB URB handling,
    device command channel, ethtool/sysfs glue).

> diff --git a/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c b/drivers/net=
/can/usb/ixxat_usb/ixxat_usb_core.c
> index 0000000000000..3602ff9cc2c1d
> --- /dev/null
> +++ b/drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
[ ... ]
> +static int ixxat_usb_send_cmd_internal(struct usb_device *dev,
> +				       struct ixxat_usb_device_data *devdata,
> +				       const u16 port,
> +				       struct ixxat_usb_dal_req *cmd,
> +				       u16 cmd_size,
> +				       struct ixxat_usb_dal_res *res,
> +				       u16 res_size,
> +				       const unsigned long cmd_delay)
> +{
[ ... ]
> +	/* copy request to command buffer */
> +	memcpy(req_buf, cmd, cmd_size);

[Severity: Critical]
The inner USB command transport ixxat_usb_send_cmd_internal() accepts the
outgoing command and incoming response destinations via rigidly typed param=
eters
struct ixxat_usb_dal_req *cmd and struct ixxat_usb_dal_res *res, both of wh=
ich
are strictly 12 bytes in size. Callers pass composite buffer sizes correspo=
nding
to larger aggregated structures (e.g. 24 bytes and 68 bytes), which span be=
yond
the bounds of the specific req and res structure members.

Because ixxat_usb_send_cmd_internal() is static and analyzed
inter-procedurally, does memcpy() combined with CONFIG_FORTIFY_SOURCE enfor=
ce
the tight 12-byte structural boundaries based on the pointer types, instant=
ly
causing a kernel panic on boot due to a field-spanning buffer overflow
violation?

[ ... ]
> +	/* copy response to user buffer */
> +	memcpy(res, res_buf, res_size);
[ ... ]
> +static void ixxat_usb_ts_set_cancaps(struct ixxat_time_ref *timeref,
> +				     u32 ts_clock_divisor,
> +				     u32 ts_clock_freq)
> +{
[ ... ]
> +	/* remove not significant zero bits from multiplier and divider */
> +	while (!(timeref->tick_multiplier & 0x1) &&
> +	       !(timeref->tick_divider & 0x1)) {
> +		timeref->tick_multiplier >>=3D 1;
> +		timeref->tick_divider >>=3D 1;
> +	}

[Severity: High]
The driver parses devdata->caps.ts_clock_divisor and ts_clock_freq directly
from the USB device capabilities payload without validating them for zero.

If a malicious or buggy USB device provides 0 for both fields, could this
loop run infinitely, causing a complete CPU hang? If only the frequency is =
0,
does the subsequent do_div(..., timeref->tick_divider) cause a divide-by-ze=
ro
exception?

[ ... ]
> +static void ixxat_convert(const struct ixxat_usb_adapter *adapter,
> +			  struct canfd_frame *cf,
> +			  struct ixxat_can_msg *rx,
> +			  u8 datalen)
> +{
[ ... ]
> +	if (ixx_flags & IXXAT_USB_MSG_FLAGS_RTR)
> +		cf->can_id |=3D CAN_RTR_FLAG;
> +	else if (adapter->cl1_msg_format)
> +		memcpy(cf->data, rx->cl1.data, datalen);

[Severity: High]
For CL1 adapters, the driver blindly derives datalen from the USB message
flags. If a malicious USB device sets the IXXAT_USB_FDMSG_FLAGS_EDL flag,
datalen calculates to up to 64 bytes.

The code then calls memcpy() to copy datalen bytes out of the rx->cl1.data
array. Because rx->cl1.data is statically sized at 8 bytes (CAN_MAX_DLEN),
doesn't reading up to 64 bytes via memcpy() trigger a fatal FORTIFY_SOURCE
read-overflow panic?

[ ... ]
> +static int ixxat_usb_encode_msg(struct ixxat_usb_candevice *dev,
> +				struct sk_buff *skb, u8 *obuf)
> +{
[ ... ]
> +	if (can_is_canfd_skb(skb)) {
> +		flags |=3D IXXAT_USB_FDMSG_FLAGS_EDL;
> +
> +		if (cf->flags & CANFD_BRS)
> +			flags |=3D IXXAT_USB_FDMSG_FLAGS_FDR;
> +
> +		if (cf->flags & CANFD_ESI)
> +			flags |=3D IXXAT_USB_FDMSG_FLAGS_ESI;
> +
> +		flags |=3D FIELD_PREP(IXXAT_USB_MSG_FLAGS_DLC_MASK,
> +				    can_fd_len2dlc(cf->len));
> +	} else if (cf->can_id & CAN_RTR_FLAG) {
> +		flags |=3D IXXAT_USB_MSG_FLAGS_RTR;
> +	} else {
> +		flags |=3D FIELD_PREP(IXXAT_USB_MSG_FLAGS_DLC_MASK, cf->len);
> +	}

[Severity: Medium]
When encoding a CAN message into the USB protocol buffer, the driver checks
if the message is a Remote Transmission Request (RTR). If it is, it sets the
IXXAT_USB_MSG_FLAGS_RTR flag but exclusively skips packing the original len=
gth
(cf->len) into the IXXAT_USB_MSG_FLAGS_DLC_MASK bits.

Because CAN RTR frames carry zero payload data but still require a valid Da=
ta
Length Code to signal the requested response size, does emitting a frame wi=
th
DLC=3D0 corrupt the outgoing RTR request on the bus?

[ ... ]
> +static void ixxat_usb_write_bulk_callback(struct urb *urb)
> +{
[ ... ]
> +	/* Fix sashiko-bot v1 issue:
> +	 * don't skip the cleanup block if a status error occurs
> +	 */
> +	err =3D ixxat_evaluate_usb_status(netdev, urb, dev->ep_msg_out);
> +	if (err =3D=3D -1)
> +		goto lbl_rel;

[Severity: High]
If a bulk transmit URB completes with a fatal error code (such as -EPROTO or
-ESHUTDOWN), the completion callback explicitly skips the resource cleanup =
by
jumping directly to lbl_rel.

This fails to call both can_get_echo_skb() and ixxat_usb_msg_free_idx(). The
internal bitmask of active message indices (dev->msgs) will never clear the
failed slot, and the CAN stack's echo buffer permanently locks up the SKB.

Does this cause a permanent leakage of transmission slots and echo_skb buff=
ers
on hard USB errors?

[ ... ]
> +static int ixxat_usb_create_ctrl(struct usb_interface *intf,
> +				 const struct ixxat_usb_adapter *adapter,
> +				 u16 ctrl_index,
> +				 struct ixxat_usb_device_data *devdata)
> +{
[ ... ]
> +	dev->adapter->get_ctrl_caps(dev, &devdata->caps);
> +
> +	i =3D ctrl_index + adapter->ep_offs;
> +	dev->ep_msg_in =3D adapter->ep_msg_in[i];
> +	dev->ep_msg_out =3D adapter->ep_msg_out[i];

[Severity: High]
The maximum number of controllers an IXXAT device can advertise is bounded =
by
IXXAT_USB_MAX_TYPES (32) during capability extraction. However, the static
endpoint mapping arrays ep_msg_in and ep_msg_out inside the device's adapter
definition only have IXXAT_USB_MAX_CHANNEL (5) slots.

If a malicious USB device returns a bus_ctrl_count greater than 5, does this
force the driver to read out-of-bounds memory to determine its communication
endpoints, eventually submitting broken URBs with garbage parameters?

[ ... ]
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

[Severity: Medium]
During driver probe, register_candev(netdev) is invoked immediately after
memory allocation and queue setup. Registration makes the device globally
visible to userspace, dispatching NETDEV_REGISTER uevents to udev.

However, the driver writes the hardware MAC address (dev_addr_mod) and crea=
tes
its proprietary sysfs hierarchy (sysfs_create_group) strictly after the
registration call returns.

Can a userspace network daemon triggered by the netdev birth event read
missing or garbage properties, breaking network initialization policies?

[ ... ]
> +free_candev:
> +	/* sashiko-bot v1: missing unregister_candev() */
> +	unregister_candev(netdev);

[Severity: High]
If register_candev(netdev) fails during controller initialization, the
code jumps to the free_candev error label where it blindly executes
unregister_candev(netdev).

Since unregister_candev() directly delegates to unregister_netdev(), this
violates the network core's strict state tracking. Is it safe to call it on=
 a
device that is not in the NETREG_REGISTERED state, or does it trigger an
immediate BUG_ON() kernel panic?

[ ... ]
> +static int ixxat_usb_probe(struct usb_interface *intf,
> +			   const struct usb_device_id *id)
> +{
[ ... ]
> +		if (err) {
> +			/* Deregister already created devices */
> +			ixxat_usb_disconnect(intf);
> +
> +			/* sashiko-bot v1:
> +			 * if 1st device creation failed, then shared resources
> +			 * must be released too.
> +			 */
> +			if (!ctrlidx)
> +				goto lbl_err;
> +
> +			/* Otherwise, they have been released by
> +			 * ixxat_usb_disconnect().
> +			 */
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
If the probe loop completes without finding any controllers of type
IXXAT_USB_BUSTYPE_CAN (or if ctrl_count is 0), the function successfully
returns 0. However, usb_set_intfdata() is never called for these shared
structures.

When the device is later unplugged, ixxat_usb_disconnect() fetches dev via
usb_get_intfdata(), finds it to be NULL, and returns early without freeing
devdata and cmdbuf. Returning an error directly on intermediate initializat=
ion
failures also circumvents the cleanup.

Will this leak devdata and cmdbuf on probe if no CAN controllers are found?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-ixxat_usb_=
can-v2-0-9b892e362d9e@peak-system.fr?part=3D1
