From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 00/12] CAN updates for net-next, please review
Date: Wed, 01 Feb 2012 14:25:26 +0100
Message-ID: <4F293D46.8010205@grandegger.com>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de> <4F290933.9060202@grandegger.com> <4F290A38.8080807@pengutronix.de> <4F2912E7.6070802@grandegger.com> <4F2923C3.1000902@pengutronix.de> <4F293829.4080403@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33860 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611Ab2BANZx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 08:25:53 -0500
In-Reply-To: <4F293829.4080403@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 02/01/2012 02:03 PM, Marc Kleine-Budde wrote:
> On 02/01/2012 12:36 PM, Marc Kleine-Budde wrote:
>> On 02/01/2012 11:24 AM, Wolfgang Grandegger wrote:
>>>> Go ahead. I'll have to setup a compile time test script anyway.
>>>
>>> Before pinging Dave, I could do some regression builds here as well.
>>
>> That would be fine, it's in my repo.
>>
>> https://gitorious.org/~bet-frogger/linux-can/mkl-linux-can-next
> 
> Fixed a typo, which I introduced in the "replace the
> dev_dbg/info/err/... with the new netdev_xxx macros" patch.

Me too, in the ems_usb driver, sorry ... I now even installed a blackfin
toolchain...

Wolfgang.
