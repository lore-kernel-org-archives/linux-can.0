Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1260538B7B0
	for <linux-can@vger.kernel.org>; Sun,  6 Sep 2026 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788693574; cv=pass; b=MprN4Fm7gTptNfNRmodi013IZvKkZ3BbE20+rsa+wteGBGmt7hhnDywaIVUQdIJhlXn8X7G4lZz8micLSvKVU10TP6pj1w3AmOewCIP+pcaqjAw8rUNFWuYT0RCOhTXJOPi4LnBSEKbXR65DZhGFJXgUzCFQeAby1C3UX9RjB0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788693574; c=relaxed/simple;
	bh=Giupk0J1ZNfcLTZqdMpQz4eJAmUP1rE7vrmVirAraPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/qLd3o7L3ZnwxX1AXMtHLaZtnwgURhou5SU+CxbFSYXBHLawqD9963dQeYFmqnvTP4awz1pNPXT9oCQ5KrOUtXueT/P7T5w1RtkZAofzil/hkVad5+brjfYgQFzv/ztX7CwzM5GJJB8eSqB3lilcYYA8mY4u0vkSKNHaSVHirM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=A1bL9ZKz; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="A1bL9ZKz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d5cad1a6baso22270805ad.3
        for <linux-can@vger.kernel.org>; Sun, 06 Sep 2026 04:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788693571; cv=none;
        d=google.com; s=arc-20260327;
        b=CYAfxKxskcUpv6iwpkYADK8nGQYj20LLMqBLgW5tTcjoHMq4ICQBO7WojY6RkncD6C
         KBzFqtuLH36tjSQPFRJgodDk4ADemwyCiDkJ3MtFvbUk7JtPRtVH/RzZZefz/rZyn+bN
         bDPjk3Qdh1lWyUxFJyB+E9DW+ScVm6HraIO7xTKMxgfECiM2+CVpXu8zdO+Jq8SygYJr
         YtzVSBgngIJdV/xLnfgV0SKsquaug0a4ZspjFxi2G/OeuDFZpu2yO4LzOLOmnWiciTwU
         49xbxHScIyvGRMdCxbRcLZPW/bOx5Y20UAohQ/b2RhNM0dUozQu+6cXh+dM9nTGp5kCj
         Df2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XTgCA64EfXR/PGZNkFArmuKTqa5lqNd9HTFkrYCnwOg=;
        fh=6fBJWBs97Nny18HqEfCg7yCSKeu/MzLW/VnBzhQ6hbo=;
        b=oNcefc6d6GSpGBFNQy7lvU3rn/Tlh5VOvFyrg1S2Uk2ksp+Og6fJ9OIxjzZj/kQh4D
         2FctlMKFBdyK5LOVYQBdNjUGjyhonUVxiwfXzilkffXEZ+SexleaZ2orguHSk4GcsnQv
         qFRSwtmFi85LRiqfi5qv3X6XI1CDelc8OVTN0fOSLmQ2UZWCZLaBdeOE3gUSlqE5OU16
         GsuZxlfnQHKfDP3jARrLuVdz1kfBMqijH0jGGLTQNcrNRpkZegx8sXeOfRGFLbUqLL3l
         zHSJ+/b2mtR3Qd3Ol1dhEnoOz9O9fklMLNQq1KGJjWcZna4+Y8OviQzHOnuKqdRUsPcf
         dcOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788693571; x=1789298371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XTgCA64EfXR/PGZNkFArmuKTqa5lqNd9HTFkrYCnwOg=;
        b=A1bL9ZKzb7548j3SG8IvKUw8uu5Cv8yStzLDV5IU2k3rYh5gqplkpxABa+PC2u5bSk
         rtgZ0LDXKmL5xE8hw+fy/H48oTeUOTTuPCPbza/wZZmGKVLx33/v3R6Pd4Ht4cCrhJ1k
         V/DSEqmfKGGP7P4mRGDWmOUegU9yHpPwi2SSjrhQCD8W8Nzn+GK6HjoaUPR/VBGmPQ2e
         YmF8K6Y/N3NhQIDnqcs9CEBMp6DXM7MBtARGkR8LPm3AMUfKQwQ15xVFGkZorbaHqa0+
         uiGIhqFv0ZCExOztgd1hZeYFa/5a7hr+DmpCnNvmg32i4TfUPwGJYG/oNQCYgT80OE+d
         vQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788693571; x=1789298371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTgCA64EfXR/PGZNkFArmuKTqa5lqNd9HTFkrYCnwOg=;
        b=KoQqMi4PSEH5soGeK7mKKXqx/ea/fvSubI/IBB/c2rrTl+JJ7jAKq65h87lpaGWMIf
         AeOZjouiBqu9DXRx7EdDNgydjF0ikcqGKSfUH7aOEGovs0nrlxkS61nIa+M+ouDmNOxw
         LXwlSJ458pU7DnRNSntLKTNmAReNHaYIxPWoZACMLnf81sOuPmYGl6R/yI8o1UQKD2Kx
         WsrznRf3QRszf6EXdgJBhgVPUg3azn9Gfx+B9LBPig/nP30PXG8+FxZ2FE/+xxt+kWoN
         6JVAWEw8xuVho0SD/ogkmpR68vvE+QI6c6agv6AU957isS8iYvD551G1Tw8cG0XX7u1q
         e+1g==
