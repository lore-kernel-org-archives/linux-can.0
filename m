From: wg <wg@grandegger.com>
Subject: Re: flexcan: use hardware timestamp
Date: Mon, 29 Apr 2013 20:42:35 +0200
Message-ID: <05b3a72eaa4694232ba34598c325a345@grandegger.com>
References: <517ECB130200000100098502@mail.schleissheimer.de>
 <517EB4D1.8020205@pengutronix.de> <517EB531.20803@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from pluto.manitu.net ([217.11.48.9]:44722 "EHLO pluto.manitu.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932625Ab3D2Smi (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 29 Apr 2013 14:42:38 -0400
In-Reply-To: <517EB531.20803@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Sven Schuchmann <schuchmann@schleissheimer.de>, linux-can@vger.kernel.org

On Mon, 29 Apr 2013 20:00:17 +0200, Marc Kleine-Budde <mkl@pengutronix.de>

wrote:

> On 04/29/2013 07:58 PM, Marc Kleine-Budde wrote:

>> On 04/29/2013 07:33 PM, Sven Schuchmann wrote:

>>> Hello,

>>> I was wondering if the flexcan driver uses the hardware timestamp

>>> and by looking at the code under drivers/net/can/flexcan.c and did

>>> not find any access to those registers.

>>>  

>>> is there a special reason for this?

>> 

>> Yes, no one has implemented it yet :)

>> 

>>> If not, I would try implementing to use skb_shared_hwtstamps...

> 

> I mean, go ahead implement hardware timestamps, but I haven't checked if

> skb_shared_hwtstamps is the correct interface.



Looks good according to:



http://lxr.linux.no/#linux+v3.9/Documentation/networking/timestamping.txt

http://lxr.linux.no/#linux+v3.9/Documentation/networking/timestamping/timestamping.c



Wolfgang,
