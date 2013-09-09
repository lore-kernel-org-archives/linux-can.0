From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can: add explicit copyright to header can/netlink.h
Date: Mon, 09 Sep 2013 22:01:53 +0200
Message-ID: <522E2931.9050006@grandegger.com>
References: <1378477811-3606-1-git-send-email-mkl@pengutronix.de> <ecac65a6d53af596b53d115a9e6552a0@grandegger.com> <20130906193744.GV24802@pengutronix.de> <522AFEA8.3020303@hartkopp.net> <522AFF20.6000501@pengutronix.de> <3cfa97cc2473a26f5f961bfb4560acd0@grandegger.com> <522CCB73.3090504@hartkopp.net> <522CD430.1020009@grandegger.com> <522E0E25.10600@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44237 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755260Ab3IIUBz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Sep 2013 16:01:55 -0400
In-Reply-To: <522E0E25.10600@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, =?ISO-8859-1?Q?Uwe_Kleine-K?= =?ISO-8859-1?Q?=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

On 09/09/2013 08:06 PM, Oliver Hartkopp wrote:
> On 08.09.2013 21:46, Wolfgang Grandegger wrote:
>> On 09/08/2013 09:09 PM, Oliver Hartkopp wrote:
> 
> 
>>>
>>>  * The provided data structures and external interfaces from this code
>>>  * are not restricted to be used by modules with a GPL compatible license.
>>
>> The question is if this sentence is a legal addition to the GPL license.
>> I personally doubt but I'm not a lawyer.
> 
> This is for the guys that like to put EXPORT_SYMBOL_GPL() anywhere to NOT do
> this here ;-)

But this is something different. EXPORT_SYMBOLS is for kernel modules
which are covered by the GPL license, even with the Volkswagen
license... or have I missed something. My favorite would be the GPL v3
license ;).

Wolfgang.

