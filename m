Return-Path: <SRS0=AGJ1=DQ=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89A7C433E7
	for <linux-can@archiver.kernel.org>; Fri,  9 Oct 2020 14:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8211B2222C
	for <linux-can@archiver.kernel.org>; Fri,  9 Oct 2020 14:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgJIOQv (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Fri, 9 Oct 2020 10:16:51 -0400
Received: from relay-b01.edpnet.be ([212.71.1.221]:51100 "EHLO
        relay-b01.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgJIOQt (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 9 Oct 2020 10:16:49 -0400
X-ASG-Debug-ID: 1602253005-0a7ff508f517df9a0001-ZXuqFv
Received: from zotac.vandijck-laurijssen.be (94.105.104.9.dyn.edpnet.net [94.105.104.9]) by relay-b01.edpnet.be with ESMTP id iVs1kCjuUMWMiFKQ for <linux-can@vger.kernel.org>; Fri, 09 Oct 2020 16:16:45 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 94.105.104.9.dyn.edpnet.net[94.105.104.9]
X-Barracuda-Apparent-Source-IP: 94.105.104.9
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id DF5A3109B997
        for <linux-can@vger.kernel.org>; Fri,  9 Oct 2020 16:16:44 +0200 (CEST)
Date:   Fri, 9 Oct 2020 16:16:43 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-can@vger.kernel.org
Subject: mcp2517fd: transmit errors
Message-ID: <20201009141643.GE7238@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: mcp2517fd: transmit errors
Mail-Followup-To: linux-can@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 94.105.104.9.dyn.edpnet.net[94.105.104.9]
X-Barracuda-Start-Time: 1602253005
X-Barracuda-URL: https://212.71.1.221:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 446
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9828 1.0000 4.1442
X-Barracuda-Spam-Score: 4.14
X-Barracuda-Spam-Status: No, SCORE=4.14 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.85172
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

I'm using a v5.4 kernel now, with backported 'can: mcp25xxfd: initial commit'.
I did focus up to now to CAN recv performance, but now I face another
issue. I have errors transmitting to CAN. It's unstable.
I need to collect more details, and it is now about focus number 1.

I managed to decrease the urgency for my project by inserting a delay
in the most busy transmitter.

Any ideas what to look for?

Kind regards,
Kurt
