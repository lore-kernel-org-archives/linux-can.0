From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: can-next pull request for CAN ID Ematch
Date: Wed, 04 Jul 2012 13:19:10 +0200
Message-ID: <4FF426AE.3000505@volkswagen.de>
References: <4FF3C278.8040200@hartkopp.net> <4FF3DCBF.2040905@hartkopp.net> <4FF42468.5040901@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr2.volkswagen.de ([194.114.62.76]:33361 "EHLO
	mr2.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab2GDLTW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 4 Jul 2012 07:19:22 -0400
In-Reply-To: <4FF42468.5040901@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Rostislav Lisovy <lisovy@gmail.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, =?windows-1252?Q?Pavel_P=ED=9Aa?= <pisa@cmp.felk.cvut.cz>, Michal Sojka <sojkam1@fel.cvut.cz>

On 04.07.2012 13:09, Marc Kleine-Budde wrote:
> On 07/04/2012 08:03 AM, Oliver Hartkopp wrote:
>> Hi all,
>>
>> the pull location is still valid :-)
>>
>> Btw. i needed to change a minor thing as the em_canid_match() function did
>> not handle the case that the same CAN-ID can be SFF or EFF ...
>>
>> The option to support the CAN_EFF_FLAG cleared in the can_mask is broken,
>> unusual and can not be handled in a simple way.
>>
>> The tc tool can handle eff and sff rules - and so i did it in the
>> em_canid_change() function now. No support for CAN_EFF_FLAG cleared in the
>> can_mask - just check the CAN_EFF_FLAG in the filter.can_id to decide the
>> rules type.
>
> I hope I took the correct patch. Please check the for-davem branch in my
> gitorious repo[1].

Yes - it is the correct patch.

>
> I've changed some things in the commit:
> - credited Rostislav Lisovy as the original author.
>    (git commit --amend --author="Rostislav Lisovy<lisovy@gmail.com>")
> - added a "net:" in the Subject line
> - Fixed coding style issue in pkt_cls.h
>    all defines indent now with a tab

Good!

I also had some whitespace issues in Kconfig i fixed this morning ...

>
> The patch currently has these S-o-bs:
>
>      Signed-off-by: Rostislav Lisovy<lisovy@gmail.com>
>      Signed-off-by: Oliver Hartkopp<socketcan@hartkopp.net>
>      Signed-off-by: Marc Kleine-Budde<mkl@pengutronix.de>
>
> Oliver, if you want to credit your changes I can add a oneliner between
> Rostislav's and your S-o-b, which may look like this:
>
> [Oliver: fixed random stuff]

No need for that.

I'm pretty sure now that there are no obvious issues open now.
At least it's getting shorter and shorter it get's easier to review ;-)

Tnx!

Oliver

>
> [1] https://gitorious.org/linux-can/linux-can-next/commits/for-davem
>

