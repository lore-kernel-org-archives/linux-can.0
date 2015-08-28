From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: Re: CAN implementation on A20 Allwinner
Date: Fri, 28 Aug 2015 11:22:44 +0200
Message-ID: <049dff30a92ff3b865430d8ad4327b0c@mail.rdts.de>
References: <2d24e34ceb8e4fe4b0b7c74b9a36da44@SGPMBX1006.APAC.bosch.com>
 <54770F0F.7050904@hartkopp.net>
 <369acf6bdf8b4ae3840b69bef10b5082@SGPMBX1004.APAC.bosch.com>
 <21623.28007.620480.114111@gargle.gargle.HOWL>
 <58243.88.153.236.115.1417116776.squirrel@webmail.rdts.de>
 <58560.88.153.236.115.1417118037.squirrel@webmail.rdts.de>
 <547DB29B.4070601@pengutronix.de>
 <a3cdd6d97480f7b31a53e94169f8a1eb@mail.rdts.de>
 <55DF0F39.10507@pengutronix.de>
 <c05ac4c76aad5f8e94cb98960ccfbc43@mail.rdts.de>
 <55DF1580.3070806@pengutronix.de>
 <8a0d66b660360693b2b9b4ae7da78cd4@mail.rdts.de>
 <55DF2098.4020105@pengutronix.de>
 <4c51a680055342d2a37b3459c9cb74ed@SGPMBX1011.APAC.bosch.com>
 <55DFFDE0.1060907@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:45173 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751787AbbH1JWs (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 28 Aug 2015 05:22:48 -0400
In-Reply-To: <55DFFDE0.1060907@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Misra Pankaj Kumar (RBEI/EEA2)" <Pankaj.Kumar@in.bosch.com>, Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, linux-can-owner@vger.kernel.org, linux-can@vger.kernel.org

Hi,
Am 2015-08-28 08:21, schrieb Marc Kleine-Budde:
> On 08/28/2015 07:41 AM, Misra Pankaj Kumar (RBEI/EEA2) wrote:
>> I have used CAN4Linux package with A20 Allwinner. Its working fine for 
>> me.
>> Its char device implementation.
> 
> Good. Is the A20 supported bt a generic CAN4Linux SJA1000 driver or is
> there a separate driver for it?

It's a different driver.

If nobody else has done it already I will refresh the existing sunxi-can 
driver
and fed it to the lions (SocketCAN team) :-)

> 
> regards,
> Marc

Regards

Gerd
