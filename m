Received: from a9-39.smtp-out.amazonses.com (a9-39.smtp-out.amazonses.com [54.240.9.39])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE882E7390
	for <linux-can@vger.kernel.org>; Sun,  6 Sep 2026 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.9.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788692569; cv=none; b=CMo+h6xnHAouclfx98uYyIcroZHBxdUdOGlbzL/mGGGsNAhD9hlkikpA5X+3Nadc/A8kDB1eJY80a0r8EYGA+571aCI2AJ6XkEDOlYrg0T4nyY+EmwOuhFQwbtLvuMfhV60gfHBjTMSQ/nz0tTBKYado/1w41sbDNo6Al+FfZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788692569; c=relaxed/simple;
	bh=4feoQCNVJ9J2oahpqyBpgAsCLQMZvyiLjOF5pjK9Isw=;
	h=In-Reply-To:From:To:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=OUBtal512VK3g0QdJzdavJoIrnJkCcVT3JfnJnim/IjqJJUXFt4kzD7u8VUJjy+gov/otIMCfMswX10sNahx7rA2QE4ZqwleHCTSe12saNtgvn3wixF7kwqBCNm++uXMwDu1f/QJg0s7ckqa/i5Li96TfQ8Nl00vWMrPHrVMFzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh; spf=pass smtp.mailfrom=send.bugs.sh; dkim=pass (1024-bit key) header.d=bugs.sh header.i=@bugs.sh header.b=JrXirx8D; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=HTjiaSkl; arc=none smtp.client-ip=54.240.9.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bugs.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.bugs.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bugs.sh header.i=@bugs.sh header.b="JrXirx8D";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="HTjiaSkl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=bugs.sh; t=1788692567;
	h=In-Reply-To:From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=4feoQCNVJ9J2oahpqyBpgAsCLQMZvyiLjOF5pjK9Isw=;
	b=JrXirx8DFWTAjb2hfG7cdQJviRoYO3lnW4bP7GKLct1eJV/IQbuYNDW1G7VXLs9M
	kDhGiXt2vpATG2mhxvm8xb8tLiIX1oILCjyezqF4HtkMmpwtHQG8vvWpO9PqlTko7Tp
	psokF80pz5oiSaFBm3ol9O/T7pT7Bp9Jca/m/VBo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1788692567;
	h=In-Reply-To:From:To:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=4feoQCNVJ9J2oahpqyBpgAsCLQMZvyiLjOF5pjK9Isw=;
	b=HTjiaSklEm3KRxRE+FKAOhMOgG23DmFOoje3rx46VVNej90C9Eo8ySGMfhJR+f2y
	viHNBlrqaViCPG6qnzQFP630Zn7tUu0pxAu4m1Dr2+x9DTsscqbzyjXKnO6msZDdiiC
	yoqPUFnFfVu4rhbib3T9icAQm350xr3koqpPpl7g=
X-Forwarded-Encrypted: i=1;
 AKwUvBzbY/zEZ8cVjc2RRWIpQ/msYki4I550aC6b8uUfVy5CiVdbpmAcZ5BwCyP3blqRX8rd64ovrLnuf1M=@vger.kernel.org
X-Gm-Message-State:
 AFuF++lVfZO2HjtH4o+vkIsOoNuh0I8lIJN77Qt5uz9lBcKECrk9Azb7
 kM5ea9kh6EMpwEQR0k6MTsMOg9sPOvfbMOML/lzKoLqc+R2BkzKKU0ebH9rsxT4yopzNmO6i0EI
 xk+jQEPkGPv0C32GTgY0wzHb4a3KqxfY=
X-Received: by 2002:a05:6402:3819:b0:6a7:ee55:dcda with SMTP id
 4fb4d7f45d1cf-6a7ee55ddb2mr4604219a12.41.1788692566019; Sun, 06 Sep 2026
 04:02:46 -0700 (PDT)
In-Reply-To:
 <CAMuHMdVVqfqvueX-jk_XfM5tE9XScZPe1OLqGw1MUC=Kd2reBQ@mail.gmail.com>
X-Gmail-Original-Message-ID:
 <CAMb7gs-C0PpqJ6ixMeoz8PXaLd6+7WY3BS4srLGza4G4fJ6bGA@mail.gmail.com>
X-Gm-Features:
 AcwNN1U6ph0YcQrKA1PISLuvbcjZNYhUcVvuWoTrrhYYY1PS41fYVNW2cVaZTwg
From: CO <co@bugs.sh>
To: linux-can@vger.kernel.org
Subject: Re: [BUG] drivers/net: out-of-bounds in pcan_usb_decode_buf()
Message-ID: <010001a0766295f7-878fa057-9657-4fcf-a285-83880a450b8a-000000@email.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 6 Sep 2026 11:02:47 +0000
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.us-east-1.yL0noGNZdXCKlJHw27bHz8/I7/GZTaYDRe4l4bGvzjPa1Q4S+kzxKgpyYIxfCxOFAjHX6QJhZdsZN1SP8V3NfEiLJ34m58z2/mmJDZ5RtdRTZ06dzneIWyoUkJ1DSaTbU2HlPz+Zb2/NZ41D3j4FLWNy2FyGjUOa4qpft7gzKcs=:1.us-east-1.QSNtDRXSTq9sAuvRl56h5mypgasnQ5yDLNpVzTnziu0=:AmazonSES
X-SES-Outgoing: 2026.09.06-54.240.9.39

On Sat, Sep 5, 2026 at 7:04=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Co,
>
> On Fri, 4 Sept 2026 at 23:17, co =
<co+5e2bcf11e7027510@bugs.sh> wrote:
> > We found a bug reachable in:
> >
> >     path    drivers/net/can/usb/peak_usb
> >     crash   out-of-bounds =
in pcan_usb_decode_buf()
> >     commit  2f1baf1fc892 ("Merge tag 'trace-v7=
.2-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace"=
)
> >
> > Config, environment, the sanitizer report and a C reproducer =
follow.
> >
> > =3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >     If you patch the bug based on our artifacts, a tag would be
> >     appreciated:
> >
> > Reported-by: co+5e2bcf11e7027510@bugs.sh
> >
> >     Everything in this mail is validated by the reproducer below.
> >
> >     We also hold an LLM-generated root-cause analysis and a candidate
> >     patch. The patch passes an A/B test: the same reproducer panics the
> >     unpatched kernel and runs clean on the patched one. Neither has had
> >     human review, so both still require validation before you send or
> >     apply them. Available on:
> >
> >         patch.diff  https://bugs.=
sh/b/5e2bcf11e7027510/patch.diff
> >         report.md   https://bugs.=
sh/b/5e2bcf11e7027510/report.md
> >
> >     This is an open science project=
. The code and the full set of PoCs
> >     are not public at this moment, =
as we intend to disclose our findings
> >     in an ethical way.
> >
> >     Happy to test patches. Complaints and suggestions about our work
> >     are welcome at:
> >
> >         cedalion@bugs.sh
>
> Please read Documentation/process/submitting-patches.rst, especially
> https://elixir.bootlin.com/linux/v7.2.2/source/Documentation/process/subm=
itting-patches.rst#L928
>
> Thanks a lot!

Thanks Geert, for the reminder.
We'll learn the documents and make sure we follow the documents.

Xiang
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- =
geert@linux-m68k.org
>
> In personal conversations with technical people, I=
 call myself a hacker. But
> when I'm talking to journalists I just say =
"programmer" or something like that.
>                                 -- =
Linus Torvalds
>
