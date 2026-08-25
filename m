Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D5832C94A
	for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682927; cv=none; b=C/N/vivUKW1XDs5iV+qC3Z1wegDr4tQB2wD4QbHo8Iwbw9Zp6n/LwLLUsnngl+Oiw8Bmz0ZtvaYNoi/BJb5RQcMGm7bjl5ATJNyrop+ykvdfgjobbZGC5AVQcv6W0aYW8uunUwAUBKTO0h2STEPL7S6uPQzxrVEAurOWf1Ky2w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682927; c=relaxed/simple;
	bh=w77ZhTQ1OYzkQxPAK6iHFhy9Po+gRfKB93CRgC7BHs8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dW0LLIvLY0zag20gwVEt8Q27KytAQ0RSRjCwzSthUIYcp8tdXLybgnwpszyRuSaBHG6zblp++C2LqluJ6aDGiLi7EoveYwW2rRiYJ9GMNeRUYYyuh/GqgpTT1CGRJ18TZO0vyspqr+4dNNUiUz46y9LOBNy7CXKRLzCShZkCmbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=K7GZsQ0L; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="K7GZsQ0L"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a0de062db5so128610a12.1
        for <linux-can@vger.kernel.org>; Tue, 25 Aug 2026 11:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787682922; x=1788287722; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fUvuJij7ETShzBsffPqHrVIMC/JpC6SOB9Cs5CuXefM=;
        b=K7GZsQ0Ld19gHMsiyY/E6jISlT9yNuAq4OaXdj3W8i73atOSPrZS2lckkyrx4/8E6g
         3qRAMR+crd056V9HuDOH6muQDgpOP7NPGUU43kFFl3APK7/lbwOsxRQRSBoLicLEsjea
         D7yvNwEM5FkOHH1s3eiPloaERt937GFskas8bHa4muszISdeuBSIm1B1iXpQepx9sa+4
         Zg2g17UkkN9/k1N9OJYXtko/T5/Rd6asXznjFsX/kQTI7D/MGpj1ZxyreXFK/kNHzye7
         TjbQ76pebvJxuIcYCkyw9nkAx8W52KOZy/l2XWbN6lRA/ZCUA1Y7sJgGAJaGzYLrhLua
         Ob0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682922; x=1788287722;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fUvuJij7ETShzBsffPqHrVIMC/JpC6SOB9Cs5CuXefM=;
        b=C2vhKeQkayHuFslLpuUCxQPlL/2T4mz9dZpvbJBMvGeOnawngFQiy1D5HXB1AbldZC
         ykEKPZY0nQ9OVKw15mDZ9Nj4ySQtNDFHdsG6bqIaJv2nN6qoE55mPW51glYtC+EHB2vH
         VggecANvwTCoFOPkf9vCwOnapSTyfZfkY8PpSRkwYI054a34E5owqgGWdavrGYjzQAbN
         +me700wPIQEbJ4ylZHSlMj1g+jky3Rr8sMedYY3S3a4gu8tVYYZTkSKkjG6jq3ArtBe1
         z2RYBBRioRc+9m7zzh5XvZNC6HWcJmmGEH3YtmKqI/g6uvu0tyWjlmLSFaeTC64/8wtq
         CVuw==
X-Gm-Message-State: AFuF++mxiVPNdDORwaITM5mrW8g4x4r5Q/1nE44LvxQT5sZRv2v4V4Yr
	7dgnWqsLRfTYwdxK0Fc5naM0tT6iFdf1m2hZ/QsV5LrbWt6VdD6sPCA7s2vEsyFwMaC80E3HvVg
	ZNlwK
