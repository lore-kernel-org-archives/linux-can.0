From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Usb to can driver
Date: Thu, 02 May 2013 13:30:10 +0200
Message-ID: <51824E42.9080905@grandegger.com>
References: <1366737302.3325.36.camel@blackbox>   <51770161.2030005@pengutronix.de> <1366818490.5965.35.camel@blackbox>  <51780336.5060800@pengutronix.de> <1366839193.7226.8.camel@blackbox> <5182490F.2080707@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:48239 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699Ab3EBLaN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 May 2013 07:30:13 -0400
In-Reply-To: <5182490F.2080707@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Max S." <max@schneidersoft.net>, linux-can <linux-can@vger.kernel.org>, Sven Geggus <lists@fuchsschwanzdomain.de>

On 05/02/2013 01:07 PM, Marc Kleine-Budde wrote:
> On 04/24/2013 11:33 PM, Max S. wrote:
>> From 8a83080bcddc558cd016e58e408b56ca68bc5bc8 Mon Sep 17 00:00:00 2001
>> From: Maximilian Schneider <max@schneidersoft.net>
>> Date: Wed, 24 Apr 2013 21:03:31 +0000
>> Subject: [PATCH] Added ss_usb source.
> 
> Comments inline.
> 
>> Signed-off-by: Maximilian Schneider <max@schneidersoft.net>
>> ---
>>  drivers/net/can/usb/Makefile |    1 +
> 
> You should add your driver to Kconfig, too.
> 
>>  drivers/net/can/usb/ss_usb.c |  944 ++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 945 insertions(+)
>>  create mode 100644 drivers/net/can/usb/ss_usb.c

What stands "ss" for? I would prefer "ssoft" or "schneidersoft".

Wolfgang.

