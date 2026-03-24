Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FDE27EFEE
	for <linux-can@vger.kernel.org>; Tue, 24 Mar 2026 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344808; cv=pass; b=o3lc8WNbxFBw/a9mhdXPrEk4FhZMNK4Ba5kbXJbSuuOFBaVDBDUJfU5v+7Lzp3QejD0f2Bh4F81Mjyt8SBicpr+3snaAYAZLGHpKia+ffC57bb69vbrSA6Vo8ZTNxqhU1v62baAa90aE+ZuU+rrQ0gSEVAsToHmf2kgYV73MzK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344808; c=relaxed/simple;
	bh=bDL2C7mza91hZFUZjSYZMBWmX2qUzuJZPIzsZjG+d1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zj8NUQzvnNF6xfz8i3MAl/GfJQNoBQ2WXoGyzX8YlseHTwLBE7SSlQvMl3QT6sVeFzAvML3bDsb+HGlxtwpQzQL0NV4K/+PlYiPJeLeAvdxS6Co0SGMAKGBfUeZj0aIzBssQqsKFQdCgGJ9kwtKxYfbKtitffON2zX3O2HwNwMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d468KPmm; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d468KPmm"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b936331786dso570714366b.3
        for <linux-can@vger.kernel.org>; Tue, 24 Mar 2026 02:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774344806; cv=none;
        d=google.com; s=arc-20240605;
        b=Q4SLlQP9dzIQkROJXgcehcM32ehj8qcCgpJJl1jJTD2XyVFidEaeQvFolJAi/OWTi2
         Q6C0g+nu5ek278cYRlc90rHSmvpFYkl1lDBzfKeKjh7l4iQjWlglCde2AL45yrgKao1B
         bEZt4EfMTwh5obGNKftL599PFo5517BYZkFTQBI2KC1JSE18IL4A/iSypcniKppjc6HN
         K2X4EZqo95HH1tQr6rILgkqdZQFrCItF2LX3Yqhsq/0LHNij/iTkj6qUplQ1cZD5c7T6
         QI+7mnehSNaNZFhFDy7kwPZVGpnFvi9VcW/HlKPmBlSutC13gUmhzCpMxlGJ7yTX9cIu
         AP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QmOoMew7a+4iasBok4bNZ2GryV9GYB9QXm6gLc3IXVA=;
        fh=R3wNM78gnJQ33YZCGyeQk38op1nN6gUJEA7wQKF8iF4=;
        b=Ec1PDND+JiCAKU36GLIBzQ0qmLDnGqskB3eoQz4j7QhyvFgE6BbuLrQLRgre6LOnvW
         ZCI24yNzheBPoJiKSGyUY82gKKTNs2xnWiO0zMW0aEKSEnsAg2TMx0pmDEQOnl7CttA2
         tgM3kBUUxu0Icdyga2fSKn1MtIhALp5Vkv5zfi7/o+X2Ijhp3D9VXy+sL59jPMdUSDJR
         Z+9y717URM2T6wy7sHrzzTsuHYQdGuVWjmVgiJeGjlu4ga9exJWzTmQusjM9EhfLhdcv
         3+o8gcdHrNbLkeD9/8/IpBpzAQw3Qc0/2/kABFwtzCWKE9N3REJn5TsFmnq9rS/SW0Ly
         k1Dg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774344806; x=1774949606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmOoMew7a+4iasBok4bNZ2GryV9GYB9QXm6gLc3IXVA=;
        b=d468KPmm4tRBSVZO9rJMWefbcB3Ygd9mK5xTm9p9N65jACpF65eBGCXKHz1oBc0f1Z
         afx3lVwhu4LsQtNGJ/B+YeWPMJZrHNso8lXZgMwe8zvJGNdY6wWCNx9Tqhr8QJNcaMFu
         x8j4HZEtxnz04WKExlKqX0g79Bxv75wRN14p64PGJjH6D1Ch19A0w1Rxv7jwdSCcdDWA
         +UPtTJiVsaikh7i5TGtBH+XcJFPZr6Fwy8IIpeS5zldEAANvN3DjRNDUNm32SN/KFBaq
         55K7e6OiwAwnS9+1+XF6mWqT0CluKQT7NQ+3zaH0NeACxj8pg19rpfpXbe/rU3xn1Bxi
         iMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774344806; x=1774949606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmOoMew7a+4iasBok4bNZ2GryV9GYB9QXm6gLc3IXVA=;
        b=AAg2wS9+y+ctIWetteGbGp+f01KORIkBYi/n8iFUTwfg3wlsTeHH9bmgdCAZ6YHiTx
         tJqYNXOLxtdI8QmVp0pf0HCEJUfFfEavGQwdSDJrXtPaypIHY3Izxn+iQBgGF8W217dp
         rZInfarD1wRFeHuR39Q5KUpWjexdT1+pvYA15Mm+jbGo0AzfThXmkJmzolo1kTxp7pcN
         2n7Cps+kVno1qY4GcdLXq9zDAkIBjI7JH83xHBhQ2/6ivR5UeSZYOy/5IbNv2x9QO7uR
         C8VejlDxL3Hj9UjaTDlyNmOOeTQtJ79OMFB3cVj7Obgh4sVWI/yp0TSRNgi5BlInG/uS
         gVFg==
