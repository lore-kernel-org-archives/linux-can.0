From: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Subject: Re: CAN implementation on A20 Allwinner
Date: Thu, 27 Aug 2015 15:04:17 +0200
Message-ID: <a3cdd6d97480f7b31a53e94169f8a1eb@mail.rdts.de>
References: <2d24e34ceb8e4fe4b0b7c74b9a36da44@SGPMBX1006.APAC.bosch.com>
 <54770F0F.7050904@hartkopp.net>
 <369acf6bdf8b4ae3840b69bef10b5082@SGPMBX1004.APAC.bosch.com>
 <21623.28007.620480.114111@gargle.gargle.HOWL>
 <58243.88.153.236.115.1417116776.squirrel@webmail.rdts.de>
 <58560.88.153.236.115.1417118037.squirrel@webmail.rdts.de>
 <547DB29B.4070601@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rdts.de ([195.243.153.28]:37324 "EHLO mail.rdts.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753422AbbH0NLe (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 27 Aug 2015 09:11:34 -0400
In-Reply-To: <547DB29B.4070601@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, Pankajkumar Misra <pankaj.kumar@in.bosch.com>, linux-can@vger.kernel.org

Hi

Am 2014-12-02 13:37, schrieb Marc Kleine-Budde:
> On 11/27/2014 08:53 PM, Gerhard Bertelsmann wrote:
>> Hi again,
>> 
>> here are some updates:
>> 
>> https://github.com/btolfa/sunxi-can-driver
> 
> It it's sja1000 compatible, it should work out of the box with the
> existing sja1000 device tree binding.

the Allwinner CAN IP is very similar but not exactly a SJA1000, e g. the
registers differ and some are 32 bit wide and not 8 bit.
So the question is: change the sja1000 and the platform file for 
"quirks"
or write a new independent one ?
Which way do you prefer or better: which driver will be accepted for 
mainline ?

> 
> Marc

Regards

Gerd

P.S.: Allwinner A20 Manual - CAN beginning at page 811
https://github.com/allwinner-zh/documents/raw/master/A20/A20_User_Manual_v1.4_20150510.pdf
