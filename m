Return-Path: <SRS0=197b=EC=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32A2C56201
	for <linux-can@archiver.kernel.org>; Tue, 27 Oct 2020 17:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8285A20878
	for <linux-can@archiver.kernel.org>; Tue, 27 Oct 2020 17:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775161AbgJ0OwM (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Tue, 27 Oct 2020 10:52:12 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:38218 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771303AbgJ0Ot7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 27 Oct 2020 10:49:59 -0400
X-ASG-Debug-ID: 1603810184-0a88186a66706ac0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.104.9.dyn.edpnet.net [94.105.104.9]) by relay-b03.edpnet.be with ESMTP id PAIouLdRb8NrlalD; Tue, 27 Oct 2020 15:49:44 +0100 (CET)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.104.9.dyn.edpnet.net[94.105.104.9]
X-Barracuda-Apparent-Source-IP: 94.105.104.9
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 1B8F210F91F4;
        Tue, 27 Oct 2020 15:49:44 +0100 (CET)
Date:   Tue, 27 Oct 2020 15:49:34 +0100
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        mailhol.vincent@wanadoo.fr, linux-can@vger.kernel.org
Subject: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
Message-ID: <20201027144934.GA20013@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH RFC] can: add optional DLC element to Classical CAN frame
 structure
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        mailhol.vincent@wanadoo.fr, linux-can@vger.kernel.org
References: <20201023203017.3485-1-socketcan@hartkopp.net>
 <d5ad34b5-7232-eadb-94a0-c58c111fa443@pengutronix.de>
 <8c142aa4-78a2-1291-b5a8-d4af9ba41338@hartkopp.net>
 <64920ca4-35df-2a46-5f1a-09a9e7eeffcf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64920ca4-35df-2a46-5f1a-09a9e7eeffcf@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.104.9.dyn.edpnet.net[94.105.104.9]
X-Barracuda-Start-Time: 1603810184
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 952
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.7978 1.0000 2.2010
X-Barracuda-Spam-Score: 2.20
X-Barracuda-Spam-Status: No, SCORE=2.20 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.85498
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Tue, 27 Oct 2020 14:48:30 +0100, Marc Kleine-Budde wrote:
> On 10/27/20 2:23 PM, Oliver Hartkopp wrote:
> > On 27.10.20 14:06, Marc Kleine-Budde wrote:
> >> On 10/23/20 10:30 PM, Oliver Hartkopp wrote:

> > 
> > No. It is 'Classical CAN'. I'm not very happy with that naming as there 
> > was already a 'CAN2.0B' specification to separate from the first version 
> > which only had 11 Bit identifiers. This could be Ancient CAN now :-D
> 
> So Classical CAN is CAN2.0B?
> 
> >> For example there was a press release to harmonize the CAN transceiver nameing
> >> recently:
> >>
> >> https://can-cia.org/news/press-releases/view/harmonized-transceiver-naming/2020/7/16/
> > 
> > Yes, there you can find:
> > 
> > "CAN high-speed transceivers might be used in Classical CAN, CAN FD, or 
> > CAN XL networks"

What happened to 'Standard CAN' (<= CAN2.0A) and 'Extended CAN' (CAN2.0B)?
Did those names became fossils now?

Kurt
