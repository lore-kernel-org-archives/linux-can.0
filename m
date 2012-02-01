From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 00/12] CAN updates for net-next, please review
Date: Wed, 01 Feb 2012 11:24:39 +0100
Message-ID: <4F2912E7.6070802@grandegger.com>
References: <1328046410-21392-1-git-send-email-mkl@pengutronix.de> <4F290933.9060202@grandegger.com> <4F290A38.8080807@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:56791 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050Ab2BAKYs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Feb 2012 05:24:48 -0500
In-Reply-To: <4F290A38.8080807@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 02/01/2012 10:47 AM, Marc Kleine-Budde wrote:
> Hey,
> 
> On 02/01/2012 10:43 AM, Wolfgang Grandegger wrote:
>>> I collected all pending patches from the mailinglist in order to push to
>>> davem. Are there some patches missing, which are rerady to go upstream?
>>
>> The patch "[PATCH 04/12] can: replace the dev_dbg/info/err/... with the
>> new netdev_xxx macros" does have issues. Did you already apply it to
>> linux-can-next? Shoud I send a v2 or a followup patch? I have also
> 
> No, it's still in my repo. Please send a v2.
> 
>> another fix for the ti_hecc driver, which I will send in a few minutes.
> 
> Go ahead. I'll have to setup a compile time test script anyway.

Before pinging Dave, I could do some regression builds here as well.

Wolfgang.

