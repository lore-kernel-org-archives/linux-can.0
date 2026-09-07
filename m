Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37DE41BA72
	for <linux-can@vger.kernel.org>; Mon,  7 Sep 2026 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769680; cv=none; b=A5fr/a3QvwfL07xOgyb0QRBKIeASWNNSvVkIM/mXCLADE3jNS+tz0j77rWLb8REXUme579Yetd2JqhENj7jHAKsfIC0AO3klWqiLOPYhA/uhLETVnAHPEQrXDLSK1A4JQU08xid1WMhLREJxg6vE2GKIwObUzNCVZrvQr6WnjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769680; c=relaxed/simple;
	bh=bd1ZOmzfRNiksu2tSl3817XFi3Z5T/Ia/NPjjGc0zfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4o5s9xyR2CO4DnSlJwayyZFwyq9PWXytbcCV1aqVqQiafErw/V78Ue/IkCWKmmOwRUChpt5RP6w9TPY0YA6TDbZYlfBRkFUTPRnZwa7pM7LxnQNj447p56HYH/wvWWFQ8aW8xI0LgApmDRsQe2a+tuP7cjTfzPx384LIb4jr48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5c675de8e1dso1486356e0c.2
        for <linux-can@vger.kernel.org>; Mon, 07 Sep 2026 01:27:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788769677; x=1789374477;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=utF5dLMYbyk9S0ybWArep5L2lR1m6zKBr7dnthB2I9w=;
        b=L9K+Spi7OD/87ls0JGUUnY9lxw8NSuQ6FOGWPd5YFRqT0yqN6dfGCbnV8/7yqmZG02
         V90kUBWrUjagypgZbdo/mfAVlxFZ/ieOK8JiKk+TFA1ffkuGO5QlQHOIft/tAUE8wmhE
         9uxiwPLX4GKVoXT6RJireZlxYJR7DsPyTtVDpA3QoxRpQ3SHjiI6Vub8OE1+B//ejLyQ
         lbEOChYtDgxbFCRNvwRMjZ5arJRHGOA/D5f+d8dXk3H2wSMVAtu4wVnMhJ33hW+5qNpP
         jSqPNWNkg6xMXCS7Wa4UvcvMduLEmWj9vC6CuRS2VEuEwi7rQi5AeCu0CqSO9W1oFf3Z
         tHDA==
X-Forwarded-Encrypted: i=1; AKwUvBw9OOtgjWgsEQ99w3aEZCooJhuRqkzw4BMUjNgHqGRPz5pT4d3S5oMUavg2BbaBeY66+2a/kl85YX0=@vger.kernel.org
X-Gm-Message-State: AFuF++l6p3MhnnrFNtuJcTt+eBRJlxOEc82AoqEOiJ6cUk/5SGHKb9Pq
	F8UTl9E8jNlGTQqB/jlZwvdGo58mTdNAeFwi53VMIGie3hJKYstSIEmM1B6EEhLY
X-Gm-Gg: AYBFou2HVyo1JIcsZqvwPqV5pH9mWit5+tRhv/tYmP17hXHG+c/bpIkbgWJTLvvmEaF
	2Le0vPjRFREFPxC2vOGDeqNR3xYoEidzG5aHO2tsTQjKO8o9ZhcTK7MU/RFu8yI48wRjcnxWG+s
	/iZz2Q51tH/+CEkdDWVbFTzW9NuMRLhVoML/znAFutBUk+jRHmdIxHEKX/bznZjRzP3X0O6aj17
	oPPHoBdOoPk9Fasymra6UZNDDUZjuQTCw603vCNxau4TRz/ogbpCRJqYpBWFi7xK4fDYAC1LhtZ
	98F/4MLgXifNZlcuOZ5kxh+HhHfp1V/BOXUX3nAWytolMXVWAp1zfnyEzunIB463fTAsMg/b2AF
	2cWqDVtT6sScekGR9a5B5P2+XwpzpjrTQl3BPPjRDPQ1AeLC2f+rBOZd8FEPy9fiJJkL1Z+aGGZ
	J3OtKqoNnDAV/Ds/wWpw6P1TgX/txgtIYryXvTLXyruUfARuMkxWnsSk6N7CyB8M4nw921mBaCX
	jc2zeEBMAQMS1tbxQtSWis2FtMKGo9AEtzD
X-Received: by 2002:a05:6123:2c8:b0:5bf:b3a0:388c with SMTP id 71dfb90a1353d-5c7ed3e2247mr9268362e0c.6.1788769677396;
        Mon, 07 Sep 2026 01:27:57 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c7ec35d85fsm7491906e0c.12.2026.09.07.01.27.55
        for <linux-can@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 01:27:56 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-96723c7151eso708584241.2
        for <linux-can@vger.kernel.org>; Mon, 07 Sep 2026 01:27:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwium+nd1ZMlLbT+HtMIKmpDw6+b0eTXQLamYTfOQ2BDsw9OE0r6QVJsgG5UMJzKu3ocIm4O66KAdI=@vger.kernel.org
