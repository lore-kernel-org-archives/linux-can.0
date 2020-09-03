Return-Path: <SRS0=Sdnb=CM=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26705C433E2
	for <linux-can@archiver.kernel.org>; Thu,  3 Sep 2020 05:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0032120665
	for <linux-can@archiver.kernel.org>; Thu,  3 Sep 2020 05:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgICFr1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-can@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgICFr0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2020 01:47:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C308AC061244
        for <linux-can@vger.kernel.org>; Wed,  2 Sep 2020 22:47:25 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kDi5k-00027A-DF; Thu, 03 Sep 2020 07:47:24 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1kDi5k-0004qT-3h; Thu, 03 Sep 2020 07:47:24 +0200
Date:   Thu, 3 Sep 2020 07:47:24 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     henrique ricardo figueira <henrislip@gmail.com>
Cc:     linux-can@vger.kernel.org
Subject: Re: Questions about using multiple sockets
Message-ID: <20200903054724.x6giher7ldmuvbac@pengutronix.de>
References: <CAD1tVCN7-T=FHNQEz3Bp-0Kt3H6M1RokyUuw=e9sTLdXNWB=DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAD1tVCN7-T=FHNQEz3Bp-0Kt3H6M1RokyUuw=e9sTLdXNWB=DQ@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 07:41:10 up 292 days, 20:59, 282 users,  load average: 0.18, 0.09,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Henrique,

On Wed, Sep 02, 2020 at 03:15:13PM -0300, henrique ricardo figueira wrote:
> Hi, I would like to know if it is possible for me to use multiple sockets
> with different protocols, a CAN_RAW socket and another CAN_J1939. Because I
> need to receive messages from an ECU that does not follow J1939.

Yes, you can combine it as you wish. You can even use CAN_RAW to
communicate with CAN_J1939 on same or remote machine.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