X-Gm-Gg: AR+sD10zlw5eDH98G6PjFiEssWJxoafnXBYEXDB2ILHkDcohADSt5bVATPCNu13/798
	jsoROeuVJTj7JUP0io3I+5Z4pFFkTFNUuFlDtD8woxvPMA9HqYu+ykIWLBcgnqtKhV1h88LNAJg
	1BZ/9nvhyJwXmqW4gTiBGlbiYSJZbSwbYIn3HC4cryocgtf6XZ5cIDSswTjNuhgLChulVzrtrpC
	VgOO8gTmTyWFqbf1JSbnGvh25eFnTVqsP5pM74+mv3Xa3uLjKJPBSIoBveBPml0WXXDHMJRdKQS
	zkTOmjvvz7ht7f+71f1IG6D9tWwtSJbSPwhjV4Gd1u+G3A+8nCUO1guIOokhRSjUY68uGg6QuE3
	gL04ZrjNLSc3PhHr1YJ2Qj5AW0qZn4GtOzlsxoWxLdORG3I1JkHMyaoZ3gQL5WwHSyjVLSr2mt3
	Pql3/32rXFdXBWKkIwmVKz0ulrItsLOTDbGXdy8W4LjmgL467iswYraDS1
X-Received: by 2002:a17:906:ee88:b0:c12:83da:7eeb with SMTP id a640c23a62f3a-c250c3add0dmr67239366b.19.1787682921966;
        Tue, 25 Aug 2026 11:35:21 -0700 (PDT)
Received: from localhost ([2001:4090:a244:80d4:489b:7642:1b32:84d6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a5d68f9sm78905766b.1.2026.08.25.11.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:35:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=d407ca66d98b85128ab7a30a28c98bbbb58ea2ec79301d91fc16fe4a723b;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 25 Aug 2026 20:35:15 +0200
Message-Id: <DKY8PDR3FJVG.1YW4D2UJPR4OH@baylibre.com>
Cc: <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <kernel@pengutronix.de>
Subject: Re: [PATCH can-next v2] can: m_can: switch to rx-offload
 implementation
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "Vincent Mailhol" <mailhol@kernel.org>
X-Mailer: aerc 0.21.0-146-gb5c16ebe1835
References: <20260710-m_can-rx-offload-v2-1-aa6597eb194e@pengutronix.de>
In-Reply-To: <20260710-m_can-rx-offload-v2-1-aa6597eb194e@pengutronix.de>

--d407ca66d98b85128ab7a30a28c98bbbb58ea2ec79301d91fc16fe4a723b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Marc,

sorry for the delay, I was on summer vacation.

On Fri Jul 10, 2026 at 1:50 PM CEST, Marc Kleine-Budde wrote:
> The current m_can driver uses NAPI for mmio devices to handle RX'ed CAN
> frames, the RX IRQ is disabled and a NAPI poll is scheduled. Then in
> m_can_poll() the RX'ed CAN frames are read from the device.
>
> The driver already uses rx-offload for SPI devices like the tcan4x5x,
> indicated by struct m_can_classdev::is_peripheral being set.
>
> This approach has 2 drawbacks:
>
> - Under high system load it might take too long from the initial RX IRQ t=
o
>   the NAPI poll function to run. This causes RX buffer overflows.
> - The driver contains several checks if it handles a peripheral or a memo=
ry
>   mapped device, that makes maintenance harder.
>
> Convert the driver to unconditionally call m_can_rx_handler() from the IR=
Q
> handler (m_can_interrupt_handler()), which reads the RX'ed CAN frames fro=
m
> the hardware and adds it to a list sorted by RX timestamp. This list of
> RX'ed SKBs is then passed to the networking stack in a later NAPI context=
.
>
> Remove all manual napi handling from the driver and keep the
> can_rx_offload_*().

Thanks for your work, this is a nice improvement. Comments below.

>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Changes in v2:
> - m_can_receive_skb(): remove double accounting of RX packets (found by s=
ashiko)
> - remove obsolete struct m_can_classdev::napi (found by sashiko)
> - m_can_do_rx_poll(): remove quota, read all RX'ed messages (found by sas=
hiko)
> - Link to v1: https://patch.msgid.link/20260709-m_can-rx-offload-v1-1-af3=
efa8e4272@pengutronix.de
>
> To: Markus Schneider-Pargmann <msp@baylibre.com>
> To: Marc Kleine-Budde <mkl@pengutronix.de>
> To: Vincent Mailhol <mailhol@kernel.org>
> Cc: linux-can@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/net/can/m_can/m_can.c | 151 +++++++++++-------------------------=
------
>  drivers/net/can/m_can/m_can.h |   2 -
>  2 files changed, 38 insertions(+), 115 deletions(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index eb856547ae7d..866c4b501dad 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -530,26 +530,17 @@ static void m_can_clean(struct net_device *net)
>  	spin_unlock_irqrestore(&cdev->tx_handling_spinlock, irqflags);
>  }
> =20
> -/* For peripherals, pass skb to rx-offload, which will push skb from
> - * napi. For non-peripherals, RX is done in napi already, so push
> - * directly. timestamp is used to ensure good skb ordering in
> - * rx-offload and is ignored for non-peripherals.
> - */
>  static void m_can_receive_skb(struct m_can_classdev *cdev,
>  			      struct sk_buff *skb,
>  			      u32 timestamp)
>  {
> -	if (cdev->is_peripheral) {
> -		struct net_device_stats *stats =3D &cdev->net->stats;
> -		int err;
> +	struct net_device_stats *stats =3D &cdev->net->stats;
> +	int err;
> =20
> -		err =3D can_rx_offload_queue_timestamp(&cdev->offload, skb,
> -						     timestamp);
> -		if (err)
> -			stats->rx_fifo_errors++;
> -	} else {
> -		netif_receive_skb(skb);
> -	}
> +	err =3D can_rx_offload_queue_timestamp(&cdev->offload, skb,
> +					     timestamp);

An AI noticed (and I checked) in can_rx_offload_queue_timestamp() it
checks the queue length of skb_queue and drops packets if that queue is
already full. But the function actually adds it to the skb_irq_queue
which length is not checked at all in this function. skb_irq_queue is
only much later added to the skb_queue, at which point it doesn't drop
any packets over the limit. Shouldn't it be checking the sum of the
lengths of both queues? Or is this intentional?

> +	if (err)
> +		stats->rx_fifo_errors++;
>  }
> =20
>  static int m_can_read_fifo(struct net_device *dev, u32 fgi)
> @@ -600,10 +591,7 @@ static int m_can_read_fifo(struct net_device *dev, u=
32 fgi)
>  				      cf->data, DIV_ROUND_UP(cf->len, 4));
>  		if (err)
>  			goto out_free_skb;
> -
> -		stats->rx_bytes +=3D cf->len;
>  	}
> -	stats->rx_packets++;
> =20
>  	timestamp =3D FIELD_GET(RX_BUF_RXTS_MASK, fifo_header.dlc) << 16;
> =20
> @@ -618,10 +606,9 @@ static int m_can_read_fifo(struct net_device *dev, u=
32 fgi)
>  	return err;
>  }
> =20
> -static int m_can_do_rx_poll(struct net_device *dev, int quota)
> +static int m_can_do_rx_poll(struct net_device *dev)

This function doesn't have anything to do with polling anymore. Maybe it
would better to rename this?

