Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3A01A681B
	for <linux-can@vger.kernel.org>; Mon,  7 Sep 2026 21:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816918; cv=pass; b=BlMfP2tcxjQ7lyJ+Anmm1jzUAiJZrK/qyXv4e1ahiB5mhujbBtL/FnzOJ8UXkteHnEwHI8PfUkC8qQZbub5wa4zb/gcDXsXHmq6SwJ8VO8qb2T9cdZ17c/IE2q8hJfgSE0Zo08fQu9guVc2Di9igLv9vro8z4DnN6lBt7nfvH80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816918; c=relaxed/simple;
	bh=Sm/J1wtsrIqUkVPiFC4lIflqwoIA1NdiD66VgeNqNM0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9/Rh9O6U8X2n5q7Z/oXrgTkO/Y24P7PnXzOF0okz5ELrZnMJxYXd+UKix2mIcNOaau6VXqwLuqniIaq7fkf9qavnHWV1Hdc1BFL7JcKj4s1lldHYAZvvjwOElw0+kam3qCLev+ZShVLUdgBGvfNTdsSvNOqWMYNeCutEhCBxpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=Ya2GiaK+; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="Ya2GiaK+"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso3403461b3a.1
        for <linux-can@vger.kernel.org>; Mon, 07 Sep 2026 14:35:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788816916; cv=none;
        d=google.com; s=arc-20260327;
        b=AAGyQQanIqVJpW/Yt8J9TAYGDt1gfOwoGN4Lk5LGeuu4AXzlaTo9RQ7/UBmo0+8o6E
         2UKm1IALy7NoImOIOWmj1hoMPqlsTMYTHgjCp3MX0TVTADM21pPheqOp9IRK5btZMDos
         azJtIelhwNXT5tcQF6qPfseCtJ57FA4fZ+YvLQ+tdoNgqZ2lvYVqb+6yx8ZIbN/no8OA
         bFcAGlrSg9Vuthu5Uu2FG9jFOzo99twByO8K2OaNmTBPxUn//H9QK6SeMnoY3Oi5c/DO
         /jh9zj3qsqMQuACzTDPNBYbm/5b2FtidQJZa9Vfxfs1s9mOswhBgpRJPptRaLMouWKAE
         L2OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4wvEN1rc0XoTqR7nkp9AN+9CTT9FOkWFzpWDnUbtpss=;
        fh=pKOB+iEnQlMpfZOjysEv18iWG4EKJG+fRfuPeeY8kFk=;
        b=Xah1cjcCLWRoVChp0HsKn3D6xGO6X69Q0vicBaRFszsyMJ/0wOmfN0UrwkOQ2oFyJ8
         QlaikE349RsYwkZFY1B4i+t5FhZbajTAZBWr2/gDJ7HebJrrwszIeJaMRzfEhF3uRaX9
         56KQUsAQT1TqbwRVrfDb8Yu/aUEY6DF45Xk9O8+tATQvxz8d9k+0YvCenTmQzpc8iUrh
         Fl36oX29zJf7sYmaYzAk2FqVZvFoGReBuNF8eRNcLDggomO8BTL/2IRlV/l2duWpsuD2
         ZReUWz5vozJF5ObWV0D+nMfoR7gSsXDyh3uFfgnXH6nIND9/siFWBHq8ILRr0Tqm/1Sq
         wZGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788816916; x=1789421716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4wvEN1rc0XoTqR7nkp9AN+9CTT9FOkWFzpWDnUbtpss=;
        b=Ya2GiaK+8AJTfbr9Rv7gtkxkv7uSVYAJung/9mxUEeojJcWzaw0+LWJo6Ml4+xl+LS
         IE60j2KXb8evaoWMmdf+XYG5kQjLgTiU+k5rDAFC//vXNN0dHWudX4ADHsLc8KK2ZrNH
         cKwoNPFvKGVPrris71tUrwBvGVw1E2A5aoghAfDuihO8iUTxedD5FKFvKiGmn3ce0+Zy
         DzrEnjMUYZwM4H0cDuCYbgckN/QgpnnLqx+WW1j1X4JMwsfs69mP42QkKnHXt9V13yuh
         iO08bOV+XBolOwgZNWSjtzLJYQle1ts21J5P43yvoeyn7WSdimz7KiEuM5/RZdPaBghT
         eIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788816916; x=1789421716;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wvEN1rc0XoTqR7nkp9AN+9CTT9FOkWFzpWDnUbtpss=;
        b=p479SjjUTLpkTUwazNnHC9fm6TiEoLELXuSvZ/oz7aC9+LkjEg0/EaroYOopVxqE9g
         ranAQ520d9HLsMzq7Krdw38TUqSwP6rHAAyNuSwHG23LfxypcRMTYt18UjJCDK63DjqQ
         QxcbJLyqQtoTvP0A9fLAiNzQeIVsjwC4j6nCx5Ok+xotwzCNox8uBve61kjBTekKqlt4
         cGYWhGjUZsM7JrA/DOjMKmaYPdSavOmnn+5cPotVcQt18iDhxuaK6iZLaBScZCBrEY3x
         SaSw+wFvFGFYrOletmk8l77V1fm04puEuHeKtZebbA9RpGmYeGECxswexOnUfI44qQml
         y5+w==
