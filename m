From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re:  Problem of accuracy
Date: Thu, 05 Jul 2012 10:38:12 +0200
Message-ID: <4FF55274.3030006@volkswagen.de>
References: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:45169 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab2GEIiV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Jul 2012 04:38:21 -0400
In-Reply-To: <CABMxt4ijuTMYFYXx0n4AYBO6-=SRD0U3F4BTA2=rWE80Z4-yOA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mohamed HAMZAOUI <requinham@gmail.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 05.07.2012 10:12, Mohamed HAMZAOUI wrote:
> Hi,
>
> i'm a new user of socketcan and, i cross compile can-utils for my craneboard
> card (a card with CAN).
> When i run cangen with 1 ms period, the period is not respected (1,407, 1.399,
> ...) !
>
> How can i fix this problem ?
>
> my can version in /proc/net/can/version is "rev 20090105 abi 8" and i'm on
> : Linux am3517-crane 2.6.32 #1 Mon Apr 23 00:13:28 CEST 2012 armv7l GNU/Linux
>

Hello Mohamed,

first please move to the new CAN mailing list (see CC) - and don't use 
HTML-mails (text-only is better) ;-)

Regarding your problem:

Usually i get smaller derivations on my system - but your Linux box is 
probably not very fast, so that you can see these scheduling influences with 
cangen ...

cangen is a userpace app and therefore it is usually not that precise as 
hrtimers inside the Linux kernel (if you don't use any realtime Linux).

But you may try the Broadcast-Manager to place a 'cyclic sending job' inside 
the Linux kernel. See an example here:

http://svn.berlios.de/wsvn/socketcan/trunk/test/tst-bcm-cycle.c

Regards,
Oliver
