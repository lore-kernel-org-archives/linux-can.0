Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAE73DB333;
	Wed,  5 Aug 2026 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785911354; cv=pass; b=ivh133Me1cXWSJORros7OCYt+pYW3qtk7DcUP+p4lr3VDaFXggk0IJSda3NNDWRtgwtDs7tlo8dTzMBFDjaZKWxIULQ3YA3m3WX6bLVR0QduPKvEpoI8rPD/H69yVH6Mx/HDO2k717mZhsHMStIWGD51UbZHtjOCc/SJspdh0uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785911354; c=relaxed/simple;
	bh=i+zDhQwA8aAMnkuZxMcN8brLmH1Qhl9BLYEOTJObYXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXrX5QX+i9zdqsi5Q/9lBU49qxU89UFpypxXLjQ8bm7FmiMINIAfXbE866P0ER0ZYaivuS6SaX8qBjN/Hp2bA8MC1IENyJko5kE1k1s47ty2MR2bR/T36UonnlyKntnlVYNJvRqWZQG8LprfHTvfXYjqkHGrQAcWuecbkdifa3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=erWoh07O; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=d2Kdf/my; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="erWoh07O";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="d2Kdf/my"
ARC-Seal: i=1; a=rsa-sha256; t=1785911344; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=V8Z31XIakTMwe9gRp/N512vkuGoLj6j/N5bGg1sOgpoEt8Po/esAK91hO/XjT4E178
    H7t4br4AKhXeCVPkU6MNjzQF1GT/UWZLEjQQ0aPF8/mdKDSoWrFqeQywdqYrg3rn+eDQ
    Ebt7A8M2Ur8FPdbq7vDvftSA7bg8oKw8TaFseZbgVFg7WpqjxpbtOV/1MgFdNZiduj4R
    NrscuCkDHvLwt4ECm2T1Kul+vLgaVdvDBbL3XT62GiiFbKj+FqkI/5yEhNdV9dKWNzyc
    Jrf3/6x8idaGiEC2gpbYodMOnMTcxpUKw1uFcIhCZwF7Vj2IZcmAC0aMIczqg1NrkW6i
    JX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785911344;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=txMKWtDmH4idU6FWMakg1pkj6yFJPfmI6+Wf54umNUg=;
    b=swo3huioZUaW+f3vswf5fbAJM8pkt7KeB79XiJ3YhAvbtk3adORhKxxO63TVF7ovqz
    LTdpxj9YDe6q1NgkA21FC500JY0HBPkuJmZIR0mo65PYqWiaofWn7AALOVEFzuHas1wj
    izuEYOGyrwTWchZsauCIEuWw17eE15elvFU+ySi/eFEhkkZDWYqzBB1guB8/B1NtAKOy
    sRQZ9ctO138iOmIxrJHUsvpe6OVMu782qT6R2UEVRbfb/uG8phsoW50cvJg0mLQVAjSG
    X0BLB+zBBL26orxhxVcW0jxWAnIyrOMogouijGO1qWKN8HGAtsup542qqabiDd/rtfZ7
    KRFw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785911344;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=txMKWtDmH4idU6FWMakg1pkj6yFJPfmI6+Wf54umNUg=;
    b=erWoh07OaTotS0GQeWC5HnPRDDDSWfOJZNc3ynijEvWZNKM1Pk3UOcMK3LX0ehXTTR
    WOngwKgdyYtNOKVnUj2t3MAmO7H5RXKN/VzDe0LEfZYg416y4NIMpj6+y/6K/V4ZeoC2
    DPp1KtpLECUxZ4A9q8ihoKMAjmqUq1RYCIV6VKVBfGcJsl8NDIq0hqI0TjhfcwaLWEBd
    E1IA+Rg+rwvT/+6JTABh0TqumcKb107+7TFaMJjb8aVP5qJ7/HBhBN8Foe5/A+beYxKU
    y+q0Je0nZERfglYp+pAxU81TOJSi+UerQ0pIQ8t8BAExsipJKjNIcDi4MlnvtFHDR9jg
    5Xag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785911344;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=txMKWtDmH4idU6FWMakg1pkj6yFJPfmI6+Wf54umNUg=;
    b=d2Kdf/myO14mec0QrWMKa0EOEadN3e9wonY18gwXnMazr+5zgyCbd5pAQHHGT24/0i
    kYVoPc/oIGmyNi3QsODQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K528192756T41Ay
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 5 Aug 2026 08:29:04 +0200 (CEST)
Message-ID: <395d9b68-2527-47d6-a6a0-74569d27b734@hartkopp.net>
Date: Wed, 5 Aug 2026 08:29:03 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] can: automate IFF_ECHO flag for generic echo skbs
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04.08.26 21:55, Vincent Mailhol wrote:
> Most CAN drivers allocate echo skb slots through alloc_candev() or
> alloc_candev_mqs(), but still have to manually set IFF_ECHO to tell
> PF_CAN that the driver handles local echo itself. This creates
> boilerplate and makes it easy for drivers to forget one half of the
> setup.

