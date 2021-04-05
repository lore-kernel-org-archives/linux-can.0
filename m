Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC96C433ED
	for <linux-can@archiver.kernel.org>; Mon,  5 Apr 2021 02:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0E476138B
	for <linux-can@archiver.kernel.org>; Mon,  5 Apr 2021 02:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhDEC3s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-can@archiver.kernel.org>);
        Sun, 4 Apr 2021 22:29:48 -0400
Received: from mail-yb1-f182.google.com ([209.85.219.182]:33520 "EHLO
        mail-yb1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhDEC3r (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 4 Apr 2021 22:29:47 -0400
Received: by mail-yb1-f182.google.com with SMTP id l15so11174569ybm.0
        for <linux-can@vger.kernel.org>; Sun, 04 Apr 2021 19:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cdeQUgQSltUmWo32+kTyKX/kOTGYD/wTgNyRtXWD9JA=;
        b=fwG3qGYVD5Wzj0atmwVs5dELLMRfrBcug0zj9RR3sOH2Ba6Xpg0CwmL8hLu6c/3oPp
         qU7HLFhoKOgo1EVnOyEdB3S2XaJX1aaczAhDp3PS2n+sLXko2msozDh8zXvBbCtmHKpV
         xqYAo/1ezewLlEUwc2bUJdw0HTQy4YLBDlVkB/JZo7qq7DNGs0c6Wzer7yKwpp0WtLll
         QpC/IS1/0b5CZ4lm+mSgRFjnZ69jzrxtHW/6cLfS6YvHQTI19xGPVE8fFbiOeEnIHpMo
         brnc7p9Rf8x48TAYnpSYMPFe8hgmshmfBUbrzP63vMek2ag4yHQf8d1h+8XX1y6i1WFC
         fvaQ==
X-Gm-Message-State: AOAM533egD5gBTAA64agCVN9JYRu4YxuXxhViiPDnoPVQdCwi/9Eo77S
        UDNXcn8/vxE012uNHciszyyD6nt5cOl5pqA+wMuq6jrNngc=
X-Google-Smtp-Source: ABdhPJzarhPPm3sFiymuAc7ImD2ta+iQTCnUs+MEWos71s3sokrddeuR6spWlxvSXtfhoNtYzTymYLoqbUl0Yt9CRA0=
X-Received: by 2002:a25:bed1:: with SMTP id k17mr12778818ybm.125.1617589782244;
 Sun, 04 Apr 2021 19:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210224002008.4158-1-mailhol.vincent@wanadoo.fr>
 <20210224002008.4158-5-mailhol.vincent@wanadoo.fr> <20210315155900.a6l5l5aeuvsgn55x@pengutronix.de>
 <CAMZ6RqJyMXzog1mu3S62yMAxJorTg0D5VL5OYKALYRoMxN_DdQ@mail.gmail.com> <20210316152948.eqak6slrs2xf5lc4@pengutronix.de>
In-Reply-To: <20210316152948.eqak6slrs2xf5lc4@pengutronix.de>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Mon, 5 Apr 2021 11:29:31 +0900
Message-ID: <CAMZ6Rq+ET3V3EQDVe9xYF8=Sv7N1WHZCLy2XTvqVXuNEyKg6VQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] can: add netlink interface for CAN-FD Transmitter
 Delay Compensation (TDC)
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can <linux-can@vger.kernel.org>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Wolfgang Grandegger <wg@grandegger.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc,

On Wed. 17 Mar 2021 at 00:29, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> On 17.03.2021 00:16:01, Vincent MAILHOL wrote:
> > > I just had a look at the ethtool-netlink interface:
> > >
> > > | Documentation/networking/ethtool-netlink.rst
> > >
> > > this is much better designed than the CAN netlink interface. It was done
> > > by the pros and much later than CAN. :D So I'd like to have a similar
> > > structure for new CAN netlink stuff.
> > >
> > > So I think I'll remove this patch for now from can-next-testing. The
> > > kernel internal interface to tdc is still OK, we can leave it as is and
> > > change it if needed. But netlink is user space and I'd like to have it
> > > properly designed.
> >
> > Understood. However, I will need more time to read and understand
> > the ethtool-netlink interface. The new patch will come later, I
> > do not know when.
>
> No Problem

I started to look at Ethtool netlink, but as far as my understanding
goes, this seems purely restricted to the ethtool application (i.e.
not to iproute2). I double checked the latest versions of iproute2
but there isn’t a single #include <linux/ethtool_netlink.h> nor
anything else related to that new API.

Please let me know if I missed the point.


Yours sincerely,
Vincent
