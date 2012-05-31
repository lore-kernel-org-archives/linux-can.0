From: Abdul Khan <akhan@symboticware.com>
Subject: Re: Strange error with jspy utility: Bus problems - Solved
Date: Thu, 31 May 2012 17:53:56 -0400
Message-ID: <CA+cPUuRbFERG6_NR9AWU93mD4MviQQezYsKaWjOCRMSm-34CaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:40041 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab2EaVx5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 31 May 2012 17:53:57 -0400
Received: by dady13 with SMTP id y13so1860447dad.19
        for <linux-can@vger.kernel.org>; Thu, 31 May 2012 14:53:56 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Hi Kurt and Oliver,

Finally, I am able to get j1939 simulator packets through can0 or can1
using candump and jspy utility.

Problem:
======
It was bit rate problem as suggested by Kurt and Oliver, simulator
supports j1939-15 ( i.e., 250kbits ), I was using 125kbits with can0
and can1.

Solution:
======
# ./ip link set can0/1 type can bitrate 250000 triple-sampling on

I was not able to get hold of board having can interfaces from last
few days, that's the reason for delayed response. My bad.

I am really appreciated to Kurt and Oliver for helping me out of the problem.

Thanks
Abdul.



On Tue, May 29, 2012 at 3:40 AM, Kurt Van Dijck <kurt.van.dijck@eia.be> wrote:
> On Sat, May 26, 2012 at 08:57:07AM +0200, Oliver Hartkopp wrote:
>>
>> >>
>> >> I don't know, Why sja1000_isa driver is giving "error warning
>> >> interrupt" and "error passive interrupt" messages. As simulator
>> >> supposed to be sent properly formatted j1939 frame to can1.
>> >>
>> >> What could be possible cause for this type of behaviour ?
>> >>
>
> I didn't focused on this at start, and lost the issue a bit.
> J1939 is supposed (by norm) to run 250kbit. You're operating j1939
> on 125kbit, which is (logically) possible, but beware interfacing
> with others!
> Are you sure your simulator is operating 125kbit?
>
> Regards,
> Kurt
