Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6D5C48BDF
	for <linux-can@archiver.kernel.org>; Thu, 24 Jun 2021 10:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B42361400
	for <linux-can@archiver.kernel.org>; Thu, 24 Jun 2021 10:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhFXKvC (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 24 Jun 2021 06:51:02 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:53372 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbhFXKvC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Jun 2021 06:51:02 -0400
X-ASG-Debug-ID: 1624531721-15c4355b1271ec80001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.105.164.dyn.edpnet.net [94.105.105.164]) by relay-b03.edpnet.be with ESMTP id PII4Ehl5bljzw3Cg; Thu, 24 Jun 2021 12:48:41 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Apparent-Source-IP: 94.105.105.164
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id B92871504288;
        Thu, 24 Jun 2021 12:48:41 +0200 (CEST)
Date:   Thu, 24 Jun 2021 12:48:40 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
Subject: Re: [PATCH 2/2] canbusload: count databitrate seperately
Message-ID: <20210624104840.GA21224@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH 2/2] canbusload: count databitrate seperately
Mail-Followup-To: Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-can@vger.kernel.org
References: <20210624032111.26272-1-dev.kurt@vandijck-laurijssen.be>
 <20210624032111.26272-2-dev.kurt@vandijck-laurijssen.be>
 <20210624062551.3pqnx7tn3u55ucmc@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624062551.3pqnx7tn3u55ucmc@pengutronix.de>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.105.164.dyn.edpnet.net[94.105.105.164]
X-Barracuda-Start-Time: 1624531721
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 303
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.90866
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On Thu, 24 Jun 2021 08:25:51 +0200, Marc Kleine-Budde wrote:
> On 24.06.2021 05:21:11, Kurt Van Dijck wrote:
> > Signed-off-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> 
> For the whole file, please add the usual spaces around operators.

only the ones I introduced, I suppose?

Kurt
