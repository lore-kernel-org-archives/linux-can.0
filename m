Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57975C433F5
	for <linux-can@archiver.kernel.org>; Sat, 14 May 2022 03:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiENDOi (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 13 May 2022 23:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbiENDOh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 May 2022 23:14:37 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614DB3545A5;
        Fri, 13 May 2022 20:14:36 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2fb9a85a124so104116617b3.13;
        Fri, 13 May 2022 20:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8WSBvqMryDIwNgu/wfY0/kMuB0Kk0HwqZOwbYGWHfGo=;
        b=YKjLuOpx4hqmXTkS1EgYbu6JMMXHxd2Xe/P2hKK8yMT9mF781cJ8rkpPKmPAQQHMa7
         k9kCDoODBEYRzCoPlIfJIjmaAYTVgiYUBn7Gt9ef875ai3va/8Ex9WCbdSHRNLpbi8yx
         1Qlt/VuzO5EqcAtKzF0sr6HYswS2WTbO0JJUBtlCFsdIjl1gQXFxav5tuijsnmGB/uJ4
         Fp8HvK/QyY0Pwwjhw0Yj0uoE9/bZBXlhxE42vDKWdsEIegT3YGXsvBJCXmBn5XZ903ly
         GHcl3o5I+2mnWI+bqIfsJeDB71YvSM8d80t8bUO4qR31/AJ/AI1L3tQmb6z7sogeaAdE
         Iu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8WSBvqMryDIwNgu/wfY0/kMuB0Kk0HwqZOwbYGWHfGo=;
        b=3w3zlGI0ENnLSSRCZH74DnmX8JknVPW6VPBCh99UapF7HF5rwFQHCkxbPbS5WUinCq
         wOhUmvtNZdJ9TK/sUv18ICMqAhPKlIaZc/T97SRGBmmI2HuzyBf70ma5x35rn/wKvTe1
         W7A9zQbefVOnFtoIv3jHBb4px2mjKyc1EB7/VH14W+sqiRvWaOvr/kva9ei1TCXWSjuI
         m6IAlsJlyIGmfnSdHOc7ak/TY+hR2HXLl84IMzT03BZ7acvZF9dBh3Azr9sxPx7/t1zi
         fHq6ui1qltdo8FybtMJ110p03O/O/CmTNwyfS0So78LGcMn9JOn+TsXhn8yLMG33Eadv
         Bc5w==
X-Gm-Message-State: AOAM531ODVK3BT5+MH09lJbYZa7d3FcyN++x3mKjxEzMRqjGwFUFIxLz
        SPWNdm5KzbtNCM2MrFnzMSYb5t1MR6CIBhVv3sk=
X-Google-Smtp-Source: ABdhPJw7JrVfIitnZT9pffDpMcPH/xA/EPR9OKOOLBivUeA/+9GaciKyeWKyaWQn7n3kzGn5TQRgOr8/PlqMRoIjcMM=
X-Received: by 2002:a81:3d43:0:b0:2f9:7d:f320 with SMTP id k64-20020a813d43000000b002f9007df320mr9319855ywa.191.1652498075592;
 Fri, 13 May 2022 20:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220512182921.193462-1-max@enpas.org> <CAMZ6Rq+BwL1NPTLtC5sQAd4z1Kc1TFJPPoW-i+0RZ5dnFaWYiw@mail.gmail.com>
 <CAMZ6RqKjGJyOPCQvS95ZUc6UrgaFzjunRhU=10biAAWYT_V_ZQ@mail.gmail.com> <20220513205907.6d5473ff.max@enpas.org>
In-Reply-To: <20220513205907.6d5473ff.max@enpas.org>
From:   Vincent Mailhol <vincent.mailhol@gmail.com>
Date:   Sat, 14 May 2022 12:14:24 +0900
Message-ID: <CAMZ6RqLj2eLX2UWMvGc9rH2SP6HNuqBAXnwJ6q6qvk+7QWE8pA@mail.gmail.com>
Subject: Re: [PATCH v6] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Sat. 14 mai 2022 at 03:59, Max Staudt <max@enpas.org> wrote:
> On Fri, 13 May 2022 15:31:20 +0900
> Vincent Mailhol <vincent.mailhol@gmail.com> wrote:
> > On Fri. 13 May 2022 at 11:38, Vincent Mailhol
> > <vincent.mailhol@gmail.com> wrote: [...]
> > > > +       case ELM327_STATE_RECEIVING:
> > > > +               /* Find <CR> delimiting feedback lines. */
> > > > +               for (len = 0;
> > > > +                    (len < elm->rxfill) && (elm->rxbuf[len] !=
> > > > '\r');
> > > > +                    len++) {
> > > > +                       /* empty loop */
> > >
> > > Question of taste but would prefer a while look with the len++ in
> > > the body (if you prefer to do as above, no need to argue, just keep
> > > it like it is).
> >
> > Actually, what about this?
> >
> > len = strnchr(elm->rxbuf, elm->rxfill, '\r');
>
> Actually I'd use memchr() if anything, but not really here. I do end up
> using the actual index. And since both strchr() and mrmchr() return
> pointers, I'd rather avoid them because I prefer to use indices
> whenever possible.

You are right. strnchr()'s result can not be used as is. I was a bit
careless when writing my response.

But I still think it is possible to do pointer arithmetic.

len = strnchr(elm->rxbuf, elm->rxfill, '\r') - elm->rxbuf;
(I let you check that I did not do an off by one mistake).

The above should also work with memchr(). Although the C standard
doesn't allow pointer arithmetic on void *, GNU C adds an extension
for that: https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html

As I said before, your for loop is not fundamentally wrong, this is
just not my prefered approach. You have my suggestion, choose what you
prefer.
