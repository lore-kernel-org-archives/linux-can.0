From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: BerliOS shutdown? - Fwd: r1278 - branches tags trunk
Date: Mon, 14 Oct 2013 18:00:57 +0200
Message-ID: <525C1539.1050902@hartkopp.net>
References: <20131011152958.914C955B0C@scm.berlios.de> <52582306.3070006@hartkopp.net> <525BB2AA.1040000@pengutronix.de> <525BB9C3.70508@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:25678 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926Ab3JNQBB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 14 Oct 2013 12:01:01 -0400
In-Reply-To: <525BB9C3.70508@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Yegor Yefremov <yegorslists@googlemail.com>

On 14.10.2013 11:30, Marc Kleine-Budde wrote:
> On 10/14/2013 11:00 AM, Marc Kleine-Budde wrote:
>>> Can you please move the stuff from socketcan/trunk/test to
>>> https://gitorious.org/linux-can/can-misc/test if you find some time?
>>
>> I'll create a seperate repository for can-test. Or as there is more than
>> one test involved,  I'd like to call the repo can-tests, analogue to
>> can-utils.
> 
> Done, https://gitorious.org/linux-can/can-tests

Thanks!

Now I can run the test_netlayer.sh script without using the BerliOS SVN ...

As this script is part of the LTP it's good to have it at gitorious now.

BR,
Oliver


