From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: add explicit copyright to header can/netlink.h
Date: Sun, 08 Sep 2013 21:09:39 +0200
Message-ID: <522CCB73.3090504@hartkopp.net>
References: <1378477811-3606-1-git-send-email-mkl@pengutronix.de> <ecac65a6d53af596b53d115a9e6552a0@grandegger.com> <20130906193744.GV24802@pengutronix.de> <522AFEA8.3020303@hartkopp.net> <522AFF20.6000501@pengutronix.de> <3cfa97cc2473a26f5f961bfb4560acd0@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:30563 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975Ab3IHTJn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 8 Sep 2013 15:09:43 -0400
In-Reply-To: <3cfa97cc2473a26f5f961bfb4560acd0@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, =?UTF-8?B?VXdlIEtsZWluZS1Lw7Zu?= =?UTF-8?B?aWc=?= <u.kleine-koenig@pengutronix.de>, linux-can@vger.kernel.org, kernel@pengutronix.de

On 07.09.2013 21:15, Wolfgang Grandegger wrote:
> On Sat, 07 Sep 2013 12:25:36 +0200, Marc Kleine-Budde <mkl@pengutronix.de>


>> The usage of netlink.h in a closed source app might be a nother usecase.
> 
> 
> 
> The intention is clear. But many other uapi include files are used in
> 
> closed source as well without such a clause.
> 
> 
> 
> Are you/we sure that this addition is even compatible with the
> 
> GPL (v2) license. GPL does usually not allow exceptions.

As original author you may chose the license as you like.

That's why our license header intends to be like a BSD license and when used
inside the Linux kernel the GPL comes into action:

 * Alternatively, provided that this notice is retained in full, this
 * software may be distributed under the terms of the GNU General
 * Public License ("GPL") version 2, in which case the provisions of the
 * GPL apply INSTEAD OF those given above.

And then - just to make it really sure - this additional sentence is written:

 * The provided data structures and external interfaces from this code
 * are not restricted to be used by modules with a GPL compatible license.

Originally there was (intentionally) no license information in the CAN header
files - as there were _many_ header files in the Linux kernel that did not
contain any license information.

When Debian needs this information to be sure about the GPL status duplicating
that license information from e.g. net/can/bcm.c is fine.

Best regards,
Oliver


