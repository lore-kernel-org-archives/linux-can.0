Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8E654DACD;
	Tue,  8 Sep 2026 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875047; cv=none; b=jnGx+g0xKRTE1gjUSGBgpHRI2pK4pULteqGxZ2yWqihFKJvSpG2Go0/gIYpf86Ge5stgyJ06k24rEW8zHY32RnRI2GfWnHIVugNFEKiufQ7MTC5JaBBJfs4z1Q9kTIwe4fAVhwKXZ7fdTM0XeTrXNxjRBINaYclOI1Toz2KQ4qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875047; c=relaxed/simple;
	bh=M3iJjEEtf9fI+g/dFLOt5v/zy66B6/8cwJsAFpvW0VA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qzzAMoe/ftX7ccf6YdeubmP9OdD4D/wBXJkZvKCG9q0dyHFySBB4S3X1ggvlr9L08ovWKwD81Zhe/xHunyuxkGOI58Fh4qDJCM7MYSAQdWJ6HMCARkONGilFI4s6x65QOnTYi281FtOTvWYU5NdZ0hN77x0+LcUxhxuoRLMXT34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBAeR1JY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBAeR1JY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D96EC1F00A3F;
	Tue,  8 Sep 2026 13:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788875028;
	bh=Zv6WbMVhYeFVEFyh1I9UEp+UrZtJ1cxZOXvhybkKYt8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KBAeR1JY57rNG6ynl0OYhX+2ZsK41hAELarfGyxD/bNdDxffaTLOGtlqNt2lLG6tB
	 n8S1x+E9p71RlBIX6jX7u53oGOEiFyQ+bl/WY6nHFSSnF+UWw/k3/8EIYdyAyin7HJ
	 ksHJmc1BiR/dlfpONosioGWUE2rNs9/FROyrckcBvjsx32uLhFRlmY0CRr8udt4c5Q
	 JWOp6Tp2bymVLtUv85U7glegZDZG4NbUN4IiG5L42R1+aPUrxxRSsb/5XrLosgecEN
	 ElEcRvr7sEkD4sS531c1CiVeLai0XMZWn98BPSraP8AcCzRd7fPw6k+6tBCakrqKls
	 kUvKVwWYNmJew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv3 3/3] m68k: coldfire: fix non-standard readX()/writeX()
 functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Ungerer" <gerg@linux-m68k.org>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc Kleine-Budde" <mkl@pengutronix.de>, Frank.Li@kernel.org, imx@lists.linux.dev, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260907134037.1855408-4-gerg@linux-m68k.org>
References: <20260907134037.1855408-1-gerg@linux-m68k.org>
 <20260907134037.1855408-4-gerg@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 13:43:47 +0000
Message-Id: <20260908134347.D96EC1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Replacing ColdFire's non-standard I/O accessors breaks eDMA descri=
ptor loading by exposing a hidden endianness bug in `fsl-edma-common.h`, wr=
iting little-endian data to big-endian hardware.

Pre-existing issues:
- [High] The eDMA error interrupt handler silently ignores upper channel er=
rors if no lower channel errors are present, and returns IRQ_NONE after suc=
cessfully handling lower channel errors if no upper channel errors are pres=
ent.
- [High] Using 32-bit `BIT()` macro with a shift count up to 63 causes unde=
fined behavior, breaking interrupt handling for channels 32-63.
--

commit 90504ddd291ad9040d7cc40def38400a2da51323
Author: Greg Ungerer <gerg@linux-m68k.org>

m68k: coldfire: fix non-standard readX()/writeX() functions

This patch removes the local ColdFire definitions of read/write I/O
access functions and uses the asm-generic versions instead. It also
updates several drivers that previously relied on the non-standard
behavior to use the correct endian-specific accessors or quirks.

[ ... ]

> diff --git a/drivers/dma/mcf-edma-main.c b/drivers/dma/mcf-edma-main.c
> index 9e1c6400c77be..4ed0ce644e37e 100644
> --- a/drivers/dma/mcf-edma-main.c
> +++ b/drivers/dma/mcf-edma-main.c
> @@ -21,9 +21,9 @@ static irqreturn_t mcf_edma_tx_handler(int irq, void *d=
ev_id)
>  	unsigned int ch;
>  	u64 intmap;
> =20
> -	intmap =3D ioread32(regs->inth);
> +	intmap =3D ioread32be(regs->inth);
>  	intmap <<=3D 32;
> -	intmap |=3D ioread32(regs->intl);
> +	intmap |=3D ioread32be(regs->intl);
>  	if (!intmap)
>  		return IRQ_NONE;

[Severity: High]
This is a pre-existing issue, but does using the 32-bit BIT() macro just
below this block cause undefined behavior for channels 32-63?

In mcf_edma_tx_handler():
	for (ch =3D 0; ch < mcf_edma->n_chans; ch++) {
		if (intmap & BIT(ch)) {
			iowrite8(EDMA_MASK_CH(ch), regs->cint);

On 32-bit platforms, BIT(ch) evaluates modulo 32. When checking completions
for upper channels (e.g., ch=3D32), BIT(32) will evaluate to bit 0 instead
of bit 32.

If the wrong bit is checked, the interrupt for channels 32-63 won't be
cleared, leading to an interrupt storm. Should this use BIT_ULL(ch)
since intmap is a u64?

> @@ -43,7 +43,7 @@ static irqreturn_t mcf_edma_err_handler(int irq, void *=
dev_id)
>  	struct edma_regs *regs =3D &mcf_edma->regs;
>  	unsigned int err, ch;
> =20
> -	err =3D ioread32(regs->errl);
> +	err =3D ioread32be(regs->errl);
>  	if (!err)
>  		return IRQ_NONE;

[Severity: High]
This isn't a bug introduced by this patch, but does this error handler=20
incorrectly short-circuit if lower channels are error-free?

If a DMA error occurs on channels 32-63 (regs->errh), but not on 0-31
(regs->errl), the handler will hit this first if (!err) check and return
IRQ_NONE.

If it returns IRQ_NONE, the error is never cleared, leaving the IRQ
line asserted. Will this result in an interrupt storm that hangs the
CPU until the kernel permanently disables the IRQ?

[ ... ]

> @@ -203,8 +203,8 @@ static int mcf_edma_probe(struct platform_device *pde=
v)
>  		edma_write_tcdreg(mcf_chan, cpu_to_le32(0), csr);
>  	}
> =20
> -	iowrite32(~0, regs->inth);
> -	iowrite32(~0, regs->intl);
> +	iowrite32be(~0, regs->inth);
> +	iowrite32be(~0, regs->intl);

[Severity: High]
Does removing the non-standard read/write behaviors expose a hidden
endianness bug in how fsl-edma-common.h programs the eDMA descriptors?

The mcf-edma probe function writes TCD registers via edma_write_tcdreg()
in this hunk:
        edma_write_tcdreg(mcf_chan, cpu_to_le32(0), csr);

Under the hood in fsl-edma-common.h, edma_write_tcdreg_c() casts this
little-endian value directly to a native u32 before passing it to
edma_writel() (which maps to iowrite32be on ColdFire).

Previously, the non-standard ColdFire I/O macros lacked byte-swapping,
so the driver's use of iowrite32be() implicitly double-swapped the
incorrectly cast u32 value back to a native Big-Endian value.

Now that the generic writel() corrects this and byte-swaps properly, will
the eDMA controller read garbled (byte-swapped) descriptors and corrupt
memory when DMA transfers are submitted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907134037.1855=
408-4-gerg@linux-m68k.org?part=3D1