X-Forwarded-Encrypted: i=1; AJvYcCX7Xph3WkvbszsJ6hvLbfBeDnh5aDKtqoSxoLtypY8TtLXzIvcC6ecGa7I7pEc1gzv/HZ0OOFCfdJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/O2JGsarUKJridT/P26VB/HrqzzzcmSApXwxAOqU22gXGixC
	5Gkj4kh8zp5kFCeT4Oj3iZLpb77XOvjwRdWpAC5V0igO1twoPPDAu93+4irKvC6qGy5pfoxyVuV
	G0I7HhhyZyhtWqS6JWFRvH5upnTv8t+C+5itGdKA=
X-Gm-Gg: ATEYQzx4bZBscI8bjVWUGffxom+uCMdt4YQ9OUrxpLXRfIz5KN+V76q93RncdmlrA1c
	tvKlrRRAakNpa6ihIChmk5sEhRWCzjeS1CwYmicuLRI3ibacwBph9v0j8E0FhvLpo62nq+UImyP
	8436hqkYzlWVNjzmFnzT1AGPGMvieT0uJrc1+4axHquim9+Tz+bKrVXxgJYqTKHJ+MWDmgArnQM
	qR4dnPP1L95HRYWlUToM4GfppX0Y35VmSaqvzHBrFqhK/ocTJwNzXia2mxpA7aeEvswe0R3GIG3
	M5Chp0FCqg==
X-Received: by 2002:a17:907:cb89:b0:b93:80f3:b356 with SMTP id
 a640c23a62f3a-b982f0aae80mr1034617066b.8.1774344805467; Tue, 24 Mar 2026
 02:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL_bE8LVpMAoSjCzRiNU76mJ1SSZaBUhEsAURpcgMxg5E7y63A@mail.gmail.com>
 <20260324-sambar-of-imminent-kindness-a52869-mkl@pengutronix.de>
In-Reply-To: <20260324-sambar-of-imminent-kindness-a52869-mkl@pengutronix.de>
From: =?UTF-8?B?6ZKx5LiA6ZOt?= <yimingqian591@gmail.com>
Date: Tue, 24 Mar 2026 17:33:12 +0800
X-Gm-Features: AQROBzB9iwmpyreQhk8pfYmbuUVjVFha9astkEzqE7rudsJiJH1bUSp_fhDdReE
Message-ID: <CAL_bE8Lvib_HVka_Cq76CcPJVQ1z1o__eNqnSWjHVhMumoszEg@mail.gmail.com>
Subject: Re: [REPORT] net/can: can-gw: UBSAN OOB write in cgw_csum_crc8_rel()
 via negative result_idx (uid=1000)
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: security@kernel.org, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, it is working, I'm sorry to have taken up your time.

On Tue, Mar 24, 2026 at 4:20=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix.=
de> wrote:
>
> On 24.03.2026 11:51:15, =E9=92=B1=E4=B8=80=E9=93=AD wrote:
> > Hello,
> >
> > I would like to report a reproducible out-of-bounds write in the CAN ne=
tlink
> > gateway (`can-gw`) checksum handling code.
> >
> > ## Summary
> >
> > In `net/can/gw.c`, the CRC8 "relative index" fast-path (`cgw_csum_crc8_=
rel()`)
> > computes absolute indices (`from/to/res`) using `calc_idx()`, but mista=
kenly
> > uses the original potentially-negative indices (`crc8->from_idx`, `crc8=
->to_idx`
> > and especially `crc8->result_idx`) for array accesses.
> >
> > When a CAN gateway job is configured with `CGW_CS_CRC8` and a negative
> > `result_idx` (e.g. `-64`) and processes a CAN FD frame with `len =3D=3D=
 64`,
> > the function passes its sanity check and then writes using a negative i=
ndex:
> >
> > - `cf->data[crc8->result_idx] =3D ...` (negative indexing into `__u8 da=
ta[64]`)
> >
> > With UBSAN bounds enabled and `panic_on_warn=3D1`, this triggers a fata=
l panic.
> >
> > ## Affected Tree / Version
> >
> > - Tree: upstream Linux `v7.0-rc5`
> > - Commit: `c369299895a591d96745d6492d4888259b004a9e`
> > - Arch: x86_64
>
> Can you please re-check with b9c310d72783 ("can: gw: fix OOB heap access
> in cgw_csum_crc8_rel()") applied. It's included in
>
> | https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git/tag/?=
h=3Dlinux-can-fixes-for-7.0-20260323
>
> or:
>
> | https://lore.kernel.org/all/20260319-fix-can-gw-and-can-isotp-v2-1-c45d=
52c6d2d8@pengutronix.de/
>
> regards,
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |
