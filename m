Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA86F2F1FE4
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 01:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792115645; cv=none; b=Smf7w20TwkrM2ubWoB0UWrlnrf6C/LM560jeVmWDAnxLKYLpeZAz4sEPE6qZhY3cURhqlF9q7wbAcIs9r33vX3kbPgxsCnvu6DCCkDcmK3NKYfw+YofPjOXqq1nPwESyNBSdcs1USPms5OVRd0EdYEki4qqmA8oNjLFP69kE358=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792115645; c=relaxed/simple;
	bh=6JsUBLgZOGAJAzYsUJOYk/aqiuL/hl/VuaFp+lEk360=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=r0ztjoORhj5W3hxZBBih8iaCuaLVcU8h5Uaj+DYcFkgKiloxzXenKb+VoSVqn0fmNIEg8uSMzoK/Za3p3SltaMCQ/Z+tdeMdGrjLUWjBMR5FHI5BK5TH8dDY+9edjTQvDYrpWpBFTEbWpTQFebWc6WGk1IHw+L3UB7EoRrG9eho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8ecBK5E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8ecBK5E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DFB1F000C5;
	Fri, 16 Oct 2026 01:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792115644;
	bh=jHo/KAmg+ig+x/rdQBM0UNXuHXg1SvlDIkk+H45jJtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j8ecBK5EzET++0XS+ep+a3f8STwUL1fMFUDR41nl4gwZFhdwiYQSSPgXS4otwadLo
	 o1DIetYwAs6zmDKbI2As1mfvcUodWd5aTswRCcthSPxbTDXRTN+nabKKTu+QVWjiiG
	 UCZWPs53Hx+qvJ/ogZlfb6zKOgcULu5o9WEVIO8esZN5OFpGf4EBi9kWLkCaP2AB4+
	 pA09DDdPW3AZZRB6hEYq+iaSUSdQZgnp0wo147Uly1GCd5VHgkWDyaM7JM1McN9lem
	 lK3lAhODyD7asekblYl8Ta/eeKwMCh2ACUSEP1p/5W5DIFg38wMaLiA8FuzP+mfpnd
	 GO89hMBHM5IzA==
Message-ID: <sashiko-outbox-173591@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 29/37] can: esd: acc_start_xmit(): avoid
 use-after-free of skb after can_put_echo_skb()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20261015015336.816543-30-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
 <20261015015336.816543-30-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 01:54:04 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] can: esd: reversed payload bytes on Big-Endian systems
--

commit ec092ddca47eb36deace0335dca8d7166cad0410
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: esd: acc_start_xmit(): avoid use-after-free of skb after can_put_echo_=
skb()

After the call to can_put_echo_skb() in acc_start_xmit() the skb is invalid
and not accessed anymore, but acc_txq_put() will access the skb's data.

Link: https://patch.msgid.link/20260929-esd-fix-skb-deref-v2-1-542e3e19fb25=
@pengutronix.de

> diff --git a/drivers/net/can/esd/esdacc.c b/drivers/net/can/esd/esdacc.c
> index 73e66f9a3781c..05d41ed34a02e 100644
> --- a/drivers/net/can/esd/esdacc.c
> +++ b/drivers/net/can/esd/esdacc.c
> @@ -62,14 +62,17 @@ static void acc_resetmode_leave(struct acc_core *core)
>  	acc_resetmode_entered(core);
>  }
> =20
> -static void acc_txq_put(struct acc_core *core, u32 acc_id, u32 acc_dlc,
> -			const void *data)
> +static void acc_txq_put(struct acc_core *core, u32 acc_dlc, const void *=
data)
>  {
>  	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_1,
>  			   *((const u32 *)(data + 4)));
>  	acc_write32_noswap(core, ACC_CORE_OF_TXFIFO_DATA_0,
>  			   *((const u32 *)data));

[Severity: High]
Looking at acc_txq_put() in drivers/net/can/esd/esdacc.c, does this code
reverse payload bytes on Big-Endian systems?

The direct cast *((const u32 *)(data)) reads the 8-byte CAN payload as a
host-endian 32-bit integer. On Big-Endian architectures, this reads bytes 0=
-3
as (data[0]<<24) | ... | data[3]. The acc_write32_noswap() function then
calls iowrite32(), which byte-swaps the integer to Little-Endian format for
the PCI bus. As a result, the hardware FIFO receives the payload bytes in
reverse order: data[3], data[2], data[1], data[0].

Would it be better to use get_unaligned_le32() here to construct a
Little-Endian integer regardless of host architecture, ensuring iowrite32()
always outputs data[0] to the lowest address?

>  	acc_write32(core, ACC_CORE_OF_TXFIFO_DLC, acc_dlc);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015015336.8165=
43-1-mkl@pengutronix.de?part=3D29