No one ever "forgot" this flag.

> A recent example is commit c77bfbdd6aac ("can: dummy_can:
> dummy_can_init(): fix packet statistics"), where dummy_can was already
> using the generic echo skb helpers but needed an explicit IFF_ECHO
> assignment to make tx_bytes accounting work.

But you (ok us) :-D

To me this patch set does not really bring an improvement.
You are now hiding the setting of this bit.

Today it is very transparent visible inside each drivers initialization 
section whether it supports IFF_ECHO or not. And e.g. vcan.c can also 
switch this feature with a module parameter.

I prefer this conscious setting in the driver setup. We should better 
add proper comments in drivers that do not set the flag, e.g. in 
slcan.c there's no hint that the af_can.c echo feature is used.

Best regards,
Oliver


> Patch #1 cleans up slcan, which does not use the generic echo skb
> helpers and therefore should not allocate echo slots. Patch #2 fixes a
> small inaccuracy in the can.rst documentation in regard to the IFF_ECHO
> flag. Patch #3 sets IFF_ECHO automatically when echo skb slots are
> requested. And Patch #4, the final one, removes the now redundant
> IFF_ECHO assignments from drivers which are covered by alloc_candev()
> with a non-zero echo_skb_max.
> 
> The remaining explicit IFF_ECHO assignments are special cases with
> custom or virtual echo handling.
> 
> Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
> ---
> Vincent Mailhol (4):
>        can: slcan: do not allocate unused echo skb
>        can: fix IFF_ECHO example in documentation
>        can: dev: set IFF_ECHO when allocating echo skbs
>        can: treewide: remove redundant IFF_ECHO assignments
> 
>   Documentation/networking/can.rst                   | 7 +++++--
>   drivers/net/can/at91_can.c                         | 1 -
>   drivers/net/can/bxcan.c                            | 1 -
>   drivers/net/can/c_can/c_can_main.c                 | 1 -
>   drivers/net/can/cc770/cc770.c                      | 2 --
>   drivers/net/can/ctucanfd/ctucanfd_base.c           | 1 -
>   drivers/net/can/dev/dev.c                          | 1 +
>   drivers/net/can/dummy_can.c                        | 1 -
>   drivers/net/can/esd/esd_402_pci-core.c             | 1 -
>   drivers/net/can/flexcan/flexcan-core.c             | 1 -
>   drivers/net/can/ifi_canfd/ifi_canfd.c              | 1 -
>   drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c | 1 -
>   drivers/net/can/m_can/m_can.c                      | 1 -
>   drivers/net/can/mscan/mscan.c                      | 2 --
>   drivers/net/can/peak_canfd/peak_canfd.c            | 1 -
>   drivers/net/can/rcar/rcar_can.c                    | 1 -
>   drivers/net/can/rcar/rcar_canfd.c                  | 1 -
>   drivers/net/can/rockchip/rockchip_canfd-core.c     | 1 -
>   drivers/net/can/sja1000/sja1000.c                  | 1 -
>   drivers/net/can/slcan/slcan-core.c                 | 2 +-
>   drivers/net/can/softing/softing_main.c             | 1 -
>   drivers/net/can/spi/hi311x.c                       | 1 -
>   drivers/net/can/spi/mcp251x.c                      | 1 -
>   drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     | 1 -
>   drivers/net/can/sun4i_can.c                        | 1 -
>   drivers/net/can/ti_hecc.c                          | 1 -
>   drivers/net/can/usb/ems_usb.c                      | 2 --
>   drivers/net/can/usb/esd_usb.c                      | 2 --
>   drivers/net/can/usb/etas_es58x/es58x_core.c        | 1 -
>   drivers/net/can/usb/f81604.c                       | 1 -
>   drivers/net/can/usb/gs_usb.c                       | 1 -
>   drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   | 2 --
>   drivers/net/can/usb/mcba_usb.c                     | 2 --
>   drivers/net/can/usb/nct6694_canfd.c                | 1 -
>   drivers/net/can/usb/peak_usb/pcan_usb_core.c       | 2 --
>   drivers/net/can/usb/usb_8dev.c                     | 2 --
>   drivers/net/can/virtio_can.c                       | 1 -
>   drivers/net/can/xilinx_can.c                       | 2 --
>   38 files changed, 7 insertions(+), 47 deletions(-)
> ---
> base-commit: 828c4a5a9518117f9f7bdc445a7eeca85fc91bf8
> change-id: 20260804-automate_iff_echo_flag-6ddd7f4def7a
> 
> Best regards,

