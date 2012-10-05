From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC: PATCH 5/5] can: sja1000_platform: add device tree bindings
Date: Fri, 05 Oct 2012 18:58:23 +0200
Message-ID: <506F11AF.1060002@grandegger.com>
References: <1349447947-18451-1-git-send-email-mkl@pengutronix.de> <1349447947-18451-6-git-send-email-mkl@pengutronix.de> <506F0114.3010708@grandegger.com> <506F0DDD.4010101@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50184 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab2JEQ6b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 5 Oct 2012 12:58:31 -0400
In-Reply-To: <506F0DDD.4010101@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, andreas@gaisler.com, kernel@pengutronix.de

On 10/05/2012 06:42 PM, Marc Kleine-Budde wrote:
> On 10/05/2012 05:47 PM, Wolfgang Grandegger wrote:
>> Hi Marc,
...
>> Thanks for cleaning up! Unfortunately, I do not have a board with a
>> platform sja1000. Well, I have a phyCORE-PXA270, but I'm not sure if I
>> get it working with the mainline kernel quickly.
> 
> I'm more interested if the powerpc board is still working. The one you
> wrote the of platform driver in the first place.

Mainline lists finds for "nxp,sja1000":

  arch/powerpc/boot/dts/digsy_mtc.dts
  arch/powerpc/boot/dts/mpc8308_p1m.dts

I'm sorry, I don't have those customer boards any more.

Wolfgang.