X-Received: by 2002:a05:6102:2d03:b0:77e:6f90:4aad with SMTP id
 ada2fe7eead31-78a4a67cb74mr6809332137.2.1788769675108; Mon, 07 Sep 2026
 01:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <upsCxxaJjg2FJWhfCx6KjFXLlh8o4IhaHKJi@bugs.sh> <CAMuHMdVVqfqvueX-jk_XfM5tE9XScZPe1OLqGw1MUC=Kd2reBQ@mail.gmail.com>
 <CAPpSM+TXw-BGgpdZtx-bH5GEQvzYHxj_wDkdPfUT3Tcn=mtmEw@mail.gmail.com>
In-Reply-To: <CAPpSM+TXw-BGgpdZtx-bH5GEQvzYHxj_wDkdPfUT3Tcn=mtmEw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Sep 2026 10:27:43 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW5Zux92WES0REoejf5FO2h9KgRDCcLbN-A_kyJyRTxCg@mail.gmail.com>
X-Gm-Features: AcwNN1WIo7mZnWwKa-D0voA6hoQPT3vMh6LOKhf3kqZvob9B3oZdbUigh3yaAR0
Message-ID: <CAMuHMdW5Zux92WES0REoejf5FO2h9KgRDCcLbN-A_kyJyRTxCg@mail.gmail.com>
Subject: Re: [BUG] drivers/net: out-of-bounds in pcan_usb_decode_buf()
To: Xiang Mei <xmei5@asu.edu>
Cc: co <co+5e2bcf11e7027510@bugs.sh>, Vincent Mailhol <mailhol@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, =?UTF-8?Q?St=C3=A9phane_Grosjean?= <s.grosjean@peak-system.fr>, 
	Oleg Nesterov <oleg@redhat.com>, Biju Das <biju.das.jz@bp.renesas.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, cedalion@bugs.sh, linux-can@vger.kernel.org, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiang,

On Mon, 7 Sept 2026 at 00:19, Xiang Mei <xmei5@asu.edu> wrote:
> On Sat, Sep 5, 2026 at 7:04=E2=80=AFAM Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:
> > On Fri, 4 Sept 2026 at 23:17, co <co+5e2bcf11e7027510@bugs.sh> wrote:
> > > We found a bug reachable in:
> > >
> > >     path    drivers/net/can/usb/peak_usb
> > >     crash   out-of-bounds in pcan_usb_decode_buf()
> > >     commit  2f1baf1fc892 ("Merge tag 'trace-v7.2-rc7' of git://git.ke=
rnel.org/pub/scm/linux/kernel/git/trace/linux-trace")
> > >
> > > Config, environment, the sanitizer report and a C reproducer follow.
> > >
> > > =3D=3D Notes =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >     If you patch the bug based on our artifacts, a tag would be
> > >     appreciated:
> > >
> > > Reported-by: co+5e2bcf11e7027510@bugs.sh
> > >
> > >     Everything in this mail is validated by the reproducer below.
> > >
> > >     We also hold an LLM-generated root-cause analysis and a candidate
> > >     patch. The patch passes an A/B test: the same reproducer panics t=
he
> > >     unpatched kernel and runs clean on the patched one. Neither has h=
ad
> > >     human review, so both still require validation before you send or
> > >     apply them. Available on:
> > >
> > >         patch.diff  https://bugs.sh/b/5e2bcf11e7027510/patch.diff
> > >         report.md   https://bugs.sh/b/5e2bcf11e7027510/report.md
> > >
> > >     This is an open science project. The code and the full set of PoC=
s
> > >     are not public at this moment, as we intend to disclose our findi=
ngs
> > >     in an ethical way.
> > >
> > >     Happy to test patches. Complaints and suggestions about our work
> > >     are welcome at:
> > >
> > >         cedalion@bugs.sh
> >
> > Please read Documentation/process/submitting-patches.rst, especially
> > https://elixir.bootlin.com/linux/v7.2.2/source/Documentation/process/su=
bmitting-patches.rst#L928
>
> I checked the document and the related files, and I apologize for our
> mistake. This email should not have been sent to you, as our system
> failed to identify the correct maintainers for this submodule.

Thank you!

> We have fixed the issue. Thank you for bringing it to our attention.
> If you meant other issues, please let us know.

There are other issues, like not sending patches inline, so they
cannot be reviewed easily.
Thanks again!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
