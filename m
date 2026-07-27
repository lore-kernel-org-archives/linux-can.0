Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A423F410F
	for <linux-can@vger.kernel.org>; Mon, 27 Jul 2026 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146892; cv=none; b=jMegZ+DxGxDO0AAY6I3k/3W9vCkx5FcSuphHaFtie/NujKalBjDg3EJbQJREfPSOOziB8/17N8OAq+s3XHp/08X63zJvG/hB+RKhkbLhBCf4Nx3Wxnk4xwY4ann9ol1gRPyl97LEjT+FoJTAw3HFZWzwGlEketclErPNu0D5fFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146892; c=relaxed/simple;
	bh=/42WKb/E6aSyUsMgkc9IZIghlYSO6Lui8JoQpm4jFww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cGyCdT1Y8Wh3oSnJ6HzwwsT/xg3z0kMKDv/NN2vuSH6MUx+hCgT2ybDam6uyiOedJpGQ8g0jsnh7+zdA5LRFQejRGerliNUoW83WMwFZscHUDqhqL5nA3C1Xr9wvDKVwgLTuuXtSri+ty/rxkeK0ANi1gfO2ihiB0sZMYuQU0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiU3fn3X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiU3fn3X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6F91F000E9;
	Mon, 27 Jul 2026 10:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785146891;
	bh=G/KpUxzYsLXTuHdPqJbNtYQgPSMD345cyKIp/dLHq68=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TiU3fn3XrHh0Qub5DV0/31A4jKbctB04XDm8rwyuUqSD+pkXHi9Fb0w5/RpzjJ/D1
	 gonR2Q9fChHD1PjWCbdcgntkA53A0HYvNlpHl8yaJY352z8dZLBeLGhaTNIzmJRFbM
	 I+5XYXBr1+8ORKO+tO9If2UM15iZN37/SdxD8b93JCyXOW2OmwX7WNst2JFAg9Jbpo
	 4ZUJVaE22p3dfWUdnMuKTFF8O+ur9dNsZUwvPdHFfYjsPAmIsFla+5PeBig0cWJ1Yp
	 oNt762mPcWX7k67w6KOTKZb00pUCXqigR8/WRq39U0MbFukLtASIxQtGeBZ6dhZEAJ
	 MIgSoJDXV9J4A==
Message-ID: <9a8bb69e-7653-4ea1-b67d-f7cbd83a4cd2@kernel.org>
Date: Mon, 27 Jul 2026 12:08:08 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] can: usb: Add driver for HMS IXXAT USB-to-CAN
 adapters
To: =?UTF-8?Q?St=C3=A9phane_Grosjean?= <stephane.grosjean@free.fr>,
 =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
References: <20260723072955.32575-1-stephane.grosjean@free.fr>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20260723072955.32575-1-stephane.grosjean@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bonjour Stéphane,

On 23/07/2026 ac 09:29, Stéphane Grosjean wrote:
> From: Stéphane Grosjean <s.grosjean@peak-system.fr>

Could you put the maintainers in Cc? Use either

  ./scripts/get_maintainer.pl

or switch to the more modern b4 tool which will handle all this
automatically for you.

  https://b4.docs.kernel.org/en/latest/

I am asking because I do not put the same focus on e-mails sent to the
mailing list as I do for e-mails sent directly to me.

> This series adds a SocketCAN driver for the HMS Networks IXXAT family of
> USB-to-CAN and USB-to-CAN FD interface adapters.
> 
> The driver supports two USB communication layers:
> - CL1: the protocol for classic CAN 2.0b devices with legacy firmware
> - CL2: the newer protocol used by recent device firmware versions
> 
> Supported devices (VID 0x08d8 and 0x08db):
>   USB-to-CAN Compact / Embedded / Professional / Automotive / Plugin (CL1)
>   USB-to-CAN FD Compact / Professional / Automotive / MiniPCIe       (CL2)
>   USB-to-CAN/FD Pro / Standard / Standard Card / Pro Module /
>                       Standard Module                                (CL2)
>   USB-to-CAR, CAN-IDM101, CAN-IDM200                                 (CL2)
> 
> Supported CAN control modes (device-dependent):
>   listen-only, loopback, triple-sampling, bus-error reporting,
>   CAN FD (ISO 11898-1:2015), non-ISO CAN FD, one-shot
> 
> Additional features:
>   - Hardware receive timestamps propagated via skb_hwtstamps
>   - Bus error counter (do_get_berr_counter)
>   - TX echo via the SocketCAN echo skb mechanism (up to 32 in flight)
>   - Up to 5 independent CAN channels per physical device
>   - Automatic protocol layer selection based on firmware version
> 
> Signed-off-by: Stéphane Grosjean <s.grosjean@peak-system.fr>
> 
> Stéphane Grosjean (4):
>   can: usb: ixxat_usb: add shared header
>   can: usb: ixxat_usb: add CL1 legacy protocol layer
>   can: usb: ixxat_usb: add CL2/V2 protocol layer with CAN
>   can: usb: ixxat_usb: add core driver and Kconfig/Makefile

I think that the series is upside-down. We should be able to compile
each individual patch.

You should start by adding relevant core portion of the header and the
core driver but with an empty

  struct usb_device_id

table. And then add the different protocols while updating the core and
the header accordingly of the new needs.

>  drivers/net/can/usb/Kconfig                   |   17 +
>  drivers/net/can/usb/Makefile                  |    1 +
>  drivers/net/can/usb/ixxat_usb/Makefile        |    3 +
>  drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c |  188 ++
>  drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c |  347 +++
>  .../net/can/usb/ixxat_usb/ixxat_usb_core.c    | 2567 +++++++++++++++++
>  .../net/can/usb/ixxat_usb/ixxat_usb_core.h    |  862 ++++++
>  7 files changed, 3985 insertions(+)
>  create mode 100644 drivers/net/can/usb/ixxat_usb/Makefile
>  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl1.c
>  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_cl2.c
>  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.c
>  create mode 100644 drivers/net/can/usb/ixxat_usb/ixxat_usb_core.h

A few other global comments:

  - You are doing a lot of open coded mask manipulations. For example:
    IXXAT_USB_GET_BUSTYPE() or IXXAT_USB_DECODE_DLC(). Please define a
    mask with GENMASK() (or one of its GENMASK_U*() variants) and use
    FIELD_GET() and FIELD_PREP to get and set the values.

  - When you initialize a static const struct, directly put the literal
    value. It doesn't improve the readability to have an intermediate
    macro. For example do:

	static const struct can_bittiming_const usb2can_bt = {
		.name = KBUILD_MODNAME,
		.tseg1_min = 1,
		.tseg1_max = 16,
		.tseg2_min = 1,
		.tseg2_max = 8,
		.sjw_max = 4,
		.brp_min = 1,
		.brp_max = 64,
		.brp_inc = 1,
	};

    instead of:

	static const struct can_bittiming_const usb2can_bt = {
		.name = KBUILD_MODNAME,
		.tseg1_min = IXXAT_USB2CAN_TSEG1_MIN,
		.tseg1_max = IXXAT_USB2CAN_TSEG1_MAX,
		.tseg2_min = IXXAT_USB2CAN_TSEG2_MIN,
		.tseg2_max = IXXAT_USB2CAN_TSEG2_MAX,
		.sjw_max = IXXAT_USB2CAN_SJW_MAX,
		.brp_min = IXXAT_USB2CAN_BRP_MIN,
		.brp_max = IXXAT_USB2CAN_BRP_MAX,
		.brp_inc = IXXAT_USB2CAN_BRP_INC,
	};



Yours sincerely,
Vincent Mailhol

