Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B2AC433E0
	for <linux-can@archiver.kernel.org>; Wed,  3 Feb 2021 20:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7004A64F8C
	for <linux-can@archiver.kernel.org>; Wed,  3 Feb 2021 20:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhBCUHQ (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 3 Feb 2021 15:07:16 -0500
Received: from relay-b03.edpnet.be ([212.71.1.220]:37588 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhBCUHQ (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 3 Feb 2021 15:07:16 -0500
X-ASG-Debug-ID: 1612382790-0a8818776efe8c0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (77.109.126.125.adsl.dyn.edpnet.net [77.109.126.125]) by relay-b03.edpnet.be with ESMTP id fHwDFGLrTAoZMDVi; Wed, 03 Feb 2021 21:06:30 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.126.125.adsl.dyn.edpnet.net[77.109.126.125]
X-Barracuda-Apparent-Source-IP: 77.109.126.125
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 25AFA12403D6;
        Wed,  3 Feb 2021 21:06:30 +0100 (CET)
Date:   Wed, 3 Feb 2021 21:06:14 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: [Question] Sending CAN error frames
Message-ID: <20210203200614.GB23073@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [Question] Sending CAN error frames
Mail-Followup-To: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jimmy Assarsson <extja@kvaser.com>,
        linux-can <linux-can@vger.kernel.org>
References: <8050d433-591c-2d1f-f0c7-ffa92e33032d@pengutronix.de>
 <cac31b51-514d-462b-fe48-4c3bea8b28fd@hartkopp.net>
 <1b82f875-5884-3bf6-7891-2e4461d2a72a@pengutronix.de>
 <abc8923c-8cf6-c0d5-ec67-73afe183b9b3@hartkopp.net>
 <CAMZ6RqKx5NCFKiahb8AbUx=LC5xS6oYCdVZk8WGSAzZeAVs9Qg@mail.gmail.com>
 <ac8c4d3c-4261-8909-3481-abcd1d3bf43e@hartkopp.net>
 <CAMZ6RqKkeV6WRtfh65mDsYthuG1S+LD=kexAdcx=DeShf0T0YQ@mail.gmail.com>
 <d7584992-78a0-4be7-6b31-0bc1e4adfeca@hartkopp.net>
 <707944b7-f202-edb1-cb67-beedaeedfda0@gmail.com>
 <CAMZ6RqK_McbYNMqdb+zynH-CGaERFv5j5MgNd9X7MJBqu1f4Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMZ6RqK_McbYNMqdb+zynH-CGaERFv5j5MgNd9X7MJBqu1f4Xw@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.126.125.adsl.dyn.edpnet.net[77.109.126.125]
X-Barracuda-Start-Time: 1612382790
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 2067
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.87225
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Wed, 03 Feb 2021 17:26:11 +0900, Vincent MAILHOL wrote:
> On Wed. 3 Feb 2021 at 15:42, Jimmy Assarsson <jimmyassarsson@gmail.com> wrote:
> > >
> > > Of course we might also provide some pump gun mode which just sends an error flag at some (any) time.
> >
> > As above.
> >
> > > But for what reason?
> >
> > Testing purpose, e.g if you develop software where you want to keep track of bus errors, this makes it possible to test such software in a controlled way.
> > We also use this ourselves when testing the transitions ERROR_ACTIVE <-> ERROR_WARNING <-> ERROR_PASSIVE, for Rx.
> 
> I think that there are two axes in this discussion: the attacker
> point of view and the functional testing point of view.
> 
> From the attacker point of view, you are mostly interested in
> destroying the transmitter frames.
> 
> For the functional testing, it is about covering the all the
> aspects of the standard: make sure that all the TX and RX counters
> are correctly incremented, test the transitions between the
> different states and that for all offsets. And to confirm all
> aspects, you might want to inject both the active and the passive
> error flags and do it at all possible positions.
> 
> That said, my vision on functional testing is an uneducated
> guess. I never worked on that and my personal focus is more the
> attacker point of view.

Looking back to it, my first interest would be to fire N error frames,
so to control other nodes' rx error counters.
Controlling your own tx error counter makes less sense, I assume that if
your chip is capable of triggering error frames on demand, then I also
assume that the tx error counter detection is done right.

destroying specific CAN frames sounds much like functional testing,
and can be done much simpler by modifying the node that sends it and add
some very ad-hoc test code to not send specific can frames at all.

The attacker point of view indeed could require a more elaborate API,
but I still doubt we can deliver what is required for attacking.

Kurt
