From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH] can: at91: remove at91_can_data
Date: Fri, 9 Oct 2015 12:51:00 +0200
Message-ID: <20151009105100.GB2666@piout.net>
References: <1444316167-25940-1-git-send-email-alexandre.belloni@free-electrons.com>
 <561791EC.7050102@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-can-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55809 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754093AbbJIKvD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Oct 2015 06:51:03 -0400
Content-Disposition: inline
In-Reply-To: <561791EC.7050102@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On 09/10/2015 at 12:07:40 +0200, Marc Kleine-Budde wrote :
> On 10/08/2015 04:56 PM, Alexandre Belloni wrote:
> > struct at91_can_data was used to pass a callback to the driver, allowing it
> > to switch the transceiver on and off. As all at91 boards are now using DT,
> > this is not used anymore, remove that structure.
> 
> One board was obviously not converted properly to DT. As I don't have to
> board to test, I'll apply this patch.
> 

Yeah, we dropped a few mostly unused and untested features when
switching to DT. I have the board but I currently don't have any way to
test CAN properly, I'll submit a patch adding regulator support for the
transceiver once it has been tested.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
