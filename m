From: Jeppe Ledet-Pedersen <jlp@gomspace.com>
Subject: Re: linux-can moderated?
Date: Thu, 30 Apr 2015 19:17:00 +0200
Message-ID: <5542638C.80806@gomspace.com>
References: <5541E79A.2050508@gomspace.com> <55422C3D.3070309@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0135.outbound.protection.outlook.com ([157.56.112.135]:1750
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752359AbbD3RRM (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 30 Apr 2015 13:17:12 -0400
In-Reply-To: <55422C3D.3070309@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 30/04/15 15:21, Oliver Hartkopp wrote:
> Hi Jeppe

Hi Oliver,

> On 30.04.2015 10:28, Jeppe Ledet-Pedersen wrote:
> 
>> I just sent in my first kernel patch yesterday. It successfully found
>> its way to the linux-kernel and netdev mailing lists:
>>
>> http://www.spinics.net/lists/kernel/msg1977865.html
>> http://www.spinics.net/lists/netdev/msg326785.html
>>
>> It should also have been cc'ed to linux-can@vger.kernel.org, but as far
>> as I can see, it hasn't showed up in the linux-can list archives.
> 
> Yes.
> 
> And it showed up there automatically:
> 
> http://marc.info/?l=linux-can&m=143032208916337&w=2

Ah, thanks. I was looking at the gmane archive of linux-can (linked from
vger.kernel.org) for yesterday and couldn't find it.

http://vger.kernel.org/vger-lists.html#linux-can
http://blog.gmane.org/gmane.linux.can/day=20150429

>> I
>> believe the patch has to go in through the linux-can tree?
> 
> Yes.
> 
> Marc (see CC) will pick it up and commit it to the linux-can git tree at:
> 
> http://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can.git/
> 
> where David Miller (net maintainer) will pull it from for upstream and
> stable trees.
> 
> So for CAN drivers linux-can ML is perfect.
> No need for cross posting on Kernel/Netdev for CAN driver stuff.

Ok, thanks for the clarification. I thought I had to send it to all
addresses from the get_maintainer.pl script, but of course it makes more
sense only to send it to the most specific list. Sorry for the noise :)

>> Is the list moderated for non-subscribers?
> 
> No.
> 
>> At the time I sent the patch,
>> I wasn't subscribed to linux-can. Or did I do something else wrong?
> 
> No everything went fine :-)

Great.

> Thanks for your contribution.

Thanks for explaining this - much appreciated!

-Jeppe

