From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH linux-can-next/flexcan] can: flexcan: fix TDC feature
Date: Thu, 25 Jun 2020 14:56:32 +0200
Message-ID: <e38cf40b-ead3-81de-0be7-18cca5ca1a0c@pengutronix.de>
References: <20200416093126.15242-1-qiangqing.zhang@nxp.com>
 <20200416093126.15242-2-qiangqing.zhang@nxp.com>
 <DB8PR04MB6795F7E28A9964A121A06140E6D80@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <d5579883c7e9ab3489ec08a73c407982@walle.cc>
 <39b5d77bda519c4d836f44a554890bae@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403941AbgFYM4h (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 25 Jun 2020 08:56:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0928C061573
        for <linux-can@vger.kernel.org>; Thu, 25 Jun 2020 05:56:36 -0700 (PDT)
In-Reply-To: <39b5d77bda519c4d836f44a554890bae@walle.cc>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Walle <michael@walle.cc>, Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: linux-can@vger.kernel.org, dl-linux-imx <linux-imx@nxp.com>, netdev@vger.kernel.org

On 6/25/20 2:37 PM, Michael Walle wrote:
> Am 2020-06-02 12:15, schrieb Michael Walle:
>> Hi Marc,
>>
>> Am 2020-04-16 11:41, schrieb Joakim Zhang:
>>> Hi Marc,
>>>
>>> How about FlexCAN FD patch set, it is pending for a long time. Many
>>> work would base on it, we are happy to see it in upstream mainline
>>> ASAP.
>>>
>>> Michael Walle also gives out the test-by tag:
>>> 	Tested-by: Michael Walle <michael@walle.cc>
>>
>> There seems to be no activity for months here. Any reason for that? Is
>> there anything we can do to speed things up?
> 
> ping.. There are no replies or anything. Sorry but this is really
> annoying and frustrating.
> 
> Marc, is there anything wrong with the flexcan patches?

I've cleaned up the patches a bit, can you test this branch:

https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=flexcan

Marc

-- 
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |
