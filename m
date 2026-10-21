Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.219.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792565174;
	b=b8tain78GAtYCu5X0n/IvfOValWLTttm+/2peY1yrOqzlPE9T7PlTBI+MWFwXeXE84dD
	 5Dg4p0mGQILAqcUsrj6ccGwrjpwBeLge9mWPD7aUFYBNIqkgqx+wjGTqF0sDg2eJ/nVIZ
	 2VnK5nsgYnQ7J1vrm5qXCkjg3OQsDFbgXPtQfN2ycdQCSndguIVemoIAlfbJIaQnNG0+k
	 3RL/bO8kquRmjGfWdYIkfxa0drfP+rUQYAjA1SxYExqhZlvPkuoEj4wtPLPWvZCDi/cmi
	 Ll/sGOm/Ur1WGI/JVn14LE0AEMdVmvqEAzdL1Xd3CalBoZHPPK6t6aa3JkGGbfWNQaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
	b=FSnubFDx+pNmEUnfilZ/f4UAeeqtrUmyhmE7vbkKmziuS3XGwomMEx5Nsn4BwKCPaemx
	 pvl1TK/n/mdn0xepiteGTGmp/QsqmQRKG1WYISHsVLf8JGd0UyFtzQrpt5jL9crTVMy7/
	 TC3Acd2McUvDE38DD25/YwOHc8PCizsJBhkWszZRhiHmIJly8oE2uGbGx7YGOx2PmYPFH
	 eL/2nnA8K/LdM8Ybkmm4mmJdACSEw00THIhmxyj9db8UOUxJz0hjYFPPnepYPBt5UW5yu
	 8fPE1sUsP/OaXSx6T+mPCjyCATLWfUaYTBIjiMJRYItcaHCUUcMr98ztOZvgAyJX0Lg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N3K8Bbb9;
	arc=fail smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA1D606A320
	for <linux-can@vger.kernel.org>; Wed, 21 Oct 2026 06:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBA1D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N3K8Bbb9
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-917aca1aee5so4754046d6.2
        for <linux-can@vger.kernel.org>; Tue, 20 Oct 2026 23:46:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792565173; cv=none;
        d=google.com; s=arc-20260327;
        b=Mt+WyzQJ7DXqKtOrM/FCdmjUktDpkl6DnY7z6g6/tcLoYQi/eefkNsK3p1NhUZB7EF
         MZQjy5zXpWdiFb5uOtd80hgJ+zKQqM3AVe+YrKSkEgiu6Kss9MjLM4jb3VbCGe9jNQfQ
         lDDrspdy8j9GN8ELUk/oVgHzt/vcdVAFsxey6lBLenIoZGFO80XhW96bAOq8bsz63naZ
         HnMibUDVJjeeZpboMMABG9QtDyOkIfzxK+i9j08ZUUA0zSWSBoYUBH68946FWpqUdZ8Y
         r02L0eV3zyOz+kLWV64Ki0p29ut4q/cdnvY1VHMuwxdD+w8STk0dG+hZCm+wBMAafG8d
         4IMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
        fh=G01CJrxFhen9jxvswFAXzZ0jVxHcn1MgyJD4tLcCBik=;
        b=ntUkR1/csUNNnJM0Hn4Ki6aBsW7qL04zjR5MuUwFRAoJtrR9WWFug/ydPd/qvC3F5B
         YDJwjLwAdCQBC1+KBxBq9T/2ODiwtqhxkVsDit9YYsGa3vE9kFoByHM0NGN4b8/4VN8B
         TCuJias2FOiaVl1Y3lH7lJCmHZhSqmbwK3jXh5TilRRWOaKevEf9PFTOYF9J0jlBiv92
         Fklh0KaoKeoPWb46br00tDyqpSYda1uxLuiVRQuoCm28aOgnxHULH6GNjru3hPi2avoE
         mTj8p+YlJKFuq2ljUge/O0ZROwUP9GW/NProFMzZsSx/N6AljGx0Y5ZJZ5uS4npNQPHs
         pRfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792565173; x=1793169973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
        b=N3K8Bbb9tNmHLFt6ZXFDabkPNwYz0MlgUzh0K/zfhr2yAjtdkvQ+atM46OurewOaR1
         5GpHZ1w3HZLexrrVA23itcwJ6z/A3tv78GFsLEvhUonkAC/73dFWQMqQxs4AzcszUoAg
         QywB+6q06BHod6vzHnLg7lTEveFPsMcBeMrLr3fmzfBfZu7SyUZlS+rtU0CFP/tt5s8g
         rXTl04SHDbrB/z7e3KtddFWqAgqZuw1vN7ipKBmLQJ+HhmthCk+mdogVDq20OH2zdFz9
         er4Y6laPpOvP7dFZUifXCwXVCDWoAe8f6eCGE6CSv2DC0EwRrBbnT+ttWzNfLh3PEE/8
         ufzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792565173; x=1793169973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ijjheEMdAZYOTtTGE4e3W26/a2l3yNs/YuDbeMhOKVg=;
        b=YdWo/0vv1bDl4/sPRUiZ8OZaAHWD1U2HH9DxwTsvlQ+TV0RhVvcSh7mBSeLeiwhZy8
         xTp0/h0RtTGOGclfe9TWj7OK5qe3r8yXKIZyfyCetAa3x3ZzeQa4AgrRKsCwhFXqliY4
         AmcBpuHhb+89ixwe3SdDSZIPYHzmtQml7cNklBSF+ssX1nQYCMM/mp3woAlf300e5+wp
         iXxz0Jrv/wtwdVJuR0rPERICgH7TzP1FRhV8QSQcCIN1nx3xyW9a3DFWIiXN6igRsUzf
         Fcz5+wHmsBdf2WPeruAz6phztAOaLbDFYesR9L4xzuN3HaIAeCukpilwAzxWIMl8+4fM
         TbPw==
