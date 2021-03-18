Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DE0C433DB
	for <linux-can@archiver.kernel.org>; Thu, 18 Mar 2021 09:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D450364F38
	for <linux-can@archiver.kernel.org>; Thu, 18 Mar 2021 09:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCRJX5 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Thu, 18 Mar 2021 05:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhCRJXg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 Mar 2021 05:23:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6607C06174A
        for <linux-can@vger.kernel.org>; Thu, 18 Mar 2021 02:23:35 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lMosO-0003JJ-5D; Thu, 18 Mar 2021 10:23:32 +0100
Subject: Re: [BUG] Re: [net 3/6] can: flexcan: invoke flexcan_chip_freeze() to
 enter freeze mode
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     netdev@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>,
        linux-can@vger.kernel.org, kernel@pengutronix.de, kuba@kernel.org,
        davem@davemloft.net
References: <20210301112100.197939-1-mkl@pengutronix.de>
 <20210301112100.197939-4-mkl@pengutronix.de>
 <65137c60-4fbe-6772-6d48-ac360930f62b@pengutronix.de>
 <20210317081831.osalrszbje4oofoh@pengutronix.de>
 <20210317114938.lcqudto75wc6nkzq@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <148ff70d-96a6-952c-279d-ad1c5cd4e71d@pengutronix.de>
Date:   Thu, 18 Mar 2021 10:23:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210317114938.lcqudto75wc6nkzq@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 17.03.21 12:49, Marc Kleine-Budde wrote:
> On 17.03.2021 09:18:31, Marc Kleine-Budde wrote:
>> A fix for this in on its way to net/master:
>>
>> https://lore.kernel.org/linux-can/20210316082104.4027260-6-mkl@pengutronix.de/
> 
> It's already in net/master.

Cherry-picked and works for me.

Thanks,
Ahmad

> 
> regards,
> Marc
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