X-Forwarded-Encrypted: i=1; AKwUvBzl0Y7UIqixSWsSdkdiYG9GJ3QRGa/1Z/Xauaq65f8OGUSKaFlbnNVdpUsOOh6ZV+zkKlhp0X0IyRg=@vger.kernel.org
X-Gm-Message-State: AFuF++lCDbW7DOFPGN+67jI/A5fF0BhZw7P9NdCNPPtWQHOi3EyNXauA
	0WTULhvC3VLbwaKgnfHBbmgITuXS05+V02YxA3Tl1WpXjydVpNGD02cA59a1/hsgGiALOsvwsY5
	4IFveSi52teXPzXYYpN54jXNRMV1d5Y7FN/Fs6HmF
X-Gm-Gg: AYBFou3vtpt0/GSGX5iceKXbXNNvMEf3w78fr6vPYHVaJ51wE5zk+Od1T3JHJRhfbEb
	HVSazbPi3m7jlMeRiYkJOdZ2gb/x0kAszhLJS1ctPc3UtG7OovEuq+N0kIrPTgSOw0V83UeOtTP
	olUjUXlBtktIpvlND/RQ/rVfaNMAOzg8NBgRcoVRK4G/cI4IksjQWsaMhf2/TVjZW5FFjbvcqLI
	ginL+vAsh5C3bes3M0VZhB056Gbm530lJ3ypg9NHeHOZu5ejopholv/TzyqwgzwdlmM/2h7jQtC
	s8M78Bg8kt7Bsy1SHMb6XxhOzQ6lGiQBwHL7sikpnk1Wys+F2uqr4TzqG7pbFVkTxLP4Oyi4VTo
	=
X-Received: by 2002:a05:6a00:7705:b0:857:73c3:446b with SMTP id
 d2e1a72fcca58-85fff0cf277mr22406237b3a.26.1788816915742; Mon, 07 Sep 2026
 14:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <upsCxxaJjg2FJWhfCx6KjFXLlh8o4IhaHKJi@bugs.sh> <CAMuHMdVVqfqvueX-jk_XfM5tE9XScZPe1OLqGw1MUC=Kd2reBQ@mail.gmail.com>
 <CAPpSM+TXw-BGgpdZtx-bH5GEQvzYHxj_wDkdPfUT3Tcn=mtmEw@mail.gmail.com> <CAMuHMdW5Zux92WES0REoejf5FO2h9KgRDCcLbN-A_kyJyRTxCg@mail.gmail.com>
