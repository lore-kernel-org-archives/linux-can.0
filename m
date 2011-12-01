From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: netdev development process - was Re: [PATCH next-next 0/2] can:
 cc770: add support for the Bosch CC770 and Intel AN82527
Date: Thu, 01 Dec 2011 10:07:43 +0100
Message-ID: <4ED743DF.1040803@grandegger.com>
References: <1322136448-7311-1-git-send-email-wg@grandegger.com>	<20111129.183950.1327835803051184146.davem@davemloft.net>	<4ED5CF14.4020502@hartkopp.net> <20111130.160727.1989923062226789802.davem@davemloft.net> <4ED73117.1020101@hartkopp.net> <4ED737AE.7030405@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:40002 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab1LAJH7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 1 Dec 2011 04:07:59 -0500
In-Reply-To: <4ED737AE.7030405@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Urs Thuermann <urs@isnogud.escape.de>, Urs Thuermann <urs.thuermann@volkswagen.de>, linux-can@vger.kernel.org

Hi Oliver,

On 12/01/2011 09:15 AM, Oliver Hartkopp wrote:
> Hello Marc and Urs,
> 
> what are your plans regarding a maintainer ship of your persons?
> 
> Urs is pretty absent and Marc is pretty active :-)
> 
> IMO we should update the MAINTAINERS file to make the responsibilities clear
> to Dave & the rest of the world.
> 
> @Urs: Should we remove you from net/can maintainers? The fact that you are
> module author of several code parts is not touched at all but your activities
> to contribute to discussions is close to zero.
> 
> @Marc/Wolfgang: What are your thoughts about that? Is Wolfgang still enough or
> would you like to share your activities?

I would appreciate if Marc would join net/can driver maintainer ship. I
do often not find the necessary time to do a good maintainer job.
Anyway, Dave asks for *one* person who acts as the one and only
interface to him. Strictly speaking this means that that person should
maintain it's own GIT tree, reviewing and applying all patches after
adding it's signed-off-by and doing the necessary compilation tests (on
x86, arm, powerpc, ...), at least. That's much more work than before and
I'm not sure if I want/can to do that.

> I think the remarks from Dave hit the point and we should really try to
> minimize confusion when talking to him in the future ...

That's what he asks for.

Wolfgang.
