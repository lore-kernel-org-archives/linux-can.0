From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 0/6] CAN FD support
Date: Mon, 18 Jun 2012 21:14:24 +0200
Message-ID: <4FDF7E10.9050301@hartkopp.net>
References: <4FDF67B2.1090004@hartkopp.net> <4FDF7D0E.1000802@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:58560 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388Ab2FRTOX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 18 Jun 2012 15:14:23 -0400
In-Reply-To: <4FDF7D0E.1000802@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 18.06.2012 21:10, Marc Kleine-Budde wrote:

> On 06/18/2012 07:38 PM, Oliver Hartkopp wrote:
>> Hello Marc,
>>
>> here's my first real git patch series adding support for CAN with flexible
>> data rate (CAN FD).
>>
>> As there were no new remarks to my RFC v5 from 2012-05-28
>>
>> http://comments.gmane.org/gmane.linux.can/1297
>>
>> and it's tested and running on my machine for a while now it's IMHO time
>> for net-next now.
>>
>> You can also pull the series ;-)
> 
> I can pull, but David want's to have a clean tree. So I have to pull and
> rebase it on my tree.


I created a branch 'canfd' on a clone of *your* can-next.

What's not clean there?

You can pull Daves net-next and then pull the canfd branch, right?

> 
>> Git is hard for newbies but i gave my very best ...
> 
> Once you can use it, you don't want to code without it.


Yes -  it's getting better. Indeed it looks like Thunderbird mangles the mails
when editing the draft mails.

Regards,
Oliver
