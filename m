Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8813F822B
	for <linux-can@vger.kernel.org>; Thu, 30 Jul 2026 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407401; cv=none; b=koWr0IxECd/VQw1xGwK3Qkzq7FAMpffX4kZdiQEzmNXoy7OmyEbK5/u4lfK1IAkfVoT7mH/CHldPqBz7Hz4nPxYg+1dQZpdkmvwXT7feE0vgB/Q7lj5K4mJmnyRVoB7i+WmWg4U+696ylyuiXZCwXzVzFmSPfsQDWSuK4EpPvU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407401; c=relaxed/simple;
	bh=e9Rg1J8cInYQosOEiajWdY+WWMQHJzl5HeWfS7/yZn4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b11ALCW56cVzw2uUfN6j5xK8VYRl/ScxcJ1GGkluNPTGnhtwZ/n+BVGZeTOaw/wl8VHErHNki7lNVF8oLHQ7juWHFpYGsZcNaduPLnOLjHG8MU4V+TIqsPBjLt3y5kY9SaSvVv49jX2mUwP80zle+GtG1MyqMStKXFV8LjmqxC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHWdg/qn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHWdg/qn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396DF1F00A3D;
	Thu, 30 Jul 2026 10:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785407399;
	bh=cR62ffhUDEM0mlpuR2oJLy3llw2hZMWbI3CHRGEaMHw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gHWdg/qnza/iJGRQDZXdt1IOmtbC94vUIaoUFpG6poObyz7UJsFIQi7ipRyqAwvlK
	 /QbYBap+usshvRFXZlPOZqr70p+EAsjkPUzPvxeLpfQbUeQZ+c6K8XCt4BuzhdanG+
	 +iq9ZGkeSiExKLvMxhExBC+kwOraobASq7X7qFssv3LJfxO1n8lAIY3V3rK7J/Ra22
	 jYv3e3/SmM6Z7rq8p6Kt6sW+1ycHOo5m0pqvR5ddob7m1C4kbdIOiHJYF4O+7JI7NQ
	 4EtafNxYTEE4X3gtXH+0ZYNqkYEqYS1Qndiqfa1EIcjtL+nFYwFYT/3gqCQ4OS5moK
	 eTpndlGTMFI2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 16/20] can: softing: fw_parse(): validate firmware
 record spans
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260729102802.505168-17-mkl@pengutronix.de>
References: <20260729102802.505168-1-mkl@pengutronix.de>
 <20260729102802.505168-17-mkl@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 10:29:58 +0000
Message-Id: <20260730102959.396DF1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unaligned memory dereference in `fw_parse()` triggers alignment fa=
ults.
- [High] Truncated or malformed firmware causes silent failure by returning=
 0 on error paths.
- [High] Unaligned MMIO accesses to DPRAM via `iowrite32` cause hardware ex=
ceptions.
--

--- Patch [16]: [PATCH net 16/20] can: softing: fw_parse(): validate firmwa=
re record spans ---
commit dd9e23c1084e29145c02ec85df264fc5faf868da
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

can: softing: fw_parse(): validate firmware record spans

This commit improves bounds checking when parsing softing firmware records
to prevent out-of-bounds reads and writes. It passes the firmware end to
the parser and validates the source record length before doing DPRAM staging
copies.

Link: https://patch.msgid.link/20260722044347.2708-1-pengpeng@iscas.ac.cn

> diff --git a/drivers/net/can/softing/softing_fw.c b/drivers/net/can/softi=
ng/softing_fw.c
> index 721df91cdbfbc..282570daf3efe 100644
> --- a/drivers/net/can/softing/softing_fw.c
> +++ b/drivers/net/can/softing/softing_fw.c

[ ... ]

> @@ -114,14 +114,21 @@ static int fw_parse(const uint8_t **pmem, uint16_t =
*ptype, uint32_t *paddr,
>  	 * endianness & alignment.
>  	 */
>  	mem =3D *pmem;
> +	/* A record needs an 8-byte prefix and a 2-byte checksum. */
> +	if (mem > limit || limit - mem < 10)
> +		return -EINVAL;
> +
>  	*ptype =3D le16_to_cpup((void *)&mem[0]);
>  	*paddr =3D le32_to_cpup((void *)&mem[2]);
>  	*plen =3D le16_to_cpup((void *)&mem[6]);

[Severity: High]
This is a pre-existing issue, but does using le16_to_cpup() and
le32_to_cpup() on an unaligned byte stream cause alignment faults?

Firmware records are packed without padding, meaning mem could rest on an o=
dd
address. The leXX_to_cpup functions directly dereference the pointer, which
can trigger a fatal alignment fault exception (kernel oops) on architectures
that lack hardware unaligned access support. Should fw_parse() use
get_unaligned_le16() and get_unaligned_le32() here instead?

> +	if (*plen > limit - mem - 10)
> +		return -EINVAL;
> +
>  	*pdat =3D &mem[8];
>  	/* verify checksum */
> -	end =3D &mem[8 + *plen];
> -	checksum[0] =3D le16_to_cpup((void *)end);
> -	for (checksum[1] =3D 0; mem < end; ++mem)
> +	record_end =3D &mem[8 + *plen];
> +	checksum[0] =3D le16_to_cpup((void *)record_end);
> +	for (checksum[1] =3D 0; mem < record_end; ++mem)
>  		checksum[1] +=3D *mem;

[ ... ]

> @@ -279,6 +291,12 @@ int softing_load_app_fw(const char *file, struct sof=
ting *card)
>  		/* work in 16bit (target) */
>  		sum &=3D 0xffff;
> =20
> +		if (card->pdat->app.offs > card->dpram_size ||
> +		    len > card->dpram_size - card->pdat->app.offs) {
> +			ret =3D -EINVAL;
> +			goto failed;
> +		}
> +
>  		memcpy_toio(&card->dpram[card->pdat->app.offs], dat, len);
>  		iowrite32(card->pdat->app.offs + card->pdat->app.addr,
>  				&card->dpram[DPRAM_COMMAND + 2]);

[Severity: High]
This is a pre-existing issue, but does using iowrite32() on unaligned
offsets cause hardware exceptions?

These iowrite32() calls target DPRAM addresses shifted by unaligned offsets
like DPRAM_COMMAND + 2 and DPRAM_COMMAND + 6. Standard 32-bit I/O accessors
mandate 4-byte alignment on the target memory address. Executing an
unaligned MMIO write triggers a hardware alignment fault or bus error on
non-x86 architectures. Should these operations be split into sequential
16-bit writes using iowrite16()?

[Severity: High]
This is a pre-existing issue, but does a truncated or malformed firmware
blob cause a silent failure by returning 0?

In both softing_load_fw() and softing_load_app_fw(), if the firmware blob
does not contain an EOF record or an entrypoint record, the parsing loop
terminates without encountering an error:

softing_fw.c:softing_load_app_fw() {
    ...
    while (mem < end) {
        ret =3D fw_parse(&mem, end, &type, &addr, &len, &dat);
        if (ret)
            goto failed;
        ...
    }
    if (!type_end || !type_entrypoint)
        goto failed;
    ...
failed:
    ...
    return ret;
}

Because fw_parse() returns 0 on success, ret is left at 0 when the loop
finishes naturally. The code then detects the missing record and jumps to
the failed label, but since ret is 0, it incorrectly returns success to
the caller. This leaves the device uninitialized. Could ret be set to an
error code like -EINVAL before the goto?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729102802.5051=
68-1-mkl@pengutronix.de?part=3D16
