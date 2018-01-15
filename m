From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can-next 2017-12-01,Re: pull-request: can-nexto
 2017-12-01,Re: pull-request: can-next 2017-12-01,Re: pull-request:
 can-next 2017-12-01
Date: Mon, 15 Jan 2018 16:14:33 -0500 (EST)
Message-ID: <20180115.161433.1583031609797218068.davem@davemloft.net>
References: <be945e20-d5d5-f786-c9d4-3a3ef97a0292@pengutronix.de>
        <20180115.125529.1662730568101394452.davem@davemloft.net>
        <2372427e-2db4-b386-f51d-86f976033765@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([184.105.139.130]:54318 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeAOVOg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Jan 2018 16:14:36 -0500
In-Reply-To: <2372427e-2db4-b386-f51d-86f976033765@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, kernel@pengutronix.de, linux-can@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 15 Jan 2018 21:54:29 +0100

> On 01/15/2018 06:55 PM, David Miller wrote:
>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>> Date: Mon, 15 Jan 2018 14:02:23 +0100
>> 
>>> Hello David,
>>>
>>>
>>> On 01/05/2018 12:08 PM, Marc Kleine-Budde wrote:
>>>> Hello David,
>>>>
>>>> this is a pull request of 7 patches for net-next/master.
>>>>
>>>> All patches are by me. Patch 6 is for the "can_raw" protocol and add
>>>> error checking to the bind() function. All other patches clean up the
>>>> coding style and remove unused parameters in various CAN drivers and
>>>> infrastructure.
>>>
>>> this pull request is still open. Any objections to pull this?
>> 
>> You gave me an SSH URL:
>> 
>> 	ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-4.16-20180105
>> 
>> Or did you plan to give my your SSH password so that I can pull this? :-)
>> 
>> Please resubmit with a proper git:// URL I can actually pull from.
> 
> I don't see a reason, why you need my ssh keys. That was intentional.
> 
> As long as you have your SSH keys, you have read only access to my (and
> the git repos of the other kernel developers) on git.kernel.org. I'm
> already fetching from net and net-next via ssh:

Ok, I didn't know this.

Pulled, thanks.
