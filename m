Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8B4A2A40
	for <linux-can@vger.kernel.org>; Fri,  4 Sep 2026 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530139; cv=pass; b=YRJ16FOcNCyzDWIo0kAAhgFj+ozt0cgNdzXsh9i1PtF+66+6aqakpxkf4+SKqeiiitYjpInvjiZPBTQPMGxUCB06srbf+Z+MP3bfCSSF7hcTxclPT2KR+scvcrL38+bSvObtzj3IibgHJIH90JboC8scsviLvR9nTPEbCSDSv/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530139; c=relaxed/simple;
	bh=aYGTw43PGiruYrbCRK8lrDyOCcUgVMqsAo0cR/fDfeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uwz05copn2EozITHlwsphONAsAFUidTUqDTFgGxPLACXpin8EROGypKBJnxyLqNgL1f9MZ8oKoFYdYeCQgoFsDx8tsriOzrwzaqXwCnj6WknbnoOjwtnAd9Cn2Cxn8BlkOoLK5E4Ec0LGImF7glWXu2jsCIpMVl7lFpZ5Bka33g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCxxW9q4; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCxxW9q4"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a5ded53570so1362724a12.3
        for <linux-can@vger.kernel.org>; Fri, 04 Sep 2026 06:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788530134; cv=none;
        d=google.com; s=arc-20260327;
        b=lqtN0bX/B64q7wG7EnvaoEbLx0ehYdPCU+Qv9Va5zi5+Z9+XtqpWyuORgCU2UQC1iq
         0NOW5MsZU55CDgUCAn1Yzh80frAfVfE1x2AAAt/2x68UJ6s+Um0RYT/QmvM2jKb/Xswd
         tAy2uestQw+urVKhbJo1YDvNPQc2nL4v8KmQkG23UIEDkz4dEFUmxHvXeS6aRLZsHd7L
         qM775H47OeVwriu5wwPCl1lohRZIRBmEeQl/1u30MvVGlxw6gN96pjcEQgp4fx8uFlAY
         y0WdNo2kyvnGFEV98/EmFsrjsi47SElA+/l7ADjr4OUOMwfF8488rwR+glLE/RU7NioM
         C7ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pkjDjgzDaw86AXoG1909ddrRynkL4ufeKlwmjCrQJhQ=;
        fh=XTBrAAEah5VClCrvEh04KOwrxW+6aAwMmITrFheFP0E=;
        b=qFPgY33Fb+OZzwACeNko9jy4Tfo1rI+gVR7nZIHAHzoXL3NIXrfYFcCuaZUW4RvD4C
         liBvK3uSkgvrqWHxD6wynkwlMkin2T8tJxBJjFnV55RAyizLUDxPdZYZWf02vwLzdXFz
         6Nq/T8VtQ8EDmXku/zH6HVR8CLHDVHsgpTLsNRHI66Ht1yUmyiuukcwrbgW8VjITnQQH
         doWciF9M4z5jrG2wWpI5Q/WvMEOlXbyG9NuZGIEy97FjWnwfvwyKIHBoFuTp6inXQFHC
         kSX3q5RxsqHAkLNybYFF6g0XJ4QNbg5eHEZbDYADqb6u+fuUr6Hw4VlsWN0RMPse59o9
         Kg6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788530134; x=1789134934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pkjDjgzDaw86AXoG1909ddrRynkL4ufeKlwmjCrQJhQ=;
        b=kCxxW9q41x6acDRBBZDVjfyTyqKRt/evee3/RMJ64zlf6SHrFgHtykPwYzwvAi3wVJ
         ZRIv7vOTkQh2Lr2n+smSk6EZDeGERL2XnUVdkdmbijX3sIq8nHQIT4bwdKQG9VlBvxBC
         8naCTVcUFcfSQHMrBLpJQGzu74JQ2aIQws7AXtvIxc14zHervNOo4KbpAp1FFOqd1BDh
         8sOIjGi6BVaoHydFmTO+nYefEIeAAEsXLvyc/0L2/jipTutRInYXfOINnr0YZQVJnXHl
         C2LFuM/tqHwSMwJQDQ8c+FIBz7PMpJ9MUu/9P80i1Y2oORNVkVuubgrLsPndLlRYakJI
         4DdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788530134; x=1789134934;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pkjDjgzDaw86AXoG1909ddrRynkL4ufeKlwmjCrQJhQ=;
        b=qttlNfZKFtcxVKleSEsKGpHLZ/eE/czvNot/7wlib9AKTwKW6Kbp6EQunggU3ek25C
         mzQ9DXWcp2Z5AbodPomc+PBidLiDLdfsiuWOkH0ebKVhN17bl393+0iAxEpKaYoPwp+M
         ukZ6wA0evD7iFwP40SjjVzEJSgkvS+FEk7/qGC0HO7tGNFMmFPqYRvTIUn/GMcunkaEl
         n7vfW19vS9acYcuOqgCeBsc7E5YwJ/CGb37EX9m7lhNJM1uvCQZ/E3D6DizEci0qGnkH
         9CQ6ye8waWb8lQTG7EzTDCGIXE/dDlvsnr2kSICTPp1eX0ufOq6DTtCRqJy4NoFMI8Ne
         wAxg==
