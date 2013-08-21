From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] slcan2d: add new slcan daemon
Date: Wed, 21 Aug 2013 19:46:36 +0200
Message-ID: <5214FCFC.3070404@hartkopp.net>
References: <1373536496-17141-1-git-send-email-yegorslists@googlemail.com> <CAGm1_ktaO0C7sJVFJnCs0OOgfVSkJrk1f04ez5tE=H-Db6P-bA@mail.gmail.com> <CAGm1_ksLBm-uS9SiOx+cPHim0CLM6Zg65t4am-=kL_7qgH5-6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:26712 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab3HURqn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Aug 2013 13:46:43 -0400
In-Reply-To: <CAGm1_ksLBm-uS9SiOx+cPHim0CLM6Zg65t4am-=kL_7qgH5-6Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

On 17.08.2013 21:01, Yegor Yefremov wrote:
> On Wed, Jul 24, 2013 at 2:01 PM, Yegor Yefremov
> <yegorslists@googlemail.com> wrote:
>> Hi Marc, Oliver,
>>
>> On Thu, Jul 11, 2013 at 11:54 AM,  <yegorslists@googlemail.com> wrote:
>>> From: Yegor Yefremov <yegorslists@googlemail.com>
>>>
>>> Cleaned up version of Oliver Hartkopp's effort with addition of
>>> UART speed configuration.
>>>
>>> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
>>
>> any comments/suggestions?
> 
> ping
> 

Hi Yegor,

sorry for my delayed response.

I just got through your slcan2d by diffing it with the existing slcand.

It's a cool cleanup and it adds all relevant command line options we know from
slcan_attach.c & UART settings - i think that was the idea, right?

As i can see there's no change of the functionality when the 'optional
options' are not given on the command line.

So why don't you just post a patch which makes the slcand your 'slcan2d' code?

IMHO having both the slcand and the slcan2d in the same repository does not
make sense if they behave identical when having the same (empty) options.

Or did I miss anything that slcand <tty> behaves different to slcan2d <tty> ??

Thanks & BR,
Oliver