X-Forwarded-Encrypted: i=1; AKwUvBxovgxR2kdYojfIM4RuykiRiKrrKzzqFmt7hARiRE0gt8a5xjRcMk/V0Y+tgLGfC3djbGv1XOmwyjQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lzHq5kHlrgO1ULIsVtHVa3lC7GEHLpLzk922lRWAbd/1u09E/l
	WHgHtgT3mI4GGWmYVXUv/CLsyeJ+CKE2jU3ggwMrjba2a8cQZ6qIq3JlAnI6MvXX37bAnARaeS2
	s8MA8mPzjrb7ObQ29ah1pLUXabveqBlsXz2GfJv97
X-Gm-Gg: AYBFou04+z4G9oxgwW9/9wg0ABS+TCdLrjBbj91DuGNW6Vz1jFYSYd5vKMXkbgszZrm
	Gvicv2SKu9XPV8xOo046X+XOK8ilc7YfWt9/+DtWNmbLzOwmUkyVv8bXIuoVOKf94zV/BZA+g2j
	6D+cyp68XRIk8/yqG21A/upX/3HB1f6Rw1NlzkQUu3Bl6RYQmIZaJHCz/BOopOdSPaGFAk/cpS/
	FA81RA5gz2f0wF4Ud5Tx1DutEZv56bAAA2W9DS/Z2wAT83YBnaCBBjbbgsZaMImGsvk9fTZtWoo
	n1UKzK2NfGqpLgIDtqtIStXx7EOvx9G9NWAgkO27NBoZCGltRcOwYm+yCuUJelAvt3Pl62qRJ5+
	YC/rIf8O42ifwVGRaULsH/CwrzqBb9kwkwt0=
X-Received: by 2002:a17:902:f68b:b0:2cc:864b:539 with SMTP id
 d9443c01a7336-2db12495a80mr248860175ad.6.1788693571315; Sun, 06 Sep 2026
 04:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <upsCxxaJjg2FJWhfCx6KjFXLlh8o4IhaHKJi@bugs.sh> <CAMuHMdVVqfqvueX-jk_XfM5tE9XScZPe1OLqGw1MUC=Kd2reBQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVVqfqvueX-jk_XfM5tE9XScZPe1OLqGw1MUC=Kd2reBQ@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Sun, 6 Sep 2026 04:19:20 -0700
X-Gm-Features: AcwNN1VwRPW3yMBdTVYbJmlJsVs_CJngzLBHUrX4gAO4o_iesE3RGTS14IgLAxg
Message-ID: <CAPpSM+R_EH-grYvEs3QFCsi-tej4yhUqrAib2XcDLh5TKKeh-Q@mail.gmail.com>
Subject: Re: [BUG] drivers/net: out-of-bounds in pcan_usb_decode_buf()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: co <co+5e2bcf11e7027510@bugs.sh>, linux-can@vger.kernel.org, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
	Oleg Nesterov <oleg@redhat.com>, Biju Das <biju.das.jz@bp.renesas.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, cedalion@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 7:04=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Co,
>
> On Fri, 4 Sept 2026 at 23:17, co <co+5e2bcf11e7027510@bugs.sh> wrote:
> > We found a bug reachable in:
> >
> >     path    drivers/net/can/usb/peak_usb
> >     crash   out-of-bounds in pcan_usb_decode_buf()
> >     commit  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.kern=
el.org/pub/scm/linux/kernel/git/trace/linux-trace")
> >
> > Config, environment, the sanitizer report and a C reproducer follow.
> >
> > =3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> >         patch.diff  https://bugs.sh/b/5e2bcf11e7027510/patch.diff
> >         report.md   https://bugs.sh/b/5e2bcf11e7027510/report.md
> >
> >     This is an open science project. The code and the full set of PoCs
> >     are not public at this moment, as we intend to disclose our finding=
s
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
>
Hi Geert, thanks for the reminder.
We'll learn the documents and make sure we follow the documents.

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