X-Forwarded-Encrypted: i=1; AKwUvBxo0/afwJ7gZL0gzg2FSoh7+mOecFqswG96C6iVd5GSX7YAq3CR8V9A8uO3o/kxU/ucV0j3F+g1V1s=@vger.kernel.org
X-Gm-Message-State: AFuF++ljg8Ph9bRtTUE+SWuz/qP4veoUuRIbw2Y3Rlg9RVh5zCAb9Pn5
	qU3lWXCc40hzkheYFPdPSljBulE0TmbxahcqmrSxD8bvKYIsY9E4eXSLxxDSI2cN6CsyXtfZSys
	FOeyPIpb8twmxN+aHnNKgZ/c8nv8cXNw=
X-Gm-Gg: AYBFou1lFL8GYErzfnjwOia6YwHE/KjzTsgfKVgrAuDprydBKaDQdQhNVGPVSEJrz26
	gkEaFS4EyDAlj7oY905hlvFEsa1UEwy8RNl05XHowx/CMtoNjtWIoelwK9nVYN1J4Qlz9gOlpcY
	5csTr9i9KqTE+qEPuwZPqwwOy3TVrmudJkBAvj4myU3OW62kGnGnIfPNpjNgkXcYUMETrWR7DC0
	Vul71JlgzOy8Rplp1i8R1zOMEhOywRvyhEB72RbNIBtjRztW4o2L+teEk7Cjq0/Jn4CDFX2RXFd
	MrSXV3c8zME6u7Z50o67J51v2aveUI2YcZ0Ts/SwJ3X0aRSfkUIQ++9xyufn
X-Received: by 2002:a17:907:720f:b0:c25:5d2:acf0 with SMTP id
 a640c23a62f3a-c260c8c21d3mr311924666b.8.1788530134042; Fri, 04 Sep 2026
 06:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904043724.2955444-1-s-vadapalli@ti.com> <20260904043724.2955444-21-s-vadapalli@ti.com>
In-Reply-To: <20260904043724.2955444-21-s-vadapalli@ti.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 4 Sep 2026 10:55:19 -0300
X-Gm-Features: AcwNN1WkMLBcSKjjx-549nVRZ1ZETkJHm5sDyQYa7o61EdbIDExabOintEMeFfo
Message-ID: <CAJq09z44PfcEKsoH9eP+c5rxmzQ52hQO33k8sO-e6po1bpE6rQ@mail.gmail.com>
Subject: Re: [PATCH net-next 20/33] net: dsa: realtek: rtl8365mb: Remove comma
 after sentinel-entry in match-table
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: dario.binacchi@amarulasolutions.com, mkl@pengutronix.de, 
	mailhol@kernel.org, msp@baylibre.com, florian.fainelli@broadcom.com, 
	jonas.gorski@gmail.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	kurt@linutronix.de, hauke@hauke-m.de, chester.a.unal@arinc9.com, 
	daniel@makrotopia.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, ansuelsmth@gmail.com, 
	linusw@kernel.org, alvin.sipraga@analog.com, clement.leger@bootlin.com, 
	justin.chen@broadcom.com, dlan@kernel.org, rogerq@kernel.org, 
	hkallweit1@gmail.com, linux@armlinux.org.uk, rjui@broadcom.com, 
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	opendmb@gmail.com, andrei.botila@oss.nxp.com, wangruikang@iscas.ac.cn, 
	amadeus@jmu.edu.cn, kees@kernel.org, tmshlvck@gmail.com, c-vankar@ti.com, 
	horms@kernel.org, vadim.fedorenko@linux.dev, daniel.zahka@gmail.com, 
	nora.schiffer@ew.tq-group.com, v-singh1@ti.com, oss@vassilevski.com, 
	haokexin@gmail.com, alex@sverdlin.org, aleksandr.loktionov@intel.com, 
	lgs201920130244@gmail.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em sex., 4 de set. de 2026 =C3=A0s 01:39, Siddharth Vadapalli
<s-vadapalli@ti.com> escreveu:
>
> Since sentinel is the last entry and we do not expect further entries
> following it, remove the comma.
>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/net/dsa/realtek/rtl8365mb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/r=
ealtek/rtl8365mb_main.c
> index 4c305756116c..f8220d832e46 100644
> --- a/drivers/net/dsa/realtek/rtl8365mb_main.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
> @@ -3352,7 +3352,7 @@ const struct realtek_variant rtl8365mb_variant =3D =
{
>
>  static const struct of_device_id rtl8365mb_of_match[] =3D {
>         { .compatible =3D "realtek,rtl8365mb", .data =3D &rtl8365mb_varia=
nt, },
> -       { /* sentinel */ },
> +       { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, rtl8365mb_of_match);
>
> --
> 2.51.1
>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
