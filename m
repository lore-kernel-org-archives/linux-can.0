From: "Osborne, Paul" <Paul.Osborne@digi.com>
Subject: Re: Expose filtered CAN interface to processes
Date: Fri, 29 Jan 2016 21:53:01 +0000
Message-ID: <EB7F4954055D8D47BE2774BFC0597392301E144B@MTK-SMS-XCH02.digi.com>
References: <EB7F4954055D8D47BE2774BFC0597392301E1285@MTK-SMS-XCH02.digi.com>
 <56ABC5EE.8070100@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail1.bemta8.messagelabs.com ([216.82.243.194]:57494 "EHLO
	mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756907AbcA2VxY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 29 Jan 2016 16:53:24 -0500
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Andri Yngvason <andri.yngvason@marel.com>


Hello Oliver/Andri,

>> I am new to network namespaces; Am I missing something?  Is this a
>> real use case for network namespace support?  It sounded like there
>> was uncertainty on this point with the RFC that was posted back in
>> September by Andri: http://comments.gmane.org/gmane.linux.can/8589.
>
> Yes. I think this would be the right way to go.
>
> My current idea regarding namespace aware virtual CAN interfaces is to create
> virtual CAN interfaces inside a network namespace. These 'vcan with namespace'
> interfaces could then be connected via cangw in the initial (real world)
> namespace to other can/vcan interfaces (with/without namespace) with cangw rules.
>
> The good thing about this approach is that you can use the filter and
> modification capabilities from cangw at the same time.

Alright, good to know I am not barking up the wrong tree.  As I am
needing this functionality in the not-too-distant future, I may take a
shot at putting something together based on the work Andri has done
and your comments.

I am also putting together a change to allow for filtering on the data
of CAN messages (in combination with the can_id/mask).  I'm a bit more
skeptical of that change but may submit an RFC for that as well if the
changes end up not being too unpalatable.

Paul