X-Forwarded-Encrypted: i=1; AKwUvBy0AXY9NRSv2+VmYT2ILALpFmb7FugkeDGNv6u+d1rlo5n2VcWcBj+jEimyvW3wpW3BaypfSIhN5Uk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLvs+/E+uQCZItwdUev/UvJLL7INdn7b/Cdbp7HgKD/C8bRbjy
	uanOBE9lV1VH2RpA/vGS4QDykHWbpAJDK/s0ZhoPSZLqcueYziz4D7OSkbnDwUdN6Qo7fL1XZ4a
	Sn7qOAnP8+oWI3wZVNPdCoLEOVWuPVIg=
X-Gm-Gg: AYBFou22QCsD688lfaaW4X8PurOku/TTLQ0ANwC9usejbqoB3BKDID4R3NsztSuo8Ya
	RalMhx08narhgVpO/S41Nyap+/k1Y9tyTUv2kCz86eF2soKXgEVsuUqHd4y6zlMVd42AqauEYUt
	D3koWjJtDpoQkomzPhs6hi3ldNN8Za6jR57OhnbmwhF7UUiCBzaSFkpDj/b0OsWNWXhHSgG5zUC
	/iJI3xY1OCUpczl65Jp5y+GEHoMhBBdnpXPqf/APCasBNT8wBJNQSy6vttLTMlc3wQCZVXFzVfA
	J0On19CRwh3Jm8z7ImEXY23+oNPfEj5jGjSClNRIc8YHddkHPAIxWvi0COqUfgoNFGR2Y0Duv4L
	zeO5uusIaOEnMcn0jtPWlkFK2GpMWgNvPHSQ3P0NPJf4ny+ht3m2qANrFq6M=
X-Received: by 2002:a05:6214:487:b0:91b:cafe:58e2 with SMTP id
 6a1803df08f44-91c12eb7b30mr18765456d6.14.1792565172936; Tue, 20 Oct 2026
 23:46:12 -0700 (PDT)
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013063259.2734757-1-a0282524688@gmail.com>
 <20261013063259.2734757-6-a0282524688@gmail.com> <sashiko-outbox-169117@kernel.org>
In-Reply-To: <sashiko-outbox-169117@kernel.org>
From: Ming Yu <a0282524688@gmail.com>
Date: Wed, 21 Oct 2026 14:46:01 +0800
X-Gm-Features: AclHuK_sk3N3reGEV1vFqkhXmWhSRT0CO9e7SvF9FhuKig6lX9RUqvijqALmuJY
Message-ID: <CAOoeyxWNsBt6nDn82bCv0DUpar3c_K19su87UEbjm4CfCJbbHA@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] mfd: nct6694: Move module type macros to shared header
To: sashiko-reviews@lists.linux.dev
Cc: linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, mfd@lists.linux.dev, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Vincent Mailhol <mailhol@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, lee@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<sashiko-bot@kernel.org> =E6=96=BC 2026=E5=B9=B410=E6=9C=8813=E6=97=A5=E9=
=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:40=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Low] mfd: driver-specific header modified in global include/linux/mfd/
> --
...
> > --- a/include/linux/mfd/nct6694.h
> > +++ b/include/linux/mfd/nct6694.h
> > @@ -8,6 +8,15 @@
> >  #ifndef __MFD_NCT6694_H
> >  #define __MFD_NCT6694_H
> >
> > +#define NCT6694_HWMON_MOD    0x00
> > +#define NCT6694_PWM_MOD              0x01
> > +#define NCT6694_I2C_MOD              0x03
> > +#define NCT6694_CANFD_MOD    0x05
> > +#define NCT6694_WDT_MOD              0x07
> > +#define NCT6694_RTC_MOD              0x08
> > +#define NCT6694_RPT_MOD              0xFF
> > +#define NCT6694_GPIO_MOD     NCT6694_RPT_MOD
> > +
>
> [Severity: Low]
> Are these driver-specific module type macros only used by the parent and =
its
> immediate children?
>
> According to MFD subsystem guidelines, driver-specific header files shoul=
d not
> be placed in the global include/linux/mfd/ directory if they are only use=
d
> by the parent and its immediate children. They should be kept local to
> drivers/mfd/ instead.
>
> Does this addition of driver-specific macros to the global header violate
> the subsystem architecture guidelines?
>

The sub-device drivers under gpio, i2c, can, hwmon, rtc, watchdog and
pwm also use these definitions, so the header needs to stay in
include/linux/mfd/.