>  {
>  	struct m_can_classdev *cdev =3D netdev_priv(dev);
> -	u32 pkts =3D 0;
>  	u32 rxfs;
>  	u32 rx_count;
>  	u32 fgi;
> @@ -638,13 +625,11 @@ static int m_can_do_rx_poll(struct net_device *dev,=
 int quota)
>  	rx_count =3D FIELD_GET(RXFS_FFL_MASK, rxfs);
>  	fgi =3D FIELD_GET(RXFS_FGI_MASK, rxfs);
> =20
> -	for (i =3D 0; i < rx_count && quota > 0; ++i) {
> +	for (i =3D 0; i < rx_count; ++i) {

If I understand correctly you are removing any limit on how much is
retrieved and you are doing this in the main irq handler now, not
threaded. Did you measure how long the non-threaded irq-handler actually
takes with this change and if the CAN bus is under pressure? Would it
make sense to do this in a threaded irq handler?

>  		err =3D m_can_read_fifo(dev, fgi);
>  		if (err)
>  			break;
> =20
> -		quota--;
> -		pkts++;

You are not counting or returning the number of packets anymore but use
it in the calling code. Is this intended?

>  		ack_fgi =3D fgi;
>  		fgi =3D (++fgi >=3D cdev->mcfg[MRAM_RXF0].num ? 0 : fgi);
>  	}
> @@ -652,10 +637,7 @@ static int m_can_do_rx_poll(struct net_device *dev, =
int quota)
>  	if (ack_fgi !=3D -1)
>  		m_can_write(cdev, M_CAN_RXF0A, ack_fgi);
> =20
> -	if (err)
> -		return err;
> -
> -	return pkts;
> +	return err;
>  }
> =20
>  static int m_can_handle_lost_msg(struct net_device *dev)
> @@ -678,8 +660,7 @@ static int m_can_handle_lost_msg(struct net_device *d=
ev)
>  	frame->can_id |=3D CAN_ERR_CRTL;
>  	frame->data[1] =3D CAN_ERR_CRTL_RX_OVERFLOW;
> =20
> -	if (cdev->is_peripheral)
> -		timestamp =3D m_can_get_timestamp(cdev);
> +	timestamp =3D m_can_get_timestamp(cdev);
> =20
>  	m_can_receive_skb(cdev, skb, timestamp);
> =20
> @@ -750,8 +731,7 @@ static int m_can_handle_lec_err(struct net_device *de=
v,
>  	if (unlikely(!skb))
>  		return 0;
> =20
> -	if (cdev->is_peripheral)
> -		timestamp =3D m_can_get_timestamp(cdev);
> +	timestamp =3D m_can_get_timestamp(cdev);
> =20
>  	m_can_receive_skb(cdev, skb, timestamp);
> =20
> @@ -883,8 +863,7 @@ static int m_can_handle_state_change(struct net_devic=
e *dev,
>  		break;
>  	}
> =20
> -	if (cdev->is_peripheral)
> -		timestamp =3D m_can_get_timestamp(cdev);
> +	timestamp =3D m_can_get_timestamp(cdev);
> =20
>  	m_can_receive_skb(cdev, skb, timestamp);
> =20
> @@ -973,8 +952,7 @@ static int m_can_handle_protocol_error(struct net_dev=
ice *dev, u32 irqstatus)
>  		return 0;
>  	}
> =20
> -	if (cdev->is_peripheral)
> -		timestamp =3D m_can_get_timestamp(cdev);
> +	timestamp =3D m_can_get_timestamp(cdev);
> =20
>  	m_can_receive_skb(cdev, skb, timestamp);
> =20
> @@ -1055,7 +1033,7 @@ static int m_can_rx_handler(struct net_device *dev,=
 int quota, u32 irqstatus)

This function still has the argument quota but it seems unused now.

>  						     m_can_read(cdev, M_CAN_PSR));
> =20
>  	if (irqstatus & IR_RF0N) {
> -		rx_work_or_err =3D m_can_do_rx_poll(dev, (quota - work_done));
> +		rx_work_or_err =3D m_can_do_rx_poll(dev);

You are only returning error from m_can_do_rx_poll now. work_done will
always be 0 now. The work_done +=3D line is not useful anymore.

Looking more closely I think work_done in m_can_rx_handler is completely
useless now and could be removed here and in the called functions?

Best
Markus

--d407ca66d98b85128ab7a30a28c98bbbb58ea2ec79301d91fc16fe4a723b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCao3gYxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlP9
sAEAz0xPTT5ksGS4OFUIcJCX7vfmUCBou+sjgDkRHShs1rQA+gIjs85PRSRWzJGR
jZxRojCbNQUoTkJ1R3kxdQMfcBgA
=7AtJ
-----END PGP SIGNATURE-----

--d407ca66d98b85128ab7a30a28c98bbbb58ea2ec79301d91fc16fe4a723b--