In-Reply-To: <CAMuHMdW5Zux92WES0REoejf5FO2h9KgRDCcLbN-A_kyJyRTxCg@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 7 Sep 2026 14:35:05 -0700
X-Gm-Features: AcwNN1XAVB2_zHSqHk9OYAeFu6WEmpXutR6V5_IuRKLsQI6uDVNe7s7y---6HGQ
Message-ID: <CAPpSM+QNdSFyDwvPs3NkguaLsmR4iY7w01Z=WGZ0k0y8jzzhGA@mail.gmail.com>
Subject: Re: [BUG] drivers/net: out-of-bounds in pcan_usb_decode_buf()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: co <co+5e2bcf11e7027510@bugs.sh>, Vincent Mailhol <mailhol@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
	Oleg Nesterov <oleg@redhat.com>, Biju Das <biju.das.jz@bp.renesas.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, cedalion@bugs.sh, linux-can@vger.kernel.org, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 1:28=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Xiang,
>
> On Mon, 7 Sept 2026 at 00:19, Xiang Mei <xmei5@asu.edu> wrote:
> > On Sat, Sep 5, 2026 at 7:04=E2=80=AFAM Geert Uytterhoeven <geert@linux-=
m68k.org> wrote:
> > > On Fri, 4 Sept 2026 at 23:17, co <co+5e2bcf11e7027510@bugs.sh> wrote:
> > > > We found a bug reachable in:
> > > >
> > > >     path    drivers/net/can/usb/peak_usb
> > > >     crash   out-of-bounds in pcan_usb_decode_buf()
> > > >     commit  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.=
kernel.org/pub/scm/linux/kernel/git/trace/linux-trace")
> > > >
> > > > Config, environment, the sanitizer report and a C reproducer follow=
.
> > > >
> > > > =3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >     If you patch the bug based on our artifacts, a tag would be
> > > >     appreciated:
> > > >
> > > > Reported-by: co+5e2bcf11e7027510@bugs.sh
> > > >
> > > >     Everything in this mail is validated by the reproducer below.
> > > >
> > > >     We also hold an LLM-generated root-cause analysis and a candida=
te
> > > >     patch. The patch passes an A/B test: the same reproducer panics=
 the
> > > >     unpatched kernel and runs clean on the patched one. Neither has=
 had
> > > >     human review, so both still require validation before you send =
or
> > > >     apply them. Available on:
> > > >
> > > >         patch.diff  https://bugs.sh/b/5e2bcf11e7027510/patch.diff
> > > >         report.md   https://bugs.sh/b/5e2bcf11e7027510/report.md
> > > >
> > > >     This is an open science project. The code and the full set of P=
oCs
> > > >     are not public at this moment, as we intend to disclose our fin=
dings
> > > >     in an ethical way.
> > > >
> > > >     Happy to test patches. Complaints and suggestions about our wor=
k
> > > >     are welcome at:
> > > >
> > > >         cedalion@bugs.sh
> > >
> > > Please read Documentation/process/submitting-patches.rst, especially
> > > https://elixir.bootlin.com/linux/v7.2.2/source/Documentation/process/=
submitting-patches.rst#L928
> >
> > I checked the document and the related files, and I apologize for our
> > mistake. This email should not have been sent to you, as our system
> > failed to identify the correct maintainers for this submodule.
>
> Thank you!
>
> > We have fixed the issue. Thank you for bringing it to our attention.
> > If you meant other issues, please let us know.
>
> There are other issues, like not sending patches inline, so they
> cannot be reviewed easily.
> Thanks again!
>
Thanks for the feedback.

The patch is entirely LLM-generated, and we don't want to =E2=80=9CDoS=E2=
=80=9D
maintainers' time by asking them to review LLM-generated patches. We
believe sending LLM-generated patches without human review is
irresponsible. We'll make this clearer in future reports and clarify
that these are bug reports and that the generated patches have
limitations.

Thanks again!

Xiang

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>
